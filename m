Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbTBKLBq>; Tue, 11 Feb 2003 06:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbTBKKwt>; Tue, 11 Feb 2003 05:52:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11268 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267507AbTBKKwZ>;
	Tue, 11 Feb 2003 05:52:25 -0500
Date: Mon, 10 Feb 2003 18:11:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Explanation of sleep levels for swsusp
Message-ID: <20030210171124.GA10734@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This might be usefull to people, please apply.
								Pavel

--- clean/Documentation/swsusp.txt	2002-10-08 21:25:16.000000000 +0200
+++ linux/Documentation/swsusp.txt	2002-12-15 21:54:46.000000000 +0100
@@ -156,6 +156,20 @@
 - do IDE cdroms need some kind of support?
 - IDE CD-RW -- how to deal with that?
 
+Sleep states summary (thanx, Ducrot)
+====================================
+
+In a really perfect world:
+echo 1 > /proc/acpi/sleep       # for standby
+echo 2 > /proc/acpi/sleep       # for suspend to ram
+echo 3 > /proc/acpi/sleep       # for suspend to ram, but with more power conservative
+echo 4 > /proc/acpi/sleep       # for suspend to disk
+echo 5 > /proc/acpi/sleep       # for shutdown unfriendly the system
+
+and perhaps
+echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
+
+
 FAQ:
 
 Q: well, suspending a server is IMHO a really stupid thing,

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
