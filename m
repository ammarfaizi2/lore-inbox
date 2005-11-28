Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVK1U5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVK1U5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVK1U5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:57:06 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:27495 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750874AbVK1U5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:57:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=b4kJYNSwy+bc+YMevo64LZYrwg5Vjx9SQzAU6KXhwuYoGXLULqh9ZtcaqiApv3+j7kDFpmYRtegdipW83OpjuG9cG095YXJ/TyRynRHjnFxwmhOh35A1eusq1dnEP+4/5s6N45rfO96B59ONVdZv0USj8HqvbnlN5KAMeaSV7zI=
Date: Mon, 28 Nov 2005 21:56:44 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <1653628458.20051128215644@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re[2]: net_device + pci_dev question
In-Reply-To: <1133126713.2853.45.camel@laptopd505.fenrus.org>
References: <2510370984.20051127205827@gmail.com>
 <1133126713.2853.45.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan,

On 27th november 2005 (22:25:13) you wrote:

> On Sun, 2005-11-27 at 20:58 +0100, Mateusz Berezecki wrote:
>> Hello List!
>> 
>> Having only net_device pointer is it possible to retrieve associated pci_dev
>> pointer basing on this information only?

> what do you need it for?

for pci_alloc_consistent() which takes pci_dev as a first argument to
allocate contiguous memory block for DMA transfers. I just realized
when I saw your answer that I might have moved the memory allocation to
some routine which is called earlier in time which has access to
pci_dev pointer directly, like net_device->init IIRC. But I'm not
really sure if that would be correct solution.

> (and.. what if the nic isn't a pci one?)

Uh... it's cardbus interface and still uses pci_* stuff without problems. (?)
Do I miss something?

kind regards
Mateusz Berezecki

