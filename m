Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264334AbTCXRE3>; Mon, 24 Mar 2003 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264284AbTCXQtz>; Mon, 24 Mar 2003 11:49:55 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:45802 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264283AbTCXQa4>; Mon, 24 Mar 2003 11:30:56 -0500
Message-Id: <200303241642.h2OGg435008271@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:51 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, willy@debian.org
Subject: fix wrong return type on parisc eisa_eeprom_llseek
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/parisc/eisa_eeprom.c linux-2.5/drivers/parisc/eisa_eeprom.c
--- bk-linus/drivers/parisc/eisa_eeprom.c	2003-03-08 09:57:21.000000000 +0000
+++ linux-2.5/drivers/parisc/eisa_eeprom.c	2003-03-17 23:42:30.000000000 +0000
@@ -12,7 +12,7 @@
 
 static unsigned long eeprom_addr;
 
-static long long eisa_eeprom_llseek(struct file *file, loff_t offset, int origin )
+static loff_t eisa_eeprom_llseek(struct file *file, loff_t offset, int origin )
 {
 	switch (origin) {
 	  case 0:
