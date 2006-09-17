Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWIQBsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWIQBsF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWIQBr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:47:57 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:43654 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932165AbWIQBro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:47:44 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 9 of 11] opl4: Use SEEK_{SET, CUR,
	END} instead of hardcoded values
X-Mercurial-Node: 057a40d6079830fa6ba9cd68a6660f240820732b
Message-Id: <057a40d6079830fa6ba9.1158455375@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:35 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

opl4: Use SEEK_{SET,CUR,END} instead of hardcoded values

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r 7e68f25a3e0c -r 057a40d60798 sound/drivers/opl4/opl4_proc.c
--- a/sound/drivers/opl4/opl4_proc.c	Sat Sep 16 21:00:45 2006 -0400
+++ b/sound/drivers/opl4/opl4_proc.c	Sat Sep 16 21:00:46 2006 -0400
@@ -105,13 +105,13 @@ static long long snd_opl4_mem_proc_llsee
 					  struct file *file, long long offset, int orig)
 {
 	switch (orig) {
-	case 0: /* SEEK_SET */
+	case SEEK_SET:
 		file->f_pos = offset;
 		break;
-	case 1: /* SEEK_CUR */
+	case SEEK_CUR:
 		file->f_pos += offset;
 		break;
-	case 2: /* SEEK_END, offset is negative */
+	case SEEK_END: /* offset is negative */
 		file->f_pos = entry->size + offset;
 		break;
 	default:


