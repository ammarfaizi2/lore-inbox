Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263161AbSJHTEY>; Tue, 8 Oct 2002 15:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbSJHTDq>; Tue, 8 Oct 2002 15:03:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17424 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263161AbSJHTBf>; Tue, 8 Oct 2002 15:01:35 -0400
Subject: PATCH: untqueue aironet
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:58:34 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzYw-0004se-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/aironet4500_card.c linux.2.5.41-ac1/drivers/net/aironet4500_card.c
--- linux.2.5.41/drivers/net/aironet4500_card.c	2002-10-07 22:12:24.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/aironet4500_card.c	2002-10-08 00:45:56.000000000 +0100
@@ -22,7 +22,6 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/tqueue.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/aironet4500.h linux.2.5.41-ac1/drivers/net/aironet4500.h
--- linux.2.5.41/drivers/net/aironet4500.h	2002-10-07 22:12:24.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/aironet4500.h	2002-10-08 00:44:01.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/time.h>
 */
 #include <linux/802_11.h>
+#include <linux/workqueue.h>
 
 //damn idiot PCMCIA stuff
 #ifndef DEV_NAME_LEN
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/aironet4500_proc.c linux.2.5.41-ac1/drivers/net/aironet4500_proc.c
--- linux.2.5.41/drivers/net/aironet4500_proc.c	2002-10-02 21:33:29.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/aironet4500_proc.c	2002-10-08 00:46:20.000000000 +0100
@@ -17,7 +17,6 @@
 #include <linux/version.h>
 
 #include <linux/sched.h>
-#include <linux/tqueue.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
