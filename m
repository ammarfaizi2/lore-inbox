Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313472AbSC3PdW>; Sat, 30 Mar 2002 10:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313473AbSC3PdM>; Sat, 30 Mar 2002 10:33:12 -0500
Received: from smtp2.libero.it ([193.70.192.52]:10978 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S313472AbSC3Pcz>;
	Sat, 30 Mar 2002 10:32:55 -0500
Message-ID: <3CA5D8DF.9C88FECE@denise.shiny.it>
Date: Sat, 30 Mar 2002 16:25:19 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.13-pre1 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: loop & hfs
In-Reply-To: <3BD9F4CB.350C13C3@randomlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an HFS (apple) filesystem on a megneto-optical disk. When I try
to mount is with: "mount -o loop -t hfs /dev/sdb3 /mnt/mo" it fails:

Mar 30 16:07:17 Jay kernel: sd.c:Bad block number requested I/O error: dev
08:13, sector 2
Mar 30 16:07:17 Jay kernel: hfs_fs: unable to read block 0x00000002 from dev
07:00
Mar 30 16:07:17 Jay kernel: hfs_fs: Unable to read superblock
Mar 30 16:07:17 Jay kernel: sd.c:Bad block number requested I/O error: dev
08:13, sector 0
Mar 30 16:07:17 Jay kernel: hfs_fs: unable to read block 0x00000000 from dev
07:00
Mar 30 16:07:17 Jay kernel: hfs_fs: Unable to read block 0.

8:13 is sdb3. Why does it try to read something from dev 07:00 (/dev/vcs0) ?!?
When I do the same thing with a CDROM everything works fine. Both CD and MO
are
connected to the same SCSI controller (adaptec 2930) and block size is 2048.
I have to use the loop device because HFS wants block size=512.

Linux 2.4.13-pre1 and 2.4.19-pre2, PowerPC 750.


Bye.

