Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUBEN0D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUBEN0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:26:03 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:65415 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S265224AbUBEN0A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:26:00 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: cdwriter /dev/hdc question
Date: Thu, 5 Feb 2004 08:25:58 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402050825.58623.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.53.166] at Thu, 5 Feb 2004 07:25:59 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Running 2.6.2 atm, but for quite a while in the 2.6.x series I've had 
a line in /var/log/messages immediately after the dmesg dump 
indicating that dma was being disabled for /dev/hdc.
>From /var/log/dmesg:
---
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
[...]
hdc: CREATIVE CD-RW RW1210E, ATAPI CD/DVD-ROM drive
[...]
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
[...]
---
>From /var/log/messages, immediately after the dmesg dump:
---
Feb  4 21:30:47 coyote kernel: hdc: DMA disabled
---
However, I put an hdparm line at the bottom of rc.local that turns it 
back on and it works great, yet to see an error while burning.

So why is the kernel turning it off in the first place?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
