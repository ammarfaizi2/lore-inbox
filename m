Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTEGOyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbTEGOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:54:50 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:8718 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263743AbTEGOys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:54:48 -0400
Date: Wed, 7 May 2003 17:06:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-hfsplus-devel@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] HFS+ driver
Message-ID: <Pine.LNX.4.44.0305071643030.5042-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm proud to announce a complete new version of the HFS+ fs driver. This 
work was made possible by Ardis Technologies (www.ardistech.com). It's 
based on the driver by Brad Boyer (http://sf.net/projects/linux-hfsplus).

The new driver now supports full read and write access. Perfomance has 
improved a lot, the btrees are kept in the page cache with a hash on top 
of this to speed up the access to the btree nodes.
I also added support for hard links and the resource fork is accessible 
via <file>/rsrc.

This is a beta release. I tested this a lot, so I consider it quite safe 
to use, but I can't give any guarantees at this time of course. There is 
also still a bit to do (e.g. the block allocator needs a bit more work).

The driver can be downloaded from http://www.ardistech.com/hfsplus/ .
The README describes how to build the driver.

If something should go wrong, I also have patch for Apple's diskdev_cmds 
(available from http://www.opensource.apple.com/darwinsource/10.2.5/), 
which ports newfs_hfs and fsck_hfs to Linux and fixes the endian problems. 
The patch is at http://www.ardistech.com/hfsplus/diskdev_cmds.diff.gz . 
After applying the patch the tools can be built with 'make -f 
Makefile.lnx'.

bye, Roman


