Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270400AbTGNMAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270402AbTGNMAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:00:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34436
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270400AbTGNL7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:59:44 -0400
Date: Mon, 14 Jul 2003 13:13:41 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141213.h6ECDfCM030830@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: clear mp bus array properly
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/arch/i386/kernel/mpparse.c linux.22-pre5-ac1/arch/i386/kernel/mpparse.c
--- linux.22-pre5/arch/i386/kernel/mpparse.c	2003-07-14 12:27:32.000000000 +0100
+++ linux.22-pre5-ac1/arch/i386/kernel/mpparse.c	2003-07-14 12:37:23.000000000 +0100
@@ -516,7 +519,7 @@
 	mp_bus_id_to_local = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 2];
 	mp_bus_id_to_pci_bus = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 3];
 	mp_irqs = (struct mpc_config_intsrc *)&bus_data[(max_mp_busses * sizeof(int)) * 4];
-	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses);
+	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses * sizeof(int));
 
 	/*
 	 *	Now process the configuration blocks.
