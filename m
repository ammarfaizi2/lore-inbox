Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbUL2Bkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUL2Bkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 20:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbUL2Bkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 20:40:49 -0500
Received: from mail.dif.dk ([193.138.115.101]:41921 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261278AbUL2Bkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 20:40:43 -0500
Date: Wed, 29 Dec 2004 02:51:46 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch] missing printk loglevel and tiny tiny whitespace change in
 binfmt_elf()
Message-ID: <Pine.LNX.4.61.0412290248170.3528@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch adds a mising printk loglevel (I think KERN_WARNING is appropriate 
here) in fs/binfmt_elf.c, and while I was there I made some tiny tiny tiny 
adjustments to whitespacing in the neighborhood.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-orig/fs/binfmt_elf.c linux-2.6.10/fs/binfmt_elf.c
--- linux-2.6.10-orig/fs/binfmt_elf.c	2004-12-24 22:34:33.000000000 +0100
+++ linux-2.6.10/fs/binfmt_elf.c	2004-12-29 02:46:39.000000000 +0100
@@ -1556,17 +1556,17 @@ static int elf_core_dump(long signr, str
 	ELF_CORE_WRITE_EXTRA_DATA;
 #endif
 
-	if ((off_t) file->f_pos != offset) {
+	if ((off_t)file->f_pos != offset) {
 		/* Sanity check */
-		printk("elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
-		       (off_t) file->f_pos, offset);
+		printk(KERN_WARNING "elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
+		       (off_t)file->f_pos, offset);
 	}
 
 end_coredump:
 	set_fs(fs);
 
 cleanup:
-	while(!list_empty(&thread_list)) {
+	while (!list_empty(&thread_list)) {
 		struct list_head *tmp = thread_list.next;
 		list_del(tmp);
 		kfree(list_entry(tmp, struct elf_thread_status, list));



