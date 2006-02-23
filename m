Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWBWKAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWBWKAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWBWKAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:00:18 -0500
Received: from mail.dvmed.net ([216.237.124.58]:17560 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751637AbWBWKAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:00:16 -0500
Message-ID: <43FD87A9.1010406@pobox.com>
Date: Thu, 23 Feb 2006 05:00:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Deven Balani <devenbalani@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: non-PCI based libata-SATA driver
References: <7a37e95e0602220404y7b82104ch5c3cda087336aed7@mail.gmail.com>	 <1140654191.8672.23.camel@localhost.localdomain> <7a37e95e0602222208i9a7c973vc50ac336fb174024@mail.gmail.com>
In-Reply-To: <7a37e95e0602222208i9a7c973vc50ac336fb174024@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deven Balani wrote:
>>If you look at http://zeniv.linux.org.uk/~alan/IDE you'll find the PATA
>>patches I did include some VLB and ISA devices.
> 
> Thanks a lot. I'm going through these patches and will get back to you
> in case of any problem.
> 
> I have a SATA Controller that is attached to HSX bus on ARM based
> chipset. On this side, I'm exploring the feasibilty of coming up with
> low-level libata-SATA driver (as libata is being said to support
> generic bus interface). I've gone through the SATA drivers in kernel
> code but all seem to be PCI specific.
> 
> Also, Is there any slight possiblity of doing the same with 2.4.x
> kernels (by patching the kernel or whatever)?

non-PCI works quite easily under 2.6.x, because libata core uses the 
generic DMA mapping lib.  It's already confirmed to work on at least one 
other ARM embedded chipset (sorry can't give more detail).

2.4.x is a lot of work to do non-PCI, largely because you have to deal 
with the lack of a generic DMA interface.  2.4.x libata is hardcoded to 
use PCI DMA mapping.

	Jeff



