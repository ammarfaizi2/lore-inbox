Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbUAPLjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 06:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUAPLjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 06:39:08 -0500
Received: from zamok.crans.org ([138.231.136.6]:57776 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S265394AbUAPLjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 06:39:02 -0500
To: linux-kernel@vger.kernel.org
Subject: [Trivial][PATCH][2.6.1-mm4]: Export dnotify_parent symbol to have
 nfsd module loaded.
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Fri, 16 Jan 2004 12:38:41 +0100
Message-ID: <873cagi0n2.fsf@minas-morgul.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

With the new kNFSd update in -mm4, nfsd built as a module needs dnotify_parent
symbol exported. The fix is trivial and works for me.
 

--=-=-=
Content-Disposition: attachment
Content-Description: EXPORT_SYMBOL-dnotify_parent.patch

--- linux/fs/dnotify.c	2004-01-16 12:30:04.000000000 +0100
+++ linux/fs/dnotify.c.edited	2004-01-16 12:29:48.000000000 +0100
@@ -166,6 +166,8 @@
 	}
 }
 
+EXPORT_SYMBOL(dnotify_parent);
+
 static int __init dnotify_init(void)
 {
 	dn_cache = kmem_cache_create("dnotify_cache",

--=-=-=


Have a nice day.
-- 
Mathieu Segaud

> There's not a court in the civilised world that would uphold the GPL in that
> scenario.

Yes but the concern is the USA 8)

	- Alan Cox on linux-kernel

--=-=-=--
