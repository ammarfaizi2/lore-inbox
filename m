Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUBBUBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUBBT7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:59:55 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:40311 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265912AbUBBT6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:58:33 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:58:33 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 28/42]
Message-ID: <20040202195833.GB6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ma600.c:51:22: warning: extra tokens at end of #undef directive

Remove extra tokens after ASSERT.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/net/irda/ma600.c linux-2.4/drivers/net/irda/ma600.c
--- linux-2.4-vanilla/drivers/net/irda/ma600.c	Tue Nov 11 17:51:39 2003
+++ linux-2.4/drivers/net/irda/ma600.c	Sat Jan 31 18:18:19 2004
@@ -48,7 +48,7 @@
 	#undef IRDA_DEBUG
 	#define IRDA_DEBUG(n, args...) (printk(KERN_DEBUG args))
 
-	#undef ASSERT(expr, func)
+	#undef ASSERT
 	#define ASSERT(expr, func) \
 	if(!(expr)) { \
 		printk( "Assertion failed! %s,%s,%s,line=%d\n",\

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Carpe diem, quam minimum credula postero. (Q. Horatius Flaccus)
