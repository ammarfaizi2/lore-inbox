Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWAPRNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWAPRNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWAPRNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:13:52 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20672 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751136AbWAPRNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:13:51 -0500
Subject: PATCH: Remove unused code from rioboot.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:18:05 +0000
Message-Id: <1137431885.15553.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/rioboot.c linux-2.6.15-git12/drivers/char/rio/rioboot.c
--- linux.vanilla-2.6.15-git12/drivers/char/rio/rioboot.c	2006-01-16 14:17:08.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/rioboot.c	2006-01-16 16:23:09.573952536 +0000
@@ -665,13 +665,6 @@
 	struct CmdBlk *CmdBlkP;
 	uint sequence;
 
-#ifdef CHECK
-	CheckHost(Host);
-	CheckRup(Rup);
-	CheckHostP(HostP);
-	CheckPacketP(PacketP);
-#endif
-
 	/*
 	** If we haven't been told what to boot, we can't boot it.
 	*/
@@ -956,11 +949,6 @@
 	    MyType = "RTA";
 	    MyName = HostP->Mapping[Rup].Name;
 	}
-#ifdef CHECK
-	CheckString(MyType);
-	CheckString(MyName);
-#endif
-
 	MyLink = RBYTE(PktCmdP->LinkNum);
 
 	/*
@@ -1309,52 +1297,3 @@
 	}
 }
 
-#if 0
-/*
-	Function:	This function is to disable the disk interrupt 
-    Returns :   Nothing
-*/
-void
-disable_interrupt(vector)
-int	vector;
-{
-	int	ps;
-	int	val;
-
-	disable(ps);
-	if (vector > 40)  {
-		val = 1 << (vector - 40);
-		__outb(S8259+1, __inb(S8259+1) | val);
-	}
-	else {
-		val = 1 << (vector - 32);
-		__outb(M8259+1, __inb(M8259+1) | val);
-	}
-	restore(ps);
-}
-
-/*
-	Function:	This function is to enable the disk interrupt 
-    Returns :   Nothing
-*/
-void
-enable_interrupt(vector)
-int	vector;
-{
-	int	ps;
-	int	val;
-
-	disable(ps);
-	if (vector > 40)  {
-		val = 1 << (vector - 40);
-		val = ~val;
-		__outb(S8259+1, __inb(S8259+1) & val);
-	}
-	else {
-		val = 1 << (vector - 32);
-		val = ~val;
-		__outb(M8259+1, __inb(M8259+1) & val);
-	}
-	restore(ps);
-}
-#endif

