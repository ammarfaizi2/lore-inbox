Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbTIIX7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbTIIX7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:59:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:26315 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264178AbTIIX7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:59:52 -0400
Date: Tue, 9 Sep 2003 16:54:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] pdc4030: return needs value; function needs return;
Message-Id: <20030909165414.2f0a5113.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please apply to 2.6.0-test5.

--
~Randy


diff -Naurp ./drivers/ide/legacy/pdc4030.c~clean ./drivers/ide/legacy/pdc4030.c
--- ./drivers/ide/legacy/pdc4030.c~clean	2003-09-08 12:50:06.000000000 -0700
+++ ./drivers/ide/legacy/pdc4030.c	2003-09-09 16:35:33.000000000 -0700
@@ -304,7 +304,7 @@ int __init ide_probe_for_pdc4030(void)
 
 #ifndef MODULE
 	if (enable_promise_support == 0)
-		return;
+		return 0;
 #endif
 
 	for (index = 0; index < MAX_HWIFS; index++) {
@@ -317,7 +317,7 @@ int __init ide_probe_for_pdc4030(void)
 #endif
 		}
 	}
-#ifdef MODULE
+#ifndef MODULE
 	return 0;
 #endif
 }
