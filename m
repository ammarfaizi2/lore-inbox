Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSJJIWP>; Thu, 10 Oct 2002 04:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262123AbSJJIWP>; Thu, 10 Oct 2002 04:22:15 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24068 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262122AbSJJIWO>;
	Thu, 10 Oct 2002 04:22:14 -0400
Date: Thu, 10 Oct 2002 10:25:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Unneeded task queue in suspend.h
Message-ID: <20021010082500.GA691@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

suspend_tq is not referenced anywhere. That means it can die safely.

								Pavel

--- clean/include/linux/suspend.h	2002-10-08 21:25:37.000000000 +0200
+++ linux-swsusp/include/linux/suspend.h	2002-10-08 22:12:33.000000000 +0200
@@ -43,8 +43,6 @@
 
 #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
    
-extern struct work_struct suspend_tq;
-
 /* mm/vmscan.c */
 extern int shrink_mem(void);
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
