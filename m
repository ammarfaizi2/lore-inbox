Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTJDBkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 21:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTJDBkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 21:40:24 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:57028 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261696AbTJDBkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 21:40:21 -0400
Date: Fri, 3 Oct 2003 21:43:39 -0400
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1: XFS compile fix
Message-ID: <20031004014338.GA16745@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/xfs/support/Makefile lost a line between 2.4.22aa1 and 2.4.23pre6aa1.

make says:

fs/fs.o: In function `xfs_attr_shortform_list':
fs/fs.o(.text+0xad95a): undefined reference to `qsort'
fs/fs.o: In function `xfs_dir2_sf_to_block':
fs/fs.o(.text+0xc76ee): undefined reference to `qsort'
fs/fs.o: In function `xfs_dir_shortform_getdents':
fs/fs.o(.text+0xceb41): undefined reference to `qsort'
make: *** [vmlinux] Error 1


--- linux-2.4.23pre6aa1/fs/xfs/support/Makefile	Fri Oct  3 21:50:36 2003
+++ linux/fs/xfs/support/Makefile	Fri Oct  3 21:47:56 2003
@@ -48,6 +48,7 @@
 				   ktrace.o \
 				   move.o \
 				   mrlock.o \
+				   qsort.o \
 				   uuid.o
 
 include $(TOPDIR)/Rules.make


-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

