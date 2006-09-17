Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWIQBsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWIQBsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWIQBsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:48:08 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:51141 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932184AbWIQBr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:47:57 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 11] gus: Use SEEK_{SET, CUR,
	END} instead of hardcoded values
X-Mercurial-Node: f255d0d208e7f7c78db47743b6a88667a079aeae
Message-Id: <f255d0d208e7f7c78db4.1158455376@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:36 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gus: Use SEEK_{SET,CUR,END} instead of hardcoded values

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r 057a40d60798 -r f255d0d208e7 sound/isa/gus/gus_mem_proc.c
--- a/sound/isa/gus/gus_mem_proc.c	Sat Sep 16 21:00:46 2006 -0400
+++ b/sound/isa/gus/gus_mem_proc.c	Sat Sep 16 21:00:46 2006 -0400
@@ -61,13 +61,13 @@ static long long snd_gf1_mem_proc_llseek
 	struct gus_proc_private *priv = entry->private_data;
 
 	switch (orig) {
-	case 0:	/* SEEK_SET */
+	case SEEK_SET:
 		file->f_pos = offset;
 		break;
-	case 1:	/* SEEK_CUR */
+	case SEEK_CUR:
 		file->f_pos += offset;
 		break;
-	case 2: /* SEEK_END, offset is negative */
+	case SEEK_END: /* offset is negative */
 		file->f_pos = priv->size + offset;
 		break;
 	default:


