Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUBBTuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUBBTth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:49:37 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:59738 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265958AbUBBTro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:47:44 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:47:43 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 18/42]
Message-ID: <20040202194743.GR6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix compilation when compiled as module.


diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/hc_sl811-hw.h linux-2.4/include/asm-i386/hc_sl811-hw.h
--- linux-2.4-vanilla/include/asm-i386/hc_sl811-hw.h	Tue Nov 11 17:51:39 2003
+++ linux-2.4/include/asm-i386/hc_sl811-hw.h	Sat Jan 31 17:47:43 2004
@@ -20,11 +20,11 @@
 
 */
 
-#ifdef MODULE
-
 #define MAX_CONTROLERS	2	/* Max number of SL811 controllers per module */
 static int io_base	= 0x220;
 static int irq	= 12;
+
+#ifdef MODULE
 
 MODULE_PARM(io_base,"i");
 MODULE_PARM_DESC(io_base,"sl811 base address 0x220");

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
I went to God just to see
And I was looking at me
Saw heaven and hell were lies
When I'm God everyone dies
