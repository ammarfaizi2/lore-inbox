Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262777AbRE0G6Q>; Sun, 27 May 2001 02:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262778AbRE0G6G>; Sun, 27 May 2001 02:58:06 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:14742 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262777AbRE0G5r>; Sun, 27 May 2001 02:57:47 -0400
Date: Sat, 26 May 2001 23:57:28 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: Re: Linux-2.4.5 and Reiserfs, oops!
In-Reply-To: <Pine.GSO.4.21.0105270151060.1945-100000@weyl.math.psu.edu>
To: viro@math.psu.edu (Alexander Viro)
Cc: linux-kernel@vger.kernel.org
Message-id: <200105270657.f4R6vTU05995@wellhouse.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's... interesting. With that patch changes to fs/super.c should make
> no difference whatsoever.
> 
> OK, can you reproduce NFS lockup on 2.4.5-pre5 (without that patch)
> and on 2.4.5-pre3 (ditto)? 
> 
> There were NFS changes in -pre4 and -pre5 and umount ones in -pre6. The
> latter need the patch I've posted, so vanilla -pre5 and -pre3 are the
> first candidates for checking.

Well the first thing I checked was vanilla 2.4.5, and I managed to
bring that down hard too. It has nothing at all to do with reiserfs,
but may be related to USB instead. I have been able to reproduce the
problem by doing the following:

a) Booting with X on vc/2
b) Logging into vc/6 instead
c) Mounting a filesystem on my USB Zip drive
d) Unmounting the filesystem again
e) Unmounting the NFS mount
f) Executing "rmmod -a" twice to clean out the now-unused modules
(e.g. sd_mod, scsi_mod, usb-storage)
g) Trying to switch back to vc/2
h) Oops!

2.4.4 seems OK; I guess I'll have to build those -pre kernels now.

Chris
