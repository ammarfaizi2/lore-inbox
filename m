Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVDDVGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVDDVGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVDDVEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:04:38 -0400
Received: from host201.dif.dk ([193.138.115.201]:18180 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261398AbVDDVAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:00:44 -0400
Date: Mon, 4 Apr 2005 23:03:02 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cifs: cleanup asn1.c - spacing and long lines
Message-ID: <Pine.LNX.4.62.0504042301510.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up trailing whitespace, spacing in if statements etc and break long lines.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4/fs/cifs/asn1.c.with_patch2	2005-04-04 22:34:03.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/asn1.c	2005-04-04 22:48:15.000000000 +0200
@@ -63,7 +63,7 @@
 #define ASN1_VISSTR	26	/* Visible String */
 #define ASN1_GENSTR	27	/* General String */
 
-/* Primitive / Constructed methods*/
+/* Primitive / Constructed methods */
 #define ASN1_PRI	0	/* Primitive */
 #define ASN1_CON	1	/* Constructed */
 
@@ -76,8 +76,8 @@
 #define ASN1_ERR_DEC_LENGTH_MISMATCH	4
 #define ASN1_ERR_DEC_BADVALUE		5
 
-#define SPNEGO_OID_LEN 7
-#define NTLMSSP_OID_LEN  10
+#define SPNEGO_OID_LEN	7
+#define NTLMSSP_OID_LEN	10
 static unsigned long SPNEGO_OID[7] = { 1, 3, 6, 1, 5, 5, 2 };
 static unsigned long NTLMSSP_OID[10] = { 1, 3, 6, 1, 4, 1, 311, 2, 2, 10 };
 
@@ -168,7 +168,7 @@ static unsigned char asn1_length_decode(
 		if (ch < 0x80)
 			*len = ch;
 		else {
-			cnt = (unsigned char) (ch & 0x7F);
+			cnt = (unsigned char)(ch & 0x7F);
 			*len = 0;
 
 			while (cnt > 0) {
@@ -324,7 +324,7 @@ static unsigned char asn1_ulong_decode(s
 		*integer |= ch;
 	}
 	return 1;
-} 
+}
 
 static unsigned char asn1_octets_decode(struct asn1_ctx *ctx,
 	unsigned char *eoc, unsigned char **octets, unsigned int *len)
@@ -375,7 +375,7 @@ static int asn1_oid_decode(struct asn1_c
 	unsigned long *optr;
 
 	size = eoc - ctx->pointer + 1;
-	*oid = kmalloc(size * sizeof (unsigned long), GFP_ATOMIC);
+	*oid = kmalloc(size * sizeof(unsigned long), GFP_ATOMIC);
 	if (*oid == NULL) {
 		return 0;
 	}
@@ -486,8 +486,8 @@ int decode_negTokenInit(unsigned char *s
 			return 0;
 		} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
 			   || (tag != ASN1_EOC)) {
-			cFYI(1,("cls = %d con = %d tag = %d end = %p (%d) exit 0",
-			      cls, con, tag, end, *end));
+			cFYI(1, ("cls = %d con = %d tag = %d end = %p (%d) "
+				 "exit 0", cls, con, tag, end, *end));
 			return 0;
 		}
 
@@ -496,8 +496,8 @@ int decode_negTokenInit(unsigned char *s
 			return 0;
 		} else if ((cls != ASN1_UNI) || (con != ASN1_CON)
 			   || (tag != ASN1_SEQ)) {
-			cFYI(1,("cls = %d con = %d tag = %d end = %p (%d) exit 1",
-			      cls, con, tag, end, *end));
+			cFYI(1, ("cls = %d con = %d tag = %d end = %p (%d) "
+				 "exit 1", cls, con, tag, end, *end));
 			return 0;
 		}
 
@@ -506,96 +506,93 @@ int decode_negTokenInit(unsigned char *s
 			return 0;
 		} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
 			   || (tag != ASN1_EOC)) {
-			cFYI(1,
-			     ("cls = %d con = %d tag = %d end = %p (%d) exit 0",
-			      cls, con, tag, end, *end));
+			cFYI(1, ("cls = %d con = %d tag = %d end = %p (%d) "
+				 "exit 0", cls, con, tag, end, *end));
 			return 0;
 		}
 
-		if (asn1_header_decode
-		    (&ctx, &sequence_end, &cls, &con, &tag) == 0) {
+		if (asn1_header_decode(&ctx, &sequence_end, &cls, &con, &tag)
+		    == 0) {
 			cFYI(1, ("Error decoding 2nd part of negTokenInit "));
 			return 0;
 		} else if ((cls != ASN1_UNI) || (con != ASN1_CON)
 			   || (tag != ASN1_SEQ)) {
-			cFYI(1,
-			     ("cls = %d con = %d tag = %d end = %p (%d) exit 1",
-			      cls, con, tag, end, *end));
+			cFYI(1, ("cls = %d con = %d tag = %d end = %p (%d) "
+				 "exit 1", cls, con, tag, end, *end));
 			return 0;
 		}
 
 		while (!asn1_eoc_decode(&ctx, sequence_end)) {
 			rc = asn1_header_decode(&ctx, &end, &cls, &con, &tag);
 			if (!rc) {
-				cFYI(1,
-				     ("Error 1 decoding negTokenInit header exit 2"));
+				cFYI(1, ("Error 1 decoding negTokenInit header"
+					 " exit 2"));
 				return 0;
 			}
 			if ((tag == ASN1_OJI) && (con == ASN1_PRI)) {
 				rc = asn1_oid_decode(&ctx, end, &oid, &oidlen);
-				if(rc) {		
-					cFYI(1,
-					  ("OID len = %d oid = 0x%lx 0x%lx 0x%lx 0x%lx",
-					   oidlen, *oid, *(oid + 1), *(oid + 2),
-					   *(oid + 3)));
-					rc = compare_oid(oid, oidlen, NTLMSSP_OID,
-						 NTLMSSP_OID_LEN);
-						kfree(oid);
+				if (rc) {
+					cFYI(1, ("OID len = %d oid = "
+						 "0x%lx 0x%lx 0x%lx 0x%lx",
+						 oidlen, *oid, *(oid + 1),
+						 *(oid + 2), *(oid + 3)));
+					rc = compare_oid(oid, oidlen,
+							 NTLMSSP_OID,
+							 NTLMSSP_OID_LEN);
+					kfree(oid);
 					if (rc)
 						use_ntlmssp = TRUE;
 				}
 			} else {
-				cFYI(1,("This should be an oid what is going on? "));
+				cFYI(1, ("This should be an oid what is going"
+					 " on? "));
 			}
 		}
 
 		if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
-			cFYI(1,
-			     ("Error decoding last part of negTokenInit exit 3"));
+			cFYI(1, ("Error decoding last part of negTokenInit "
+				 "exit 3"));
 			return 0;
 		} else if ((cls != ASN1_CTX) || (con != ASN1_CON)) {	/* tag = 3 indicating mechListMIC */
-			cFYI(1,
-			     ("Exit 4 cls = %d con = %d tag = %d end = %p (%d)",
-			      cls, con, tag, end, *end));
+			cFYI(1, ("Exit 4 cls = %d con = %d tag = %d end = "
+				 "%p (%d)", cls, con, tag, end, *end));
 			return 0;
 		}
 		if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
-			cFYI(1,
-			     ("Error decoding last part of negTokenInit exit 5"));
+			cFYI(1, ("Error decoding last part of negTokenInit "
+				 "exit 5"));
 			return 0;
 		} else if ((cls != ASN1_UNI) || (con != ASN1_CON)
 			   || (tag != ASN1_SEQ)) {
-			cFYI(1,
-			     ("Exit 6 cls = %d con = %d tag = %d end = %p (%d)",
-			      cls, con, tag, end, *end));
+			cFYI(1, ("Exit 6 cls = %d con = %d tag = %d end = "
+				 "%p (%d)", cls, con, tag, end, *end));
 		}
 
 		if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
-			cFYI(1,
-			     ("Error decoding last part of negTokenInit exit 7"));
+			cFYI(1, ("Error decoding last part of negTokenInit "
+				 "exit 7"));
 			return 0;
 		} else if ((cls != ASN1_CTX) || (con != ASN1_CON)) {
-			cFYI(1,
-			     ("Exit 8 cls = %d con = %d tag = %d end = %p (%d)",
-			      cls, con, tag, end, *end));
+			cFYI(1, ("Exit 8 cls = %d con = %d tag = %d end = "
+				 "%p (%d)", cls, con, tag, end, *end));
 			return 0;
 		}
 		if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
-			cFYI(1,
-			     ("Error decoding last part of negTokenInit exit 9"));
+			cFYI(1, ("Error decoding last part of negTokenInit "
+				 "exit 9"));
 			return 0;
 		} else if ((cls != ASN1_UNI) || (con != ASN1_PRI)
 			   || (tag != ASN1_GENSTR)) {
-			cFYI(1,
-			     ("Exit 10 cls = %d con = %d tag = %d end = %p (%d)",
-			      cls, con, tag, end, *end));
+			cFYI(1, ("Exit 10 cls = %d con = %d tag = %d end = "
+				 "%p (%d)", cls, con, tag, end, *end));
 			return 0;
 		}
-		cFYI(1, ("Need to call asn1_octets_decode() function for this %s", ctx.pointer));	/* is this UTF-8 or ASCII? */
+		cFYI(1, ("Need to call asn1_octets_decode() function for this"
+			 " %s", ctx.pointer));	/* is this UTF-8 or ASCII? */
 	}
 
-	/* if (use_kerberos) 
-	   *secType = Kerberos 
+	/* if (use_kerberos)
+		*secType = Kerberos
 	   else */
 	if (use_ntlmssp) {
 		*secType = NTLMSSP;


