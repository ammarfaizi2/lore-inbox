Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUB0PdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 10:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbUB0PdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 10:33:09 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:34823 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S263014AbUB0PdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 10:33:06 -0500
Date: Fri, 27 Feb 2004 16:32:53 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd.ko needs locks_remove_posix exported from fs/locks.c
Message-ID: <20040227153253.GF15718@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch exports locks_remove_posix from fs/locks.c - it's needed by
nfsd.ko after latest updates (its usage has been introduced in
1.1653.1.44, rev 1.32 of fs/nfsd/nfs4state.c).


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-nfsd-locks_remove_posix.patch"

--- linux-2.6.3/fs/locks.c.orig	Wed Feb 18 04:59:31 2004
+++ linux-2.6.3/fs/locks.c	Fri Feb 27 14:55:04 2004
@@ -1699,6 +1699,8 @@
 	unlock_kernel();
 }
 
+EXPORT_SYMBOL(locks_remove_posix);
+
 /*
  * This function is called on the last close of an open file.
  */

--u3/rZRmxL6MmkK24--
