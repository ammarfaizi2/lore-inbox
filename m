Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270521AbTGNE2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 00:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270522AbTGNE2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 00:28:13 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:47347 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S270521AbTGNE2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 00:28:11 -0400
Date: Sun, 13 Jul 2003 21:41:50 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, akpm@osdl.org, kas@fi.muni.cz, paulkf@microgate.com
Subject: ]PATCH] syncppp: incomplete function prototype
Message-Id: <20030713214150.1ed34f23.randy.dunlap@verizon.net>
Organization: YPO4
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [4.4.25.4] at Sun, 13 Jul 2003 23:42:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch is to 2.6.0-test1 and fixes this warning:
syncppp.c:165: warning: function declaration isn't a prototype

by adding "void" as the function parameter list.

Please apply.

--
~Randy


patch_name:	syncppp_function.patch
patch_version:	2003-07-13.21:36:07
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix compile warning:
		syncppp.c:165: warning: function declaration isn't a prototype
product:	Linux
product_versions: 2.6.0-test1
maintainer:	Jan "Yenya" Kasprzak <kas@fi.muni.cz>,
		Paul Fulghum (paulkf@microgate.com)
diffstat:	=
 drivers/net/wan/syncppp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naur ./drivers/net/wan/syncppp.c~org ./drivers/net/wan/syncppp.c
--- ./drivers/net/wan/syncppp.c~org	2003-07-13 20:32:29.000000000 -0700
+++ ./drivers/net/wan/syncppp.c	2003-07-13 21:31:24.000000000 -0700
@@ -161,7 +161,7 @@
  * then put the packet into tx_queue, and call sppp_flush_xmit()
  * after spinlock is released.
  */
-static void sppp_flush_xmit()
+static void sppp_flush_xmit(void)
 {
 	struct sk_buff *skb;
 	while ((skb = skb_dequeue(&tx_queue)) != NULL)
