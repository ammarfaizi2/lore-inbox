Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265952AbUBBVDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUBBVDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:03:47 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:16751 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265952AbUBBTqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:46:10 -0500
Date: Mon, 2 Feb 2004 20:46:09 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 14/42]
Message-ID: <20040202194609.GN6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dtc.c:182: warning: `dtc_setup' defined but not used

dtc_setup isn't used when the driver is modular.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/scsi/dtc.c linux-2.4/drivers/scsi/dtc.c
--- linux-2.4-vanilla/drivers/scsi/dtc.c	Tue Nov 11 17:51:39 2003
+++ linux-2.4/drivers/scsi/dtc.c	Sat Jan 31 17:17:40 2004
@@ -172,6 +172,7 @@
 
 #define NO_SIGNATURES (sizeof (signatures) /  sizeof (struct signature))
 
+#ifndef MODULE
 /**
  *	dtc_setup	-	option setup for dtc3x80
  *
@@ -202,6 +203,7 @@
 }
 
 __setup("dtc=", dtc_setup);
+#endif
 
 /**
  *	dtc_detect	-	detect DTC 3x80 controllers
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Alcuni pensano che io sia una persona orribile, ma non vero. Ho il
cuore di un ragazzino - in un vaso sulla scrivania.
