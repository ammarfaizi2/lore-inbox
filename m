Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267772AbTAIVpx>; Thu, 9 Jan 2003 16:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267984AbTAIVpx>; Thu, 9 Jan 2003 16:45:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8452 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267772AbTAIVpp>;
	Thu, 9 Jan 2003 16:45:45 -0500
Date: Thu, 9 Jan 2003 22:52:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: acpi_button misses some static's
Message-ID: <20030109215252.GA13474@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds them, please apply.
								Pavel
--- clean/drivers/acpi/button.c	2002-12-25 23:59:15.000000000 +0100
+++ linux-swsusp/drivers/acpi/button.c	2003-01-06 00:11:23.000000000 +0100
@@ -68,8 +68,8 @@
 MODULE_LICENSE("GPL");
 
 
-int acpi_button_add (struct acpi_device *device);
-int acpi_button_remove (struct acpi_device *device, int type);
+static int acpi_button_add (struct acpi_device *device);
+static int acpi_button_remove (struct acpi_device *device, int type);
 static int acpi_button_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_button_driver = {
@@ -236,7 +236,7 @@
 }
 
 
-int
+static int
 acpi_button_add (
 	struct acpi_device	*device)
 {
@@ -386,7 +386,7 @@
 }
 
 
-int
+static int
 acpi_button_remove (struct acpi_device *device, int type)
 {
 	acpi_status		status = 0;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
