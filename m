Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbUBBToT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265933AbUBBToT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:44:19 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:22375 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265915AbUBBTnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:43:11 -0500
Date: Mon, 2 Feb 2004 20:43:10 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 9/42]
Message-ID: <20040202194309.GI6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


crc32.c:91: warning: static declaration for `fn_calc_memory_chunk_crc32' follows non-static

fn_calc_memory_chunk_crc32 is declared static in
drivers/net/wan/8253x/crc32.c. Remove the prototype from the header.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/net/wan/8253x/crc32dcl.h linux-2.4/drivers/net/wan/8253x/crc32dcl.h
--- linux-2.4-vanilla/drivers/net/wan/8253x/crc32dcl.h	Sat Aug  3 02:39:44 2002
+++ linux-2.4/drivers/net/wan/8253x/crc32dcl.h	Sat Jan 31 17:03:17 2004
@@ -29,7 +29,6 @@
 /****************************************************/
 
 extern void	fn_init_crc_table(void);
-extern unsigned int	fn_calc_memory_chunk_crc32(void *p, unsigned int n_bytes, unsigned int crc);
 extern unsigned int	fn_calc_memory_crc32(void *p, unsigned int n_bytes);
 extern unsigned int	fn_check_memory_crc32(void *p, unsigned int n_bytes, unsigned int crc);
 
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"In linea di principio sarei indifferente al natale, se solo il natale
 ricambiasse la cortesia e mi lasciasse in pace." -- Marco d'Itri
