Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSLCXoT>; Tue, 3 Dec 2002 18:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSLCXoT>; Tue, 3 Dec 2002 18:44:19 -0500
Received: from ucsu.Colorado.EDU ([128.138.129.83]:12162 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S266640AbSLCXoS>; Tue, 3 Dec 2002 18:44:18 -0500
Date: Tue, 3 Dec 2002 16:51:46 -0700 (MST)
From: Sonal Bhushan <sonal.bhushan@Colorado.EDU>
To: linux-kernel@vger.kernel.org
Subject: problems with putting an rtlinux kernel on a 686 on a PC104 board
In-Reply-To: <Pine.GSO.4.40.0212031646060.22897-100000@ucsu.colorado.edu>
Message-ID: <Pine.GSO.4.40.0212031650440.25032-100000@ucsu.colorado.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

I'm trying to install a linux kernel on a 686 on a PC 104 board (it is
intended to fly on a UAV). it has a 33MB Flash Disk (which is the only
hard disk on the computer). i compile the kernel on a host machine (which
has red hat 7.3 , with rt linux on top of it), and then make a bzdisk. so
far so good. when i try to boot the pc104 machine with the floppy though,
it comes up with the following error:

hda3: bad access: block=2, count=2
end_request: I/O error, dev 03:03 (hda), sector 2
EXT3-fs: unable to read superblock
hda3: bad access: block=2, count=2
end_request: I/O error, dev 03:03 (hda), sector 2
EXT3-fs: unable to read superblock
hda3: bad access: block=64, count=2
end_request: I/O error, dev 03:03 (hda), sector 64
EXT3-fs: unable to read superblock
isofs_read_super: bread failed, dev=03:03, iso_blknum=16, block=32
Kernel panic: VFS: Unable to mount root fs on 03:03


I tried looking up this error on mailing list archives, and it seems a
possible solution is to try passing "ide=reverse" as a kernel option. i'm
not sure when to do that though, because the pc104 is booting directly
from the bzdisk, and does not give me a chance to enter any command line
options.

i'm a newbie when it comes to compiling kernels, so any help would be
appreciated!

thanks,
sonal


