Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVDDVGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVDDVGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDDVFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:05:35 -0400
Received: from host201.dif.dk ([193.138.115.201]:13060 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261421AbVDDU7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:59:24 -0400
Date: Mon, 4 Apr 2005 23:01:45 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cifs: cleanup asn1.c - kfree
Message-ID: <Pine.LNX.4.62.0504042300520.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant NULL pointer check before calling kfree().

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4/fs/cifs/asn1.c.with_patch1	2005-04-04 22:25:50.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/asn1.c	2005-04-04 22:33:34.000000000 +0200
@@ -540,7 +540,6 @@ int decode_negTokenInit(unsigned char *s
 					   *(oid + 3)));
 					rc = compare_oid(oid, oidlen, NTLMSSP_OID,
 						 NTLMSSP_OID_LEN);
-					if(oid)
 						kfree(oid);
 					if (rc)
 						use_ntlmssp = TRUE;


