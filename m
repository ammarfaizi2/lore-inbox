Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUBBSV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbUBBSV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:21:56 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:5699 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265785AbUBBSVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:21:22 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 19:21:19 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 3/42]
Message-ID: <20040202182119.GC6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


agpgart_be.c:5647:17: warning: extra tokens at end of #undef directive

Fix is trivial.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/char/agp/agpgart_be.c linux-2.4/drivers/char/agp/agpgart_be.c
--- linux-2.4-vanilla/drivers/char/agp/agpgart_be.c	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/char/agp/agpgart_be.c	Sat Jan 31 16:17:28 2004
@@ -5644,7 +5644,7 @@
 #define GET_PAGE_DIR_IDX(addr) (GET_PAGE_DIR_OFF(addr) - \
 	GET_PAGE_DIR_OFF(agp_bridge.gart_bus_addr))
 #define GET_GATT_OFF(addr) ((addr & 0x003ff000) >> 12)
-#undef  GET_GATT(addr)
+#undef  GET_GATT
 #define GET_GATT(addr) (ati_generic_private.gatt_pages[\
 	GET_PAGE_DIR_IDX(addr)]->remapped)
 
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Dicono che  il cane sia  il miglior  amico dell'uomo. Secondo me  non e`
vero. Quanti dei vostri amici avete fatto castrare, recentemente?
