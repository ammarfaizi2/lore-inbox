Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270253AbRHMPWO>; Mon, 13 Aug 2001 11:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270252AbRHMPWF>; Mon, 13 Aug 2001 11:22:05 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:18192 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S270250AbRHMPWA>;
	Mon, 13 Aug 2001 11:22:00 -0400
Date: Mon, 13 Aug 2001 17:22:11 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.4.8 and 2.4.8-ac2] sonypi driver documentation updates.
Message-ID: <20010813172211.K24523@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates the documentation for the sonypi driver, 
reporting some issues found by several users.

Linus, Alan, please apply.

--- linux-2.4.8-ac2.orig/Documentation/sonypi.txt	Wed Jul  4 23:41:33 2001
+++ linux-2.4.8-ac2/Documentation/sonypi.txt	Mon Aug 13 17:19:34 2001
@@ -65,6 +65,19 @@
 Bugs:
 -----
 
+	- several users reported that this driver disables the BIOS-managed
+	  Fn-keys which put the laptop in sleeping state, or switch the
+	  external monitor on/off. There is no workaround yet, since this
+	  driver disables all APM management for those keys, by enabling the
+	  ACPI management (and the ACPI core stuff is not complete yet). If
+	  you have one of those laptops with working Fn keys and want to 
+	  continue to use them, don't use this driver.
+
+	- some users reported that the laptop speed is lower (dhrystone
+	  tested) when using the driver with the fnkeyinit parameter. I cannot
+	  reproduce it on my laptop and not all users have this problem.
+	  Still under investigation.
+	
 	- since all development was done by reverse engineering, there is
 	  _absolutely no guarantee_ that this driver will not crash your
 	  laptop. Permanently.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
