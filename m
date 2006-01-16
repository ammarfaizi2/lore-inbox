Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWAPRPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWAPRPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWAPRPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:15:39 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21440 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751138AbWAPRPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:15:38 -0500
Subject: PATCH: Remove unused code from rioroute.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:19:52 +0000
Message-Id: <1137431992.15553.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/rioroute.c linux-2.6.15-git12/drivers/char/rio/rioroute.c
--- linux.vanilla-2.6.15-git12/drivers/char/rio/rioroute.c	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/rioroute.c	2006-01-16 16:23:09.574952384 +0000
@@ -112,15 +112,6 @@
 	int Lies;
 	unsigned long flags;
 
-#ifdef STACK
-	RIOStackCheck("RIORouteRup");
-#endif
-#ifdef CHECK
-	CheckPacketP(PacketP);
-	CheckHostP(HostP);
-	CheckRup(Rup);
-	CheckHost(Host);
-#endif
 	/*
 	 ** Is this unit telling us it's current link topology?
 	 */
@@ -540,9 +531,6 @@
 
 		for (port = 0; port < PORTS_PER_RTA; port++, PortN++) {
 			ushort dest_port = port + 8;
-#if 0
-			uint PktInt;
-#endif
 			WORD *TxPktP;
 			PKT *Pkt;
 
@@ -623,10 +611,6 @@
 	unsigned long flags;
 	rio_spin_lock_irqsave(&HostP->HostLock, flags);
 
-#ifdef CHECK
-	CheckHostP(HostP);
-	CheckUnitId(UnitId);
-#endif
 	if (RIOCheck(HostP, UnitId)) {
 		rio_dprintk(RIO_DEBUG_ROUTE, "Unit %d is NOT isolated\n", UnitId);
 		rio_spin_unlock_irqrestore(&HostP->HostLock, flags);
@@ -651,10 +635,6 @@
 {
 	uint link, unit;
 
-#ifdef CHECK
-	CheckHostP(HostP);
-	CheckUnitId(UnitId);
-#endif
 	UnitId--;		/* this trick relies on the Unit Id being UNSIGNED! */
 
 	if (UnitId >= MAX_RUP)	/* dontcha just lurv unsigned maths! */
@@ -684,10 +664,6 @@
 {
 	unsigned char link;
 
-#ifdef CHECK
-	CheckHostP(HostP);
-	CheckUnitId(UnitId);
-#endif
 /* 	rio_dprint(RIO_DEBUG_ROUTE, ("Check to see if unit %d has a route to the host\n",UnitId)); */
 	rio_dprintk(RIO_DEBUG_ROUTE, "RIOCheck : UnitID = %d\n", UnitId);
 

