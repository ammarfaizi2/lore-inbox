Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSF3O2y>; Sun, 30 Jun 2002 10:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSF3O2x>; Sun, 30 Jun 2002 10:28:53 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:13487 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S315182AbSF3O2w>;
	Sun, 30 Jun 2002 10:28:52 -0400
Date: Sat, 29 Jun 2002 16:05:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: suspend-to-disk documentation updates
Message-ID: <20020629140529.GA576@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Please apply,
									Pavel

--- linux-swsusp.test/Documentation/swsusp.txt	Sun May 26 19:31:41 2002
+++ linux-swsusp/Documentation/swsusp.txt	Sat Jun 29 15:56:37 2002
@@ -122,11 +122,9 @@
   interrupts AFAIK..
 - We should only make a copy of data related to kernel segment, since any
   process data won't be changed.
-- By copying pages back to their original position, copy_page caused General
-  Protection Fault. Why?
 - Hardware state restoring.  Now there's support for notifying via the notify
   chain, event handlers are welcome. Some devices may have microcodes loaded
-  into them. We should have event handlers for them aswell.
+  into them. We should have event handlers for them as well.
 - We should support other architectures (There are really only some arch
   related functions..)
 - We should also restore original state of swaps if the ``noresume'' kernel
@@ -148,6 +146,15 @@
   go there anyway..
 - If X is active while suspending then by resuming calling svgatextmode
   corrupts the virtual console of X.. (Maybe this has been fixed AFAIK).
+
+Drivers we support
+- IDE disks are okay
+- vesafb
+
+Drivers that need support
+- pc_keyb -- perhaps we can wait for vojtech's input patches
+- do IDE cdroms need some kind of support?
+- IDE CD-RW -- how to deal with that?
 
 Any other idea you might have tell me!
 

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
