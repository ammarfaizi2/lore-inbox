Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSJ2AHp>; Mon, 28 Oct 2002 19:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJ2AHo>; Mon, 28 Oct 2002 19:07:44 -0500
Received: from mail0.jaist.ac.jp ([150.65.5.97]:48847 "EHLO mail0.jaist.ac.jp")
	by vger.kernel.org with ESMTP id <S261427AbSJ2AHm>;
	Mon, 28 Oct 2002 19:07:42 -0500
Date: Tue, 29 Oct 2002 09:13:55 +0900 (JST)
Message-Id: <20021029.091355.41631341.amatsus@jaist.ac.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add Intel cache-detection descriptors to the table
From: Akihiro Matsushima <amatsus@jaist.ac.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new discriptors to IA-32 cache-detection table
and fixes a failure in L2 cache detection on 2.4.20-pre series.

Thanks,
Akihiro

--- arch/i386/kernel/setup.c.orig	Sat Oct 19 10:30:52 2002
+++ arch/i386/kernel/setup.c	Sat Oct 19 10:40:16 2002
@@ -2202,6 +2202,8 @@
 	{ 0x23, LVL_3,      1024 },
 	{ 0x25, LVL_3,      2048 },
 	{ 0x29, LVL_3,      4096 },
+	{ 0x39, LVL_2,      128 },
+	{ 0x3C, LVL_2,      256 },
 	{ 0x41, LVL_2,      128 },
 	{ 0x42, LVL_2,      256 },
 	{ 0x43, LVL_2,      512 },
@@ -2214,7 +2216,9 @@
 	{ 0x7A, LVL_2,      256 },
 	{ 0x7B, LVL_2,      512 },
 	{ 0x7C, LVL_2,      1024 },
+	{ 0x7E, LVL_2,      256 },
 	{ 0x82, LVL_2,      256 },
+	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
 	{ 0x85, LVL_2,      2048 },
 	{ 0x00, 0, 0}
