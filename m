Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261730AbTCaReL>; Mon, 31 Mar 2003 12:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbTCaReL>; Mon, 31 Mar 2003 12:34:11 -0500
Received: from host044163.arnet.net.ar ([200.45.44.163]:57519 "EHLO
	menichini.com.ar") by vger.kernel.org with ESMTP id <S261730AbTCaReJ>;
	Mon, 31 Mar 2003 12:34:09 -0500
Date: Mon, 31 Mar 2003 14:39:54 -0300 (ART)
From: Pablo Menichini <pablo@menichini.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Adam Belay <ambx1@neo.rr.com>, Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2.5] ES968: kmalloc params fix
Message-ID: <Pine.LNX.4.33.0303311242340.626-100000@pablo.menichini.com.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch swaps the arguments of kmalloc, and relax the type
of allocation to GFP_KERNEL as others PnP functions do.

Pablo


--- sound/isa/sb/es968.c.orig	Sun Mar 30 14:30:08 2003
+++ sound/isa/sb/es968.c	Sun Mar 30 14:32:16 2003
@@ -95,7 +95,7 @@
 					const struct pnp_card_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
+	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
 	if (!cfg)
 		return -ENOMEM;





