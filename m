Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbULLPaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbULLPaK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 10:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbULLPaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 10:30:09 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:18371 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261820AbULLP36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 10:29:58 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041212152923.10901.13891.46368@localhost.localdomain>
Subject: [PATCH] riscom8: Update staus and documentation of driver
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Sun, 12 Dec 2004 09:29:01 -0600
Date: Sun, 12 Dec 2004 09:29:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I could not locate the original author or any active support effort being done.

This definitely an orphaned driver.

Diffstat output:
 Documentation/riscom8.txt |   40 +++++++++++-----------------------------
 MAINTAINERS               |    4 +---
 2 files changed, 12 insertions(+), 32 deletions(-)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-original/Documentation/riscom8.txt linux-2.6.10-rc3/Documentation/riscom8.txt
--- linux-2.6.10-rc3-original/Documentation/riscom8.txt	2004-12-03 16:52:14.000000000 -0500
+++ linux-2.6.10-rc3/Documentation/riscom8.txt	2004-12-12 10:18:52.530406544 -0500
@@ -1,5 +1,12 @@
+* NOTE - this is an unmaintained driver.  The original author cannot be located.
+
+SDL Communications is now SBS Technologies, and does not have any
+information on these ancient ISA cards on their website.
+
+James Nelson <james4765@gmail.com> - 12-12-2004
+
 	This is the README for RISCom/8 multi-port serial driver
-	(C) 1994-1996 D.Gorodchanin (pgmdsg@ibi.com)
+	(C) 1994-1996 D.Gorodchanin
 	See file LICENSE for terms and conditions.
 
 NOTE: English is not my native language. 
@@ -10,47 +17,20 @@
 1) This driver can support up to 4 boards at time.
    Use string "riscom8=0xXXX,0xXXX,0xXXX,0xXXX" at LILO prompt, for
    setting I/O base addresses for boards. If you compile driver
-   as module use insmod options "iobase=0xXXX iobase1=0xXXX iobase2=..."
+   as module use modprobe options "iobase=0xXXX iobase1=0xXXX iobase2=..."
 
 2) The driver partially supports famous 'setserial' program, you can use almost
    any of its options, excluding port & irq settings.
 
 3) There are some misc. defines at the beginning of riscom8.c, please read the 
    comments and try to change some of them in case of problems.
-	
+
 4) I consider the current state of the driver as BETA.
-   If you REALLY think you found a bug, send me e-mail, I hope I'll
-   fix it. For any other problems please ask support@sdlcomm.com.
 
 5) SDL Communications WWW page is http://www.sdlcomm.com.
 
-6) You can use the script at the end of this file to create RISCom/8 devices.
+6) You can use the MAKEDEV program to create RISCom/8 /dev/ttyL* entries.
 
 7) Minor numbers for first board are 0-7, for second 8-15, etc.
 
 22 Apr 1996.
-
--------------------------------cut here-------------------------------------
-#!/bin/bash
-NORMAL_DEVICE=/dev/ttyL
-CALLOUT_DEVICE=/dev/cuL
-NORMAL_MAJOR=48
-CALLOUT_MAJOR=49
-
-echo "Creating devices... "
-for i in 0 1 2 3; do
-	echo "Board No $[$i+1]"
-	for j in 0 1 2 3 4 5 6 7; do
-		k=$[ 8 * $i + $j]
-		rm -f $NORMAL_DEVICE$k 
-		mknod $NORMAL_DEVICE$k c $NORMAL_MAJOR $k
-		chmod a+rw $NORMAL_DEVICE$k
-		echo -n $NORMAL_DEVICE$k" "
-		rm -f $CALLOUT_DEVICE$k 
-		mknod $CALLOUT_DEVICE$k c $CALLOUT_MAJOR $k
-		chmod a+rw $CALLOUT_DEVICE$k
-		echo $CALLOUT_DEVICE$k
-	done
-done
-echo "done."
--------------------------------cut here-------------------------------------
diff -urN --exclude='*~' linux-2.6.10-rc3-original/MAINTAINERS linux-2.6.10-rc3/MAINTAINERS
--- linux-2.6.10-rc3-original/MAINTAINERS	2004-12-03 16:53:57.000000000 -0500
+++ linux-2.6.10-rc3/MAINTAINERS	2004-12-12 10:20:50.162525787 -0500
@@ -1836,9 +1836,7 @@
 S:	Maintained
 
 RISCOM8 DRIVER
-P:	Dmitry Gorodchanin
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
+S:	Orphan
 
 RTLINUX  REALTIME  LINUX
 P:	Victor Yodaiken
