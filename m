Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVDDVSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVDDVSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVDDVRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:17:40 -0400
Received: from host201.dif.dk ([193.138.115.201]:28676 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261391AbVDDVCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:02:39 -0400
Date: Mon, 4 Apr 2005 23:04:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] cifs: cleanup asn1.c - comments
Message-ID: <Pine.LNX.4.62.0504042303090.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment beautification. Make them match previously established style.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4/fs/cifs/asn1.c.with_patch3	2005-04-04 22:48:45.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/asn1.c	2005-04-04 22:52:09.000000000 +0200
@@ -67,9 +67,7 @@
 #define ASN1_PRI	0	/* Primitive */
 #define ASN1_CON	1	/* Constructed */
 
-/*
- * Error codes.
- */
+/* Error codes. */
 #define ASN1_ERR_NOERROR		0
 #define ASN1_ERR_DEC_EMPTY		2
 #define ASN1_ERR_DEC_EOC_MISMATCH	3
@@ -81,9 +79,7 @@
 static unsigned long SPNEGO_OID[7] = { 1, 3, 6, 1, 5, 5, 2 };
 static unsigned long NTLMSSP_OID[10] = { 1, 3, 6, 1, 4, 1, 311, 2, 2, 10 };
 
-/* 
- * ASN.1 context.
- */
+/* ASN.1 context. */
 struct asn1_ctx {
 	int error;		/* Error condition */
 	unsigned char *pointer;	/* Octet just to be decoded */
@@ -91,9 +87,7 @@ struct asn1_ctx {
 	unsigned char *end;	/* Octet after last octet */
 };
 
-/*
- * Octet string (not null terminated)
- */
+/* Octet string (not null terminated) */
 struct asn1_octstr {
 	unsigned char *data;
 	unsigned int len;
@@ -447,7 +441,8 @@ int decode_negTokenInit(unsigned char *s
 	unsigned int cls, con, tag, oidlen, rc;
 	int use_ntlmssp = FALSE;
 
-	*secType = NTLM; /* BB eventually make Kerberos or NLTMSSP the default */
+	*secType = NTLM;	/* BB eventually make Kerberos or NLTMSSP the
+				   default */
 
 	/* cifs_dump_mem(" Received SecBlob ", security_blob, length); */
 
@@ -461,7 +456,7 @@ int decode_negTokenInit(unsigned char *s
 		cFYI(1, ("cls = %d con = %d tag = %d", cls, con, tag));
 		return 0;
 	} else {
-		/*      remember to free obj->oid */
+		/* remember to free obj->oid */
 		rc = asn1_header_decode(&ctx, &end, &cls, &con, &tag);
 		if (rc) {
 			if ((tag == ASN1_OJI) && (cls == ASN1_PRI)) {
@@ -553,7 +548,8 @@ int decode_negTokenInit(unsigned char *s
 			cFYI(1, ("Error decoding last part of negTokenInit "
 				 "exit 3"));
 			return 0;
-		} else if ((cls != ASN1_CTX) || (con != ASN1_CON)) {	/* tag = 3 indicating mechListMIC */
+		} else if ((cls != ASN1_CTX) || (con != ASN1_CON)) {
+					/* tag = 3 indicating mechListMIC */
 			cFYI(1, ("Exit 4 cls = %d con = %d tag = %d end = "
 				 "%p (%d)", cls, con, tag, end, *end));
 			return 0;


