Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVAaMpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVAaMpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVAaMpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:45:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51719 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261176AbVAaMnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:43:52 -0500
Date: Mon, 31 Jan 2005 13:43:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/isicom.c: make a struct static
Message-ID: <20050131124350.GG18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-full/drivers/char/isicom.c.old	2005-01-31 13:17:00.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/isicom.c	2005-01-31 13:17:07.000000000 +0100
@@ -381,7 +381,7 @@
 	.ioctl		= ISILoad_ioctl,
 };
 
-struct miscdevice isiloader_device = {
+static struct miscdevice isiloader_device = {
 	ISILOAD_MISC_MINOR, "isictl", &ISILoad_fops
 };
 

