Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUKIEUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUKIEUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 23:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUKIEUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 23:20:42 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:391 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261259AbUKIEUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 23:20:31 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@redhat.com, james4765@verizon.net
Message-Id: <20041109042030.11446.55146.88799@localhost.localdomain>
Subject: [PATCH] md: Documentation/md.txt update
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [70.16.226.208] at Mon, 8 Nov 2004 22:20:30 -0600
Date: Mon, 8 Nov 2004 22:20:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update status of superblock formats and fix misspellings in Documentation/md.txt

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/md.txt linux-2.6.9/Documentation/md.txt
--- linux-2.6.9-original/Documentation/md.txt	2004-10-18 17:54:38.000000000 -0400
+++ linux-2.6.9/Documentation/md.txt	2004-11-08 23:06:51.131605977 -0500
@@ -55,13 +55,13 @@
 ------------------
 
 The md driver can support a variety of different superblock formats.
-(It doesn't yet, but it can)
+Currently, it supports superblock formats "0.90.0" and the "md-1" format
+introduced in the 2.5 development series.
 
-The kernel does *NOT* autodetect which format superblock is being
-used. It must be told.
+The kernel will autodetect which format superblock is being used.
 
 Superblock format '0' is treated differently to others for legacy
-reasons.
+reasons - it is the original superblock format.
 
 
 General Rules - apply for all superblock formats
@@ -69,6 +69,7 @@
 
 An array is 'created' by writing appropriate superblocks to all
 devices.
+
 It is 'assembled' by associating each of these devices with an
 particular md virtual device.  Once it is completely assembled, it can
 be accessed.
@@ -76,10 +77,10 @@
 An array should be created by a user-space tool.  This will write
 superblocks to all devices.  It will usually mark the array as
 'unclean', or with some devices missing so that the kernel md driver
-can create approrpriate redundancy (copying in raid1, parity
+can create appropriate redundancy (copying in raid1, parity
 calculation in raid4/5).
 
-When an array is assembled, it is first initialised with the
+When an array is assembled, it is first initialized with the
 SET_ARRAY_INFO ioctl.  This contains, in particular, a major and minor
 version number.  The major version number selects which superblock
 format is to be used.  The minor number might be used to tune handling
@@ -101,15 +102,16 @@
 
 
 Specific Rules that apply to format-0 super block arrays, and
-       arrays with no superblock (non-persistant).
+       arrays with no superblock (non-persistent).
 -------------------------------------------------------------
 
 An array can be 'created' by describing the array (level, chunksize
 etc) in a SET_ARRAY_INFO ioctl.  This must has major_version==0 and
 raid_disks != 0.
-Then uninitialised devices can be added with ADD_NEW_DISK.  The
+
+Then uninitialized devices can be added with ADD_NEW_DISK.  The
 structure passed to ADD_NEW_DISK must specify the state of the device
 and it's role in the array.
 
-One started with RUN_ARRAY, uninitialised spares can be added with
+One started with RUN_ARRAY, uninitialized spares can be added with
 HOT_ADD_DISK.
