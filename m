Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319011AbSH1WEv>; Wed, 28 Aug 2002 18:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319014AbSH1WEr>; Wed, 28 Aug 2002 18:04:47 -0400
Received: from [195.39.17.254] ([195.39.17.254]:10368 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319011AbSH1WDt>;
	Wed, 28 Aug 2002 18:03:49 -0400
Date: Thu, 29 Aug 2002 00:06:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: input u-cleanup
Message-ID: <20020828220603.GA30107@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

proc is clever enough not to need ifdefs, so this is probably good
idea...

								Pavel

--- clean/drivers/input/input.c	Wed Aug 28 22:38:46 2002
+++ linux-swsusp/drivers/input/input.c	Wed Aug 28 23:28:23 2002
@@ -800,11 +803,9 @@
 
 static void __exit input_exit(void)
 {
-#ifdef CONFIG_PROC_FS
 	remove_proc_entry("devices", proc_bus_input_dir);
 	remove_proc_entry("handlers", proc_bus_input_dir);
 	remove_proc_entry("input", proc_bus);
-#endif
 	devfs_unregister(input_devfs_handle);
         if (unregister_chrdev(INPUT_MAJOR, "input"))
                 printk(KERN_ERR "input: can't unregister char major %d", INPUT_MAJOR);

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
