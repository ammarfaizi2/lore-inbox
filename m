Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268987AbUIXRDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268987AbUIXRDD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268985AbUIXRCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:02:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20952 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268987AbUIXRBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:01:39 -0400
Date: Fri, 24 Sep 2004 13:01:27 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.9-rc2-mm3 - [PATCH] tmpfs xattr fix
In-Reply-To: <20040924014643.484470b1.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0409241259520.8210-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please add this fix for a typo in the new tmpfs xattr code.

Signed-off-by: James Morris <jmorris@redhat.com>


diff -purN -X dontdiff linux-2.6.9-rc2-mm3.o/mm/shmem.c linux-2.6.9-rc2-mm3.w/mm/shmem.c
--- linux-2.6.9-rc2-mm3.o/mm/shmem.c	2004-09-24 10:46:41.000000000 -0400
+++ linux-2.6.9-rc2-mm3.w/mm/shmem.c	2004-09-24 12:54:39.000000000 -0400
@@ -2085,7 +2085,7 @@ static struct vm_operations_struct shmem
 static size_t shmem_xattr_security_list(struct inode *inode, char *list, size_t list_len,
 					const char *name, size_t name_len)
 {
-	return security_inode_listsecurity(inode, list, name_len);
+	return security_inode_listsecurity(inode, list, list_len);
 }
 
 static int shmem_xattr_security_get(struct inode *inode, const char *name, void *buffer, size_t size)

