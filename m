Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUBBTuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUBBTtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:49:21 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:33396 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265980AbUBBTsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:48:25 -0500
Date: Mon, 2 Feb 2004 20:48:24 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 20/42]
Message-ID: <20040202194824.GT6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i2o_block.c:510: warning: `i2ob_flush' defined but not used

i2ob_flush is unused: wrap it with #if 0

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/message/i2o/i2o_block.c linux-2.4/drivers/message/i2o/i2o_block.c
--- linux-2.4-vanilla/drivers/message/i2o/i2o_block.c	Sat Aug  3 02:39:44 2002
+++ linux-2.4/drivers/message/i2o/i2o_block.c	Sat Jan 31 17:56:39 2004
@@ -506,6 +506,7 @@
 	return 1;
 }
 
+#if 0 /* Currently unused */
 static int i2ob_flush(struct i2o_controller *c, struct i2ob_device *d, int unit)
 {
 	unsigned long msg;
@@ -531,6 +532,7 @@
 	i2o_post_message(c,m);
 	return 0;
 }
+#endif
 			
 /*
  *	OSM reply handler. This gets all the message replies

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Quando un uomo porta dei fiori a sua moglie senza motivo, 
un motivo c'e`.
