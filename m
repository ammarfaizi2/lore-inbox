Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSKAIju>; Fri, 1 Nov 2002 03:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSKAIju>; Fri, 1 Nov 2002 03:39:50 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:52368 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S265667AbSKAIjt>;
	Fri, 1 Nov 2002 03:39:49 -0500
Date: Fri, 1 Nov 2002 09:46:00 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [miniPATCH] 2.5.4[4,5] compile fix of net/rxrpc/main.c
Message-ID: <20021101084600.GA21610@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,

this patch fix the compile error in the net/rxrpc/main.c, which is
needed for AFS... (Compiler is 2.95.4).

Please apply...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="net_rxpc_mainc.patch"

--- linux-2.5.44/net/rxrpc/main.c.old	2002-10-23 11:44:45.000000000 +0200
+++ linux-2.5.44/net/rxrpc/main.c	2002-10-23 11:45:41.000000000 +0200
@@ -123,5 +123,5 @@
 	__RXACCT(printk("Outstanding Peers      : %d\n",atomic_read(&rxrpc_peer_count)));
 	__RXACCT(printk("Outstanding Transports : %d\n",atomic_read(&rxrpc_transport_count)));
 
-	kleave();
+	kleave("");
 } /* end rxrpc_cleanup() */

--huq684BweRXVnRxX--
