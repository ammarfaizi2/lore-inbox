Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWAPRVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWAPRVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWAPRVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:21:37 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57758 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751142AbWAPRVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:21:36 -0500
Subject: PATCH: Remove rio_table.c unused code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:25:42 +0000
Message-Id: <1137432342.15553.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/riotable.c linux-2.6.15-git12/drivers/char/rio/riotable.c
--- linux.vanilla-2.6.15-git12/drivers/char/rio/riotable.c	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/riotable.c	2006-01-16 16:23:09.574952384 +0000
@@ -754,11 +754,6 @@
 	ushort RtaType;
 	unsigned long flags;
 
-#ifdef CHECK
-	CheckHostP(HostP);
-	CheckHostMapP(HostMapP);
-#endif
-
 	rio_dprintk(RIO_DEBUG_TABLE, "Mapping sysport %d to id %d\n", (int) HostMapP->SysPort, HostMapP->ID);
 
 	/*
@@ -784,9 +779,6 @@
 
 		rio_dprintk(RIO_DEBUG_TABLE, "c1 p = %p, p->rioPortp = %p\n", p, p->RIOPortp);
 		PortP = p->RIOPortp[SysPort];
-#if 0
-		PortP->TtyP = &p->channel[SysPort];
-#endif
 		rio_dprintk(RIO_DEBUG_TABLE, "Map port\n");
 
 		/*

