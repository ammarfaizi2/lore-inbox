Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUBBTr1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUBBTq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:46:27 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:29034 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265931AbUBBToW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:44:22 -0500
Date: Mon, 2 Feb 2004 20:44:22 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 10/42]
Message-ID: <20040202194422.GJ6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


csr.c:120: warning: long unsigned int format, int arg (arg 3)

HZ is int, not unsigned long.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/ieee1394/csr.c linux-2.4/drivers/ieee1394/csr.c
--- linux-2.4-vanilla/drivers/ieee1394/csr.c	Tue Nov 11 17:51:38 2003
+++ linux-2.4/drivers/ieee1394/csr.c	Sat Jan 31 17:07:53 2004
@@ -117,7 +117,7 @@
 	/* Just to keep from rounding low */
 	csr->expire++;
 
-	HPSB_VERBOSE("CSR: setting expire to %lu, HZ=%lu", csr->expire, HZ);
+	HPSB_VERBOSE("CSR: setting expire to %lu, HZ=%d", csr->expire, HZ);
 }
 
 
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Sei l'unica donna della mia vita".
(Adamo)
