Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVGFCgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVGFCgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVGFCeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:34:23 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:62104 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262056AbVGFCTT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:19 -0400
Subject: [PATCH] [14/48] Suspend2 2.1.9.8 for 2.6.12: 404-check-mounts-support.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:40 +1000
Message-Id: <11206164403506@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 405-clear-swapfile-bdev-in-swapoff.patch-old/mm/swapfile.c 405-clear-swapfile-bdev-in-swapoff.patch-new/mm/swapfile.c
--- 405-clear-swapfile-bdev-in-swapoff.patch-old/mm/swapfile.c	2005-07-06 11:22:01.000000000 +1000
+++ 405-clear-swapfile-bdev-in-swapoff.patch-new/mm/swapfile.c	2005-07-04 23:14:19.000000000 +1000
@@ -1162,6 +1162,7 @@ asmlinkage long sys_swapoff(const char _
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
 	p->max = 0;
+	p->bdev = NULL;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
 	p->flags = 0;

