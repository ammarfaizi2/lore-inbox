Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVCYHz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVCYHz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVCYHz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:55:28 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:48548 "EHLO
	webhosting.rdsbv.ro") by vger.kernel.org with ESMTP id S261530AbVCYHzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:55:17 -0500
Date: Fri, 25 Mar 2005 09:55:00 +0200 (EET)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@webhosting.rdsbv.ro
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Tejun Heo <tj@home-tj.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFT, PATCH] sata_sil corruption / lockup fix
In-Reply-To: <4243BA4A.4050307@pobox.com>
Message-ID: <Pine.LNX.4.62.0503250951150.13240@webhosting.rdsbv.ro>
References: <4243BA4A.4050307@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Silicon Image contributed a patch which should help some of the situations 
> that users were seeing.  If you are having problems with sata_sil, please do 
> try out this patch.
>
> I'm concerned that the sata_sil blacklist has been growing beyond the older 
> Seagate drives which definitely had buggy firmware; concerned that the 
> Mod15Write fix was simply "fixing" the problem addressed by this patch, 
> simply by hiding the problem behind slow performance.  [note: the only way to 
> really know for sure is with ATA bus traces]

Hello, Jeff!

Yes, you are right that the list grew too much.
I, for example, have a sil 3112 controller that made problems (mod15) in 
the past (crash on big tranfers). But I upgraded the BIOS (and it shows me 
that even sil firmware was updated) and the problem disappeard.

So, I'll be glad to test this patch, but I can't because now it works very 
good (I manualy remove the disks from blaklist because they have a match 
in the list).

Thanks goes to Silicon Image people that, finally, they release a patch to 
fix this problem.

My motherboard is Intel.

Thanks Jeff.

> On platforms where the SiI BIOS isn't executed (non-x86), this patch is 
> probably more critical.  On x86, it is purported to only be needed on a 
> single motherboard.
>
> Test results (to linux-ide@vger.kernel.org) would be appreciated, 
> particularly from users with newer Seagate drives.
>
> Finally, there are also a few reports of problems of "screaming interrupts" 
> on configurations with SiI 311x + Seagate NCQ drives.  This is a separate 
> problem, and I haven't looked into it yet.
>
> 	Jeff
>
>
>
>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
