Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTENVF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTENVF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:05:57 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:18074 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262918AbTENVFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:05:55 -0400
Date: Wed, 14 May 2003 23:16:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Self-promotion and minor docs updates
Message-ID: <20030514211644.GA3622@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes url in ioctls, fixes some kernel parameters, kills comment
in tty that is 10+ years old and wrong, and adds me a little
credits. [I'm not sure; I thought I submitted some of those already?]

								Pavel

%patch
Index: linux/Documentation/ioctl-number.txt
===================================================================
--- linux.orig/Documentation/ioctl-number.txt	2003-05-06 19:31:10.000000000 +0200
+++ linux/Documentation/ioctl-number.txt	2003-04-25 00:43:28.000000000 +0200
@@ -174,7 +174,7 @@
 0xA0	all	linux/sdp/sdp.h		Industrial Device Project
 					<mailto:kenji@bitgate.com>
 0xA2    00-0F   DVD decoder driver      in development:
-                                        <http://linuxtv.org/dvd/api/>
+                                        <http://linuxtv.org/developer/dvdapi.html>
 0xA3	00-1F	Philips SAA7146 dirver	in development:
 					<mailto:Andreas.Beckmann@hamburg.sc.philips.com>
 0xA3	80-8F	Port ACL		in development:
Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt	2003-05-06 19:31:10.000000000 +0200
+++ linux/Documentation/kernel-parameters.txt	2003-04-16 21:33:21.000000000 +0200
@@ -361,9 +361,10 @@
 
 	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
 
-	i8042_direct	[HW] Non-translated mode
-	i8042_dumbkbd
-	i8042_noaux
+	i8042_direct	[HW] Keyboard has been put into non-translated mode 
+			by BIOS
+	i8042_dumbkbd	[HW] Don't attempt to blink the leds
+	i8042_noaux	[HW] Don't check for auxiliary (== mouse) port
 	i8042_nomux
 	i8042_reset	[HW] Reset the controller during init and cleanup
 	i8042_unlock	[HW] Unlock (ignore) the keylock
Index: linux/include/linux/tty.h
===================================================================
--- linux.orig/include/linux/tty.h	2003-05-06 19:31:10.000000000 +0200
+++ linux/include/linux/tty.h	2003-05-06 00:51:25.000000000 +0200
@@ -252,9 +252,6 @@
  * treatment, but (1) the default 80x24 is usually right and (2) it's
  * most often used by a windowing system, which will set the correct
  * size each time the window is created or resized anyway.
- * IMPORTANT: since this structure is dynamically allocated, it must
- * be no larger than 4096 bytes.  Changing TTY_FLIPBUF_SIZE will change
- * the size of this structure, and it needs to be done with care.
  * 						- TYT, 9/14/92
  */
 struct tty_struct {
Index: linux/CREDITS
===================================================================
--- linux.orig/CREDITS	2003-04-21 22:40:51.000000000 +0200
+++ linux/CREDITS	2003-05-11 12:48:24.000000000 +0200
@@ -1951,7 +1951,8 @@
 E: pavel@ucw.cz
 E: pavel@suse.cz
 D: Softcursor for vga, hypertech cdrom support, vcsa bugfix, nbd
-D: sun4/330 port, capabilities for elf, speedup for rm on ext2, USB
+D: sun4/330 port, capabilities for elf, speedup for rm on ext2, USB,
+D: work on suspend-to-ram/disk, killing duplicates from ioctl32
 S: Volkova 1131
 S: 198 00 Praha 9
 S: Czech Republic



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
