Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVBYAy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVBYAy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVBYAxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:53:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:522 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262579AbVBXXjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:39:15 -0500
Date: Fri, 25 Feb 2005 00:39:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: [2.6 patch] drivers/char/isicom.c: make a struct static
Message-ID: <20050224233913.GV8651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Alan Cox <alan@redhat.com>

---

This patch was already sent on:
- 31 Jan 2005

--- linux-2.6.11-rc2-mm2-full/drivers/char/isicom.c.old	2005-01-31 13:17:00.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/isicom.c	2005-01-31 13:17:07.000000000 +0100
@@ -381,7 +381,7 @@
 	.ioctl		= ISILoad_ioctl,
 };
 
-struct miscdevice isiloader_device = {
+static struct miscdevice isiloader_device = {
 	ISILOAD_MISC_MINOR, "isictl", &ISILoad_fops
 };
 

