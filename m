Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUHXUvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUHXUvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUHXUvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:51:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:13007 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268315AbUHXUvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:51:50 -0400
Date: Tue, 24 Aug 2004 22:57:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Make PERFCTR_VIRTUAL default in Kconfig match recommendation
 in help text
Message-ID: <Pine.LNX.4.61.0408242246570.2770@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

A tiny patch to make PERFCTR_VIRTUAL default to Y to match the 
recommendation given in the help text. The help has a very clear "Say Y" 
recommendation and it doesn't make much sense to not enable this currently 
if PERFCTR is set, so it should default to Y, not N as it does currently.

Patch is against 2.6.8.1-mm4

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.8.1-mm4-orig/drivers/perfctr/Kconfig linux-2.6.8.1-mm4/drivers/perfctr/Kconfig
--- linux-2.6.8.1-mm4-orig/drivers/perfctr/Kconfig	2004-08-24 19:55:27.000000000 +0200
+++ linux-2.6.8.1-mm4/drivers/perfctr/Kconfig	2004-08-24 20:56:37.000000000 +0200
@@ -40,6 +40,7 @@ config PERFCTR_INIT_TESTS
 config PERFCTR_VIRTUAL
 	bool "Virtual performance counters support"
 	depends on PERFCTR
+	default y
 	help
 	  The processor's performance-monitoring counters are special-purpose
 	  global registers. This option adds support for virtual per-process


/Jesper

