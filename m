Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVCHF6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVCHF6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCHF5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:57:46 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:10803 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261610AbVCHF5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:57:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HpkWPUqQX9F9249UoZx59w7beZm3KNu4KPn/i7H+tcUytpaT8FJpKfLdmo1ozwd8HJlzLLSzVS2KKUuCxpCIcTnyC7FVKLYmXAm+hVDbY2R8HPP6b9nyTRGnPiPGNghF206+U49mtrbePguSSsR3Ael9CxfEg2ORQFapzgM3rdQ=
Message-ID: <9e473391050307215776f5c06@mail.gmail.com>
Date: Tue, 8 Mar 2005 00:57:33 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci_fixup_video() bogosity
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <1110256709.13607.248.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110256709.13607.248.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2005 15:38:29 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi !
> 
> While working on writing a VGA access arbiter for kernel & userland,
> I wondered how to properly get my "initial" state at boot. For that,
> I looked at how the new PCI ROM stuff does to find out who owns the
> memory shadow at c0000, and found it quite bogus.
> 
> >From what I see, the code is only based on looking at what bridges
> have VGA forwarding enabled. It doesn't test the actual IO and Memory
> enable bits of the VGA cards themselves.

Let's fix it up and make it more robust. I was playing with checking
IO/mem enable and forgot to finish it.

> What if you have 2 cards under the same bridge ?

I believe the default on x86 is to pick the one in the lowest slot
number. What happens on PPC?

-- 
Jon Smirl
jonsmirl@gmail.com
