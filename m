Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUCFKjd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 05:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUCFKjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 05:39:33 -0500
Received: from av4-1-sn3.vrr.skanova.net ([81.228.9.111]:53713 "EHLO
	av4-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261634AbUCFKjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 05:39:31 -0500
To: "Dubler, Raymond" <RDubler@ksimaging.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: ide scsi dvd+rw udf kernel panic
References: <BDF8E7450E9ED311A5500090273CC5280629A4E9@mail-ksi.ksimaging.com>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Mar 2004 11:39:26 +0100
In-Reply-To: <BDF8E7450E9ED311A5500090273CC5280629A4E9@mail-ksi.ksimaging.com>
Message-ID: <m24qt2jm3l.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dubler, Raymond" <RDubler@ksimaging.com> writes:

> We are getting kernel panics while writing real-time video data (~750KBps)
> to both hard disk (Ext3) and dvd+rw media (UDF).  The hardware and software
> configuration along with the kernel oops message follow.  Any information as
> to how this is happening would be helpful.
> 
> Thanks,
> Remo
> 
> Hardware configuration:
> 	MIC E210882 motherboard (FW82815 chipset)
> 	256MB PC-100 RAM
> 	Primary IDE Master: DiamondMax Plus 8 (40GB) [cable select] /dev/hda
> udma5
> 	Primary IDE Slave:  HP 200j v1.27 DVD Writer [cable select]
> /dev/scd0 (via ide-scsi emulation) udma2
> 	
> Software configuration:
> 	Distribution: Linux From Scratch (LFS) 4.0
> 	Kernel: 2.4.20
> 	1st patch: packet-2.4.20-2.patch
> (http://w1.894.telia.com/~u89404340/patches/packet/2.4/old/)
> 	2nd patch: dvd-packet-2.4.20.patch
> (http://w1.894.telia.com/~u89404340/patches/packet/2.4/)

These patches were created before I had access to a DVD writer. Does
the newer patches work better?

        http://w1.894.telia.com/~u89404340/patches/packet/2.4/packet-2.4.23.patch.bz2
        http://w1.894.telia.com/~u89404340/patches/packet/2.4/extra/2.4.23/

The patches are based on patches I found at:

        http://dyson.kristenscatbeds.com/

Alternatively, if you only need dvd+rw support and not packed writing
support, you could try the patch from:

        http://fy.chalmers.se/~appro/linux/DVD+RW/

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
