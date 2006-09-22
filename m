Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWIVMNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWIVMNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWIVMNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:13:21 -0400
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:7601 "EHLO
	smtp161.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S932341AbWIVMNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:13:20 -0400
Message-ID: <4513D362.8030804@gentoo.org>
Date: Fri, 22 Sep 2006 08:13:22 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Tom St Denis <tomstdenis@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sky2 eth device with Gigabyte 965P-S3 motherboard
References: <bd0cb7950609200635qae3e0c6p3f7d776d33b50542@mail.gmail.com>
In-Reply-To: <bd0cb7950609200635qae3e0c6p3f7d776d33b50542@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom St Denis wrote:
> I've been using the 2.6.17 series with "all-generic-ide irqpoll" on a
> Gigabyte 965P-S3 motherboard [using the ICH8 chipset].
> 
> It worked semi decent [other than random interrupt 177 hehehe].
> 
> However, this morning I took the same .config and applied it to 2.6.18
> with some nasties.  It compiled fine, the disks work now (my SATA
> drives also show up as /dev/sd* finally) but now the sky2 device
> disappeared.
> 
> lspci can still see it, it's a Marvell "Uknown Device 4364, rev 12"
> sitting off the PCI-E bus.

This device was not listed in the 2.6.17 sky2 driver and is not included 
in the 2.6.18 version either. Either you modified your 2.6.17 kernel or 
your distro did.

You can simply add the device ID to the list in 2.6.18. Patches to do 
this are already on their way to mainline for 2.6.19.

Daniel

