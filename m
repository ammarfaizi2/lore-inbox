Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSJPEgK>; Wed, 16 Oct 2002 00:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSJPEgI>; Wed, 16 Oct 2002 00:36:08 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:61060
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264919AbSJPEgG>; Wed, 16 Oct 2002 00:36:06 -0400
Date: Wed, 16 Oct 2002 00:29:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: sfrench@us.ibm.com
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] CIFS connect.c return ipv4_connect value
Message-ID: <Pine.LNX.4.44.0210160028050.1460-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.43/fs/cifs/connect.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.43/fs/cifs/connect.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 connect.c
--- linux-2.5.43/fs/cifs/connect.c	16 Oct 2002 03:46:04 -0000	1.1.1.1
+++ linux-2.5.43/fs/cifs/connect.c	16 Oct 2002 04:27:52 -0000
@@ -63,8 +63,6 @@
 int
 cifs_reconnect(struct TCP_Server_Info *server)
 {
-	int rc = 0;
-
 	cFYI(1, ("\nReconnecting tcp session "));
 
 	/* lock tcp session */
@@ -75,8 +73,7 @@
 	     ("\nState: 0x%x Flags: 0x%lx", server->ssocket->state,
 	      server->ssocket->flags));
 
-	ipv4_connect(&server->sockAddr, &server->ssocket);
-	return rc;
+	return ipv4_connect(&server->sockAddr, &server->ssocket);
 }
 
 int

-- 
function.linuxpower.ca

