Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWJQU7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWJQU7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWJQU7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:59:52 -0400
Received: from [151.97.230.90] ([151.97.230.90]:34739 "EHLO memento.home.lan")
	by vger.kernel.org with ESMTP id S1750826AbWJQU7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:59:51 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: fix typo in memory barrier docs
Date: Tue, 17 Oct 2006 22:59:37 +0200
Message-Id: <11611187771673-git-send-email-blaisorblade@yahoo.it>
X-Mailer: git-send-email 1.4.2.3.g99b7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix cut'n'paste typo - &a and &b are used in other examples, in this one the doc
uses &u and &v.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/Documentation/memory-barriers.txt
===================================================================
--- linux-2.6.git.orig/Documentation/memory-barriers.txt
+++ linux-2.6.git/Documentation/memory-barriers.txt
@@ -1898,7 +1898,7 @@ queue before processing any further requ
 	smp_wmb();
 	<A:modify v=2>	<C:busy>
 			<C:queue v=2>
-	p = &b;		q = p;
+	p = &v;		q = p;
 			<D:request p>
 	<B:modify p=&v>	<D:commit p=&v>
 		  	<D:read p>
