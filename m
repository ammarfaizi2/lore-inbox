Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUHPWkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUHPWkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUHPWkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:40:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267993AbUHPWkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:40:14 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.14160.843507.617388@segfault.boston.redhat.com>
Date: Mon, 16 Aug 2004 18:38:08 -0400
To: mpm@selenic.com
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch] make netpoll_set_trap EXPORT_SYMBOL_GPL
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

I believe that we should export the netpoll_set_trap routine as GPL only,
since vendors could conceivably use it to by-pass the networking stack
completely.  Jeff, correct me if I'm wrong, but I think this is what you
intended when you commented on it many months ago (sorry, can't find the
thread).

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.7/net/core/netpoll.c.gpl	2004-08-16 17:11:52.773312560 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-16 17:12:42.146806648 -0400
@@ -678,8 +678,8 @@ void netpoll_set_trap(int trap)
 		atomic_dec(&trapped);
 }
 
-EXPORT_SYMBOL(netpoll_set_trap);
-EXPORT_SYMBOL(netpoll_trap);
+EXPORT_SYMBOL_GPL(netpoll_set_trap);
+EXPORT_SYMBOL_GPL(netpoll_trap);
 EXPORT_SYMBOL(netpoll_parse_options);
 EXPORT_SYMBOL(netpoll_setup);
 EXPORT_SYMBOL(netpoll_cleanup);
