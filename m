Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbVHSSeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbVHSSeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVHSSeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:34:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56541 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965004AbVHSSeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:34:14 -0400
Message-ID: <43062623.607@pobox.com>
Date: Fri, 19 Aug 2005 14:34:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rainer Koenig <Rainer.Koenig@fujitsu-siemens.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA status report updated
References: <4AA7B-4jm-5@gated-at.bofh.it> <4DagM-7c8-43@gated-at.bofh.it> <871x4ql24a.fsf@ABG3595C.abg.fsc.net>
In-Reply-To: <871x4ql24a.fsf@ABG3595C.abg.fsc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Koenig wrote:
> Hi Simon,
> 
> Simon Oosthoek <simon.oosthoek@ti-wmc.nl> writes:
> 
> 
>>I'm wondering how the support for the SIS 182 controller is doing, I
>>noticed they have a GPL driver on their website for kernel 2.6.10,
>>which is not a drop in replacement for sata_sis.c in 2.6.12.5, I
>>haven't tried compiling it as an add-on module outside the tree,
>>though...
> 
> 
> I tried the sources from the SiS website (that seem to add more
> details than my simple patch that just adds the device ID) as a drop
> in for the Fedora installation kernel 2.6.11-1.1369_FC4, but the
> kernel build process ran into an error at the sata_sis module. The
> problem is that the source from SiS has a conditional code that
> depends on the definition of a symbol "KERN_2_6_10" which is defined
> by their "outside build makefile", but not in the standard kernel
> build process. I added a #define KERN_2_6_10 to the source and then it
> compiled also inside the kernel build process.
> 
> 
>>Adding the 0x182 identifier to the 180 driver does compile (duh!), but
>>I haven't tried it on hardware.
> 
> 
> Working at a PC manufacturer I have access to hardware and I tried out
> a lot and didn't run into any problem so far. 
> 
> 
>>As a temporary measure, there was a patch posted to this list [1] a
>>while ago, would it be a good idea to include this while full support
>>is being worked on?
> 
> 
> Seeing that the source from the SiS website is much more going into the
> details than my simple adding of the device ID (of course SiS has hopefully
> a much deeper knowledge of their hardware than I have ;-) I would rather
> go for integrating the SiS source in the current kernel. 

Yes, that's why I have resisted the "just add the PCI ID" patches that 
have cropped up.

SiS submitted patches that duplicated portions of libata inside their 
driver, rather than simply fixing libata as would be proper.

So we are stuck in the middle :(

Someone needs to work with the SiS submission until it's kosher with the 
upstream kernel, then everybody will be happy.

	Jeff


