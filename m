Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUJKNlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUJKNlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268954AbUJKNlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:41:31 -0400
Received: from mail.dif.dk ([193.138.115.101]:14538 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268961AbUJKNlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:41:18 -0400
Date: Mon, 11 Oct 2004 15:48:59 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Mike Phillips <mikep@linuxtr.net>
Cc: linux-net <linux-net@vger.kernel.org>, linux-tr <linux-tr@linuxtr.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH][Trivial] kill unused variable in olympic.c
Message-ID: <Pine.LNX.4.61.0410111532340.26100@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a trivial patch that removes an unused variable in olympic.c and 
thus kill the associated warning.

drivers/net/tokenring/olympic.c: In function `olympic_arb_cmd':
drivers/net/tokenring/olympic.c:1404: warning: unused variable `i'
  LD      drivers/net/tokenring/built-in.o

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc4-orig/drivers/net/tokenring/olympic.c linux-2.6.9-rc4/drivers/net/tokenring/olympic.c
--- linux-2.6.9-rc4-orig/drivers/net/tokenring/olympic.c	2004-10-11 09:59:55.000000000 +0200
+++ linux-2.6.9-rc4/drivers/net/tokenring/olympic.c	2004-10-11 15:31:29.000000000 +0200
@@ -1401,7 +1401,6 @@ static void olympic_arb_cmd(struct net_d
 	u16 lan_status = 0, lan_status_diff  ; /* Initialize to stop compiler warning */
 	u8 fdx_prot_error ; 
 	u16 next_ptr;
-	int i ; 
 
 	arb_block = (olympic_priv->olympic_lap + olympic_priv->arb) ; 
 	asb_block = (olympic_priv->olympic_lap + olympic_priv->asb) ; 


I guess this should just wait post 2.6.9 final since Linus said "hold the 
patches" in the -rc4 announcement, and it's quite trivial anyway, so no 
hurry.


--
Jesper Juhl

PS. I'm only subscribed to linux-kernel, so please CC me on replies from 
other lists.


