Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUFOXQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUFOXQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUFOXQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:16:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:44477 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266006AbUFOXQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:16:47 -0400
Date: Tue, 15 Jun 2004 16:16:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Mika Kukkonen <mika@osdl.org>
Subject: [PATCH] security_sk_free void return fixup
Message-ID: <20040615161646.S21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CHECK   net/core/sock.c
include/linux/security.h:2636:39: warning: return expression in void function
  CC      net/core/sock.o

From: Mika Kukkonen <mika@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/linux/security.h 1.35 vs edited =====
--- 1.35/include/linux/security.h	2004-06-14 08:56:50 -07:00
+++ edited/include/linux/security.h	2004-06-15 16:14:56 -07:00
@@ -2633,7 +2633,7 @@
 
 static inline void security_sk_free(struct sock *sk)
 {
-	return security_ops->sk_free_security(sk);
+	security_ops->sk_free_security(sk);
 }
 #else	/* CONFIG_SECURITY_NETWORK */
 static inline int security_unix_stream_connect(struct socket * sock,
