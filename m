Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSJPXYI>; Wed, 16 Oct 2002 19:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSJPXYI>; Wed, 16 Oct 2002 19:24:08 -0400
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:56197 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S261522AbSJPXYE>;
	Wed, 16 Oct 2002 19:24:04 -0400
Date: Wed, 16 Oct 2002 18:29:56 -0500
From: Matt Reppert <arashi@arashi.yi.org>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc compile fix
Message-Id: <20021016182956.479fc3b8.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, spoke too soon on that last mail, I also need this to compile with
AFS. The kleave macro on line 126 of net/rxrpc/main.c needs an argument
but isn't given one. This fixes that; patch is against 2.5.43[-mm1].

Matt

--- linux-2.5.43-orig/net/rxrpc/main.c.orig	2002-10-16 18:23:05 -0500
+++ linux-2.5.43-orig/net/rxrpc/main.c	2002-10-16 18:22:26 -0500
@@ -123,5 +123,5 @@
 	__RXACCT(printk("Outstanding Peers      : %d\n",atomic_read(&rxrpc_peer_count)));
 	__RXACCT(printk("Outstanding Transports : %d\n",atomic_read(&rxrpc_transport_count)));
 
-	kleave();
+	kleave("");
 } /* end rxrpc_cleanup() */
