Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVDDVGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVDDVGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVDDVF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:05:29 -0400
Received: from host201.dif.dk ([193.138.115.201]:13828 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261422AbVDDU7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:59:25 -0400
Date: Mon, 4 Apr 2005 23:00:47 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] cifs: cleanup asn1.c - functions
Message-ID: <Pine.LNX.4.62.0504042259390.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up function definitions to match previously agreed on style (return
type on same line as function name, parameters on same line if <80 chars,
remaining parameters on subsequent lines indented one tab).

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4-orig/fs/cifs/asn1.c	2005-03-21 23:12:40.000000000 +0100
+++ linux-2.6.12-rc1-mm4/fs/cifs/asn1.c	2005-04-04 22:25:01.000000000 +0200
@@ -99,8 +99,8 @@
 	unsigned int len;
 };
 
-static void
-asn1_open(struct asn1_ctx *ctx, unsigned char *buf, unsigned int len)
+static void asn1_open(struct asn1_ctx *ctx, unsigned char *buf,
+	unsigned int len)
 {
 	ctx->begin = buf;
 	ctx->end = buf + len;
@@ -108,8 +108,7 @@
 	ctx->error = ASN1_ERR_NOERROR;
 }
 
-static unsigned char
-asn1_octet_decode(struct asn1_ctx *ctx, unsigned char *ch)
+static unsigned char asn1_octet_decode(struct asn1_ctx *ctx, unsigned char *ch)
 {
 	if (ctx->pointer >= ctx->end) {
 		ctx->error = ASN1_ERR_DEC_EMPTY;
@@ -119,8 +118,7 @@
 	return 1;
 }
 
-static unsigned char
-asn1_tag_decode(struct asn1_ctx *ctx, unsigned int *tag)
+static unsigned char asn1_tag_decode(struct asn1_ctx *ctx, unsigned int *tag)
 {
 	unsigned char ch;
 
@@ -135,9 +133,8 @@
 	return 1;
 }
 
-static unsigned char
-asn1_id_decode(struct asn1_ctx *ctx,
-	       unsigned int *cls, unsigned int *con, unsigned int *tag)
+static unsigned char asn1_id_decode(struct asn1_ctx *ctx, unsigned int *cls,
+	unsigned int *con, unsigned int *tag)
 {
 	unsigned char ch;
 
@@ -155,8 +152,8 @@
 	return 1;
 }
 
-static unsigned char
-asn1_length_decode(struct asn1_ctx *ctx, unsigned int *def, unsigned int *len)
+static unsigned char asn1_length_decode(struct asn1_ctx *ctx,
+	unsigned int *def, unsigned int *len)
 {
 	unsigned char ch, cnt;
 
@@ -186,10 +183,9 @@
 	return 1;
 }
 
-static unsigned char
-asn1_header_decode(struct asn1_ctx *ctx,
-		   unsigned char **eoc,
-		   unsigned int *cls, unsigned int *con, unsigned int *tag)
+static unsigned char asn1_header_decode(struct asn1_ctx *ctx,
+	unsigned char **eoc, unsigned int *cls, unsigned int *con,
+	unsigned int *tag)
 {
 	unsigned int def, len;
 
@@ -206,8 +202,7 @@
 	return 1;
 }
 
-static unsigned char
-asn1_eoc_decode(struct asn1_ctx *ctx, unsigned char *eoc)
+static unsigned char asn1_eoc_decode(struct asn1_ctx *ctx, unsigned char *eoc)
 {
 	unsigned char ch;
 
@@ -238,14 +233,14 @@
 }
 
 /* static unsigned char asn1_null_decode(struct asn1_ctx *ctx,
-				      unsigned char *eoc)
+	unsigned char *eoc)
 {
 	ctx->pointer = eoc;
 	return 1;
 }
 
-static unsigned char asn1_long_decode(struct asn1_ctx *ctx,
-				      unsigned char *eoc, long *integer)
+static unsigned char asn1_long_decode(struct asn1_ctx *ctx, unsigned char *eoc,
+	long *integer)
 {
 	unsigned char ch;
 	unsigned int len;
@@ -271,9 +266,8 @@
 	return 1;
 }
 
-static unsigned char asn1_uint_decode(struct asn1_ctx *ctx,
-				      unsigned char *eoc,
-				      unsigned int *integer)
+static unsigned char asn1_uint_decode(struct asn1_ctx *ctx, unsigned char *eoc,
+	unsigned int *integer)
 {
 	unsigned char ch;
 	unsigned int len;
@@ -303,8 +297,7 @@
 }
 
 static unsigned char asn1_ulong_decode(struct asn1_ctx *ctx,
-				       unsigned char *eoc,
-				       unsigned long *integer)
+	unsigned char *eoc, unsigned long *integer)
 {
 	unsigned char ch;
 	unsigned int len;
@@ -333,10 +326,8 @@
 	return 1;
 } 
 
-static unsigned char
-asn1_octets_decode(struct asn1_ctx *ctx,
-		   unsigned char *eoc,
-		   unsigned char **octets, unsigned int *len)
+static unsigned char asn1_octets_decode(struct asn1_ctx *ctx,
+	unsigned char *eoc, unsigned char **octets, unsigned int *len)
 {
 	unsigned char *ptr;
 
@@ -359,8 +350,8 @@
 	return 1;
 } */
 
-static unsigned char
-asn1_subid_decode(struct asn1_ctx *ctx, unsigned long *subid)
+static unsigned char asn1_subid_decode(struct asn1_ctx *ctx,
+	unsigned long *subid)
 {
 	unsigned char ch;
 
@@ -376,9 +367,8 @@
 	return 1;
 }
 
-static int 
-asn1_oid_decode(struct asn1_ctx *ctx,
-		unsigned char *eoc, unsigned long **oid, unsigned int *len)
+static int asn1_oid_decode(struct asn1_ctx *ctx, unsigned char *eoc,
+	unsigned long **oid, unsigned int *len)
 {
 	unsigned long subid;
 	unsigned int size;
@@ -429,9 +419,8 @@
 	return 1;
 }
 
-static int
-compare_oid(unsigned long *oid1, unsigned int oid1len,
-	    unsigned long *oid2, unsigned int oid2len)
+static int compare_oid(unsigned long *oid1, unsigned int oid1len,
+	unsigned long *oid2, unsigned int oid2len)
 {
 	unsigned int i;
 
@@ -448,9 +437,8 @@
 
 	/* BB check for endian conversion issues here */
 
-int
-decode_negTokenInit(unsigned char *security_blob, int length,
-		    enum securityEnum *secType)
+int decode_negTokenInit(unsigned char *security_blob, int length,
+	enum securityEnum *secType)
 {
 	struct asn1_ctx ctx;
 	unsigned char *end;


