Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbSJHTCZ>; Tue, 8 Oct 2002 15:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263153AbSJHTB2>; Tue, 8 Oct 2002 15:01:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15888 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262602AbSJHTAJ>; Tue, 8 Oct 2002 15:00:09 -0400
Subject: PATCH: cadet needless globals
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:57:18 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzXi-0004s3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/media/radio/radio-cadet.c linux.2.5.41-ac1/drivers/media/radio/radio-cadet.c
--- linux.2.5.41/drivers/media/radio/radio-cadet.c	2002-07-20 20:11:16.000000000 +0100
+++ linux.2.5.41-ac1/drivers/media/radio/radio-cadet.c	2002-10-06 20:19:00.000000000 +0100
@@ -57,7 +57,7 @@
  */
 static __u16 sigtable[2][4]={{5,10,30,150},{28,40,63,1000}};
 
-void cadet_wake(unsigned long qnum)
+static void cadet_wake(unsigned long qnum)
 {
         switch(qnum) {
 	case 0:           /* cadet_setfreq */
