Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTARCxb>; Fri, 17 Jan 2003 21:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTARCxa>; Fri, 17 Jan 2003 21:53:30 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:61149 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262190AbTARCx1>; Fri, 17 Jan 2003 21:53:27 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 17 Jan 2003 19:02:14 -0800
Message-Id: <200301180302.TAA04272@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.59/fs/devfs shrink
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	An updated version of my patch to shrink devfs by replacing
its filesystem operations with code derived from ramfs is now FTPable
from the following URL.  Christoph Hellwig got my fs/devfs/util.c
changes integrated in to 2.5.59 along with some other cleanups of his,
so there no longer any change to util.c in my patch, and now only one
line is changed in include/linux/fs/devfs_fs_kernel.h.  The patch is a
net deletion of 2447 lines.

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.59-v8.patch


	Also, there is a new 0.2 version of devfs_helper (partial
devfsd replacment) FTPable the following URL.  The only difference is
a fix to a bug where an extra character was being copied in rules that
involved expanding regular expression matches.

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/devfs_helper-0.2.tar.gz

	Although I'd personally like to see my patch integrated into
2.5, the only bug that I think it fixes is extremely obscure (a module
unload race for character devices that probably nobody will hit), and
nothing else relies on it.  I'm happy to keep people updated by
posting new versions of this patch as necessary until 2.7 opens up,
although, as I said, I also wouldn't mind seeing it integrated
earlier.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
