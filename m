Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUBTUSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbUBTUPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:15:07 -0500
Received: from tantale.fifi.org ([216.27.190.146]:25735 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261305AbUBTUOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:14:22 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Quota compilation fix
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 20 Feb 2004 12:13:41 -0800
Message-ID: <87isi133wq.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Enclosed patch allows kernel compilation when CONFIG_QFMT_V2=y.

Phil.

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.25-new-quotas.patch

diff -ruN linux-2.4.25.orig/fs/buffer.c linux-2.4.25/fs/buffer.c
--- linux-2.4.25.orig/fs/buffer.c	Wed Feb 18 13:14:11 2004
+++ linux-2.4.25/fs/buffer.c	Wed Feb 18 13:14:20 2004
@@ -436,7 +436,7 @@
 	** after these are done
 	*/
 	sync_inodes(dev);
-	DQUOT_SYNC(dev);
+	DQUOT_SYNC_DEV(dev);
 	/* if inodes or quotas could be dirtied during the
 	** sync_supers_lockfs call, the FS is responsible for getting
 	** them on disk, without deadlocking against the lock

--=-=-=--
