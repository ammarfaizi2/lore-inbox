Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265963AbUBBUBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUBBUAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:00:25 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:10614 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265904AbUBBT6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:58:06 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:58:04 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 26/42]
Message-ID: <20040202195804.GZ6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaweth.c:738: warning: assignment from incompatible pointer type

Add explicit cast to suppress gcc warning.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/usb/kaweth.c linux-2.4/drivers/usb/kaweth.c
--- linux-2.4-vanilla/drivers/usb/kaweth.c	Tue Nov 11 17:51:14 2003
+++ linux-2.4/drivers/usb/kaweth.c	Sat Jan 31 18:14:38 2004
@@ -735,7 +735,7 @@
 		}
 	}
 
-	private_header = __skb_push(skb, 2);
+	private_header = (u16*)__skb_push(skb, 2);
 	*private_header = cpu_to_le16(skb->len-2);
 	kaweth->tx_skb = skb;
 

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Dicono che  il cane sia  il miglior  amico dell'uomo. Secondo me  non e`
vero. Quanti dei vostri amici avete fatto castrare, recentemente?
