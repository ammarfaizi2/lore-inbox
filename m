Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWIQBst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWIQBst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWIQBsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:48:05 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:47750 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932165AbWIQBr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:47:58 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 11 of 11] mixart: Use SEEK_{SET, CUR,
	END} instead of hardcoded values
X-Mercurial-Node: 9ef3df8b70fe0957fedcbec508934d27b196fd68
Message-Id: <9ef3df8b70fe0957fedc.1158455377@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:37 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mixart: Use SEEK_{SET,CUR,END} instead of hardcoded values

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r f255d0d208e7 -r 9ef3df8b70fe sound/pci/mixart/mixart.c
--- a/sound/pci/mixart/mixart.c	Sat Sep 16 21:00:46 2006 -0400
+++ b/sound/pci/mixart/mixart.c	Sat Sep 16 21:00:46 2006 -0400
@@ -1109,13 +1109,13 @@ static long long snd_mixart_BA0_llseek(s
 	offset = offset & ~3; /* 4 bytes aligned */
 
 	switch(orig) {
-	case 0:  /* SEEK_SET */
+	case SEEK_SET:
 		file->f_pos = offset;
 		break;
-	case 1:  /* SEEK_CUR */
+	case SEEK_CUR:
 		file->f_pos += offset;
 		break;
-	case 2:  /* SEEK_END, offset is negative */
+	case SEEK_END: /* offset is negative */
 		file->f_pos = MIXART_BA0_SIZE + offset;
 		break;
 	default:
@@ -1135,13 +1135,13 @@ static long long snd_mixart_BA1_llseek(s
 	offset = offset & ~3; /* 4 bytes aligned */
 
 	switch(orig) {
-	case 0:  /* SEEK_SET */
+	case SEEK_SET:
 		file->f_pos = offset;
 		break;
-	case 1:  /* SEEK_CUR */
+	case SEEK_CUR:
 		file->f_pos += offset;
 		break;
-	case 2: /* SEEK_END, offset is negative */
+	case SEEK_END: /* offset is negative */
 		file->f_pos = MIXART_BA1_SIZE + offset;
 		break;
 	default:


