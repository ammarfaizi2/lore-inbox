Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTDJDGa (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 23:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbTDJDGa (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 23:06:30 -0400
Received: from host159220.arnet.net.ar ([200.45.159.220]:60591 "EHLO
	menichini.com.ar") by vger.kernel.org with ESMTP id S263800AbTDJDG3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 23:06:29 -0400
Date: Thu, 10 Apr 2003 00:15:10 -0300 (ART)
From: Pablo Menichini <pablo@menichini.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Adam Belay <ambx1@neo.rr.com>, Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2.5] SB16: fix kmalloc params
In-Reply-To: <Pine.LNX.4.33.0303311242340.626-100000@pablo.menichini.com.ar>
Message-ID: <Pine.LNX.4.33.0304081528440.395-100000@pablo.menichini.com.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch swaps the arguments of kmalloc, and relax the type
of allocation to GFP_KERNEL as others PnP functions do.

Pablo

--- linux-2.5.67/sound/isa/sb/sb16.c	Tue Apr  8 15:24:31 2003
+++ linux-local/sound/isa/sb/sb16.c	Tue Apr  8 15:24:52 2003
@@ -261,7 +261,7 @@
 				       const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
+	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;

 	if (!cfg)



