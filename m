Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266371AbTGEPpe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 11:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbTGEPpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 11:45:34 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:3538 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S266371AbTGEPpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 11:45:33 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5 trivial generic HDLC update
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Jul 2003 16:16:25 +0200
Message-ID: <m3llvd6oue.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please apply this trivial fix to Linux 2.5. Thanks.
-- 
Krzysztof Halasa
Network Administrator

--- linux-2.5.orig/drivers/net/wan/hdlc_generic.c	2003-05-27 03:00:23.000000000 +0200
+++ linux-2.5/drivers/net/wan/hdlc_generic.c	2003-07-05 16:01:51.000000000 +0200
@@ -177,11 +177,8 @@
 
 struct packet_type hdlc_packet_type=
 {
-        __constant_htons(ETH_P_HDLC),
-        NULL,
-        hdlc_rcv,
-        NULL,
-        NULL
+	.type = __constant_htons(ETH_P_HDLC),
+	.func = hdlc_rcv,
 };
 
 
