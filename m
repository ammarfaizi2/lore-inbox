Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbSLRWTB>; Wed, 18 Dec 2002 17:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbSLRWSa>; Wed, 18 Dec 2002 17:18:30 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9988 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267448AbSLRWRz>;
	Wed, 18 Dec 2002 17:17:55 -0500
Date: Wed, 18 Dec 2002 23:24:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: One-liner to make S4 work
Message-ID: <20021218222442.GA337@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should make swsusp to work on 2.5.52...

								Pavel

--- clean/mm/page_alloc.c	2002-12-18 22:21:13.000000000 +0100
+++ linux-swsusp/mm/page_alloc.c	2002-12-18 22:30:47.000000000 +0100
@@ -389,7 +389,7 @@
 	unsigned long flags;
 	struct page *page = NULL;
 
-	if (order == 0) {
+	if ((order == 0) && !cold) {
 		struct per_cpu_pages *pcp;
 
 		pcp = &zone->pageset[get_cpu()].pcp[cold];

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
