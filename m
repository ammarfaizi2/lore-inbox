Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUIINtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUIINtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUIINtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:49:16 -0400
Received: from checkpoint-out.gate.uni-erlangen.de ([131.188.28.69]:39624 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263851AbUIINqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:46:33 -0400
Date: Thu, 9 Sep 2004 15:45:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: Documentation update
Message-ID: <20040909134539.GA12215@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This updates documentation in -mm: we no longer have mess in swsusp
:-). Please apply,
								Pavel


--- clean-mm/Documentation/power/swsusp.txt	2004-08-24 09:01:50.000000000 +0200
+++ linux-mm/Documentation/power/swsusp.txt	2004-09-07 21:15:17.000000000 +0200
@@ -20,26 +20,6 @@
 You need to append resume=/dev/your_swap_partition to kernel command
 line. Then you suspend by echo 4 > /proc/acpi/sleep.
 
-Pavel's unreliable guide to swsusp mess
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-There are currently two versions of swap suspend in the kernel, the old
-"Pavel's" version in kernel/power/swsusp.c and the new "Patrick's"
-version in kernel/power/pmdisk.c. They provide the same functionality;
-the old version looks ugly but was tested, while the new version looks
-nicer but did not receive so much testing. echo 4 > /proc/acpi/sleep
-calls the old version, echo disk > /sys/power/state calls the new one.
-
-[In the future, when the new version is stable enough, two things can
-happen:
-
-* the new version is moved into swsusp.c, and swsusp is renamed to swap
-  suspend (Pavel prefers this)
-
-* pmdisk is kept as is and swsusp.c is removed from the kernel]
-
-
-
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Author: G‚ábor Kuti
@@ -75,10 +55,6 @@
 About the code
 
 Things to implement
-- SMP support. I've done an SMP support but since I don't have access to a kind
-  of this one I cannot test it. Please SMP people test it.  .. Tested it,
-  doesn't work. Had no time to figure out why. There is some mess with
-  interrupts AFAIK..
 - We should only make a copy of data related to kernel segment, since any
   process data won't be changed.
 - Should make more sanity checks. Or are these enough?
@@ -90,11 +66,6 @@
 - We should not free pages at the beginning so aggressively, most of them
   go there anyway..
 
-Drivers that need support
-- pc_keyb -- perhaps we can wait for vojtech's input patches
-- do IDE cdroms need some kind of support?
-- IDE CD-RW -- how to deal with that?
-
 Sleep states summary (thanx, Ducrot)
 ====================================
 
@@ -109,7 +80,8 @@
 echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
 
 
-FAQ:
+Frequently Asked Questions
+==========================
 
 Q: well, suspending a server is IMHO a really stupid thing,
 but... (Diego Zuccato):

-- 
When do you have heart between your knees?
