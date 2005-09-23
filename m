Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVIWFqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVIWFqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 01:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVIWFqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 01:46:14 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:62904 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751307AbVIWFqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 01:46:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jm+L8IoAK0L7jc9bfeaKmlTa7qLzrsVHeSc29ZUfawuFlmRjS0qPkkFxN64AXie4mrrUPOgCE35f25eaTRKBo4EZW4bnRx49SMb+PItA5dKxQWt4IMdhtJvwysxBY/evgiJyJ7KwiS0ZlnxVs7HX8JnKh3s7D5MspZ/IOgno5C0=
Message-ID: <43339692.7010904@gmail.com>
Date: Fri, 23 Sep 2005 13:45:54 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex B <osgxdvyg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Selecting video card on boot
References: <c7535e26050922171845708097@mail.gmail.com>
In-Reply-To: <c7535e26050922171845708097@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex B wrote:
> Hello.
> 
> I have two video card on my PC. Linux uses PCI Card as console by default.
> How can I force it to use AGP card?
> 
> I haven't BIOS capability of selecting first video card.
> 

If you need vgacon, you can't, unless you have the BIOS capability.

If you enable the framebuffer and the framebuffer console, you can select
which driver/hardware pair gets mapped to the console using the boot option:

fbcon=map:n (0 for the first framebuffer, 1 for the 2nd, etc as they would
	appear in /proc/fb)

Tony
