Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263372AbUJ2Orj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbUJ2Orj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbUJ2OlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:41:01 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:58628 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263346AbUJ2Ody (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:33:54 -0400
Date: Fri, 29 Oct 2004 15:33:41 +0100
From: Arjan van de Ven <arjan@infradead.org>
To: viro@linux.org.uk, hch@lst.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: remove unused lookup_mnt export
Message-ID: <20041029143341.GA13322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lookup_mnt() is entirely unused outside of deep vfs internals, remove the
export since it's quite a low level interface anyway

Signed-off-by: Arjan van de Ven <arjan@infradead.org>


--- linux-2.6.9/fs/namespace.c~	2004-10-29 16:27:45.340762244 +0200
+++ linux-2.6.9/fs/namespace.c	2004-10-29 16:27:45.340762244 +0200
@@ -106,8 +106,6 @@
 	return found;
 }
 
-EXPORT_SYMBOL(lookup_mnt);
-
 static inline int check_mnt(struct vfsmount *mnt)
 {
 	return mnt->mnt_namespace == current->namespace;
