Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTFTQGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTFTQGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:06:24 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:61248 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263258AbTFTQGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:06:22 -0400
Date: Fri, 20 Jun 2003 12:19:48 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, <neilb@cse.unsw.edu.au>
Subject: [PATCH] compile fix for svcsock.c
Message-ID: <Pine.LNX.4.44.0306201216310.5773-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like a typo in the recently applied patch to svcsock.c,
since it's looking at sk->state everywhere else.

--- linux-2.4.21/net/sunrpc/svcsock.c.orig	2003-06-20 12:13:58.000000000 -0400
+++ linux-2.4.21/net/sunrpc/svcsock.c	2003-06-20 12:14:08.000000000 -0400
@@ -1001,7 +1001,7 @@
 				    3 * svsk->sk_server->sv_bufsz);
 
 		set_bit(SK_CHNGBUF, &svsk->sk_flags);
-		if (sk->sk_state != TCP_ESTABLISHED) 
+		if (sk->state != TCP_ESTABLISHED) 
 			set_bit(SK_CLOSE, &svsk->sk_flags);
 	}
 

