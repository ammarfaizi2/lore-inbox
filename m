Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289824AbSBSUVx>; Tue, 19 Feb 2002 15:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289823AbSBSUVo>; Tue, 19 Feb 2002 15:21:44 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:57354 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S289820AbSBSUVb>;
	Tue, 19 Feb 2002 15:21:31 -0500
Date: Tue, 19 Feb 2002 20:41:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: trivial@rustcorp.com.au
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Tiny IDE cleanup
Message-ID: <20020219194155.GA5468@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What about this tiny cleanup? Its against 2.4., but applicable to 2.5,
too.

								Pavel

--- clean.2.4/include/linux/ide.h	Mon Nov  5 21:43:28 2001
+++ linux-swsusp.24/include/linux/ide.h	Tue Feb 19 20:38:38 2002
@@ -697,11 +698,9 @@
  * structure directly (the allocation/layout may change!).
  *
  */
-#ifndef _IDE_C
 extern	ide_hwif_t	ide_hwifs[];		/* master data repository */
 extern	ide_module_t	*ide_modules;
 extern	ide_module_t	*ide_probe;
-#endif
 extern int noautodma;
 
 /*
@@ -900,10 +899,8 @@
 void do_ide_request (request_queue_t * q);
 void ide_init_subdrivers (void);
 
-#ifndef _IDE_C
 extern struct block_device_operations ide_fops[];
 extern ide_proc_entry_t generic_subdriver_entries[];
-#endif
 
 #ifdef _IDE_C
 #ifdef CONFIG_BLK_DEV_IDE

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
