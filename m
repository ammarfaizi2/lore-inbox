Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVA0Nqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVA0Nqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 08:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVA0Nqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 08:46:47 -0500
Received: from news.suse.de ([195.135.220.2]:25480 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262619AbVA0Nqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 08:46:46 -0500
Date: Thu, 27 Jan 2005 14:46:40 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] use misc dynamic minor for sonypi driver
Message-ID: <20050127134640.GA25549@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whats the reason for using -1 as minor number?
No idea if that works well, it probably does.
Maybe add a comment if -1 is supposed to work.


--- ../linux-2.6.11-rc2/drivers/char/sonypi.c	2005-01-22 02:48:34.000000000 +0100
+++ ./drivers/char/sonypi.c	2005-01-27 14:40:47.873882682 +0100
@@ -649,7 +649,7 @@
 };
 
 struct miscdevice sonypi_misc_device = {
-	.minor		= -1,
+	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= "sonypi",
 	.fops		= &sonypi_misc_fops,
 };
