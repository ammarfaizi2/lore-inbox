Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272745AbTHKQEC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272772AbTHKQCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:02:41 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:12838 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272745AbTHKP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:41 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse annotations for MSR driver
Message-Id: <E19mF4Y-0005Ea-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/msr.c linux-2.5/arch/i386/kernel/msr.c
--- bk-linus/arch/i386/kernel/msr.c	2003-05-15 12:44:46.000000000 +0100
+++ linux-2.5/arch/i386/kernel/msr.c	2003-07-13 16:55:50.000000000 +0100
@@ -187,7 +187,7 @@ static loff_t msr_seek(struct file *file
   return ret;
 }
 
-static ssize_t msr_read(struct file * file, char * buf,
+static ssize_t msr_read(struct file * file, char __user * buf,
 			size_t count, loff_t *ppos)
 {
   u32 *tmp = (u32 *)buf;
@@ -212,7 +212,7 @@ static ssize_t msr_read(struct file * fi
   return ((char *)tmp) - buf;
 }
 
-static ssize_t msr_write(struct file * file, const char * buf,
+static ssize_t msr_write(struct file * file, const char __user * buf,
 			 size_t count, loff_t *ppos)
 {
   const u32 *tmp = (const u32 *)buf;
