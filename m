Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVDDUci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVDDUci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVDDUci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:32:38 -0400
Received: from host201.dif.dk ([193.138.115.201]:10258 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261369AbVDDUSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:18:09 -0400
Date: Mon, 4 Apr 2005 22:20:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cifs: beautify fs/cifs/rfc1002pdu.h a little bit
 (whitespace changes only)
Message-ID: <Pine.LNX.4.62.0504042218140.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beautify rfc1002pdu.h a bit. Whitespace changes only.

Patch also available here: 
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_rfc1002pdu.patch


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4-orig/fs/cifs/rfc1002pdu.h	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.12-rc1-mm4/fs/cifs/rfc1002pdu.h	2005-04-04 22:15:33.000000000 +0200
@@ -26,15 +26,16 @@
 /* NB: unlike smb/cifs packets, the RFC1002 structures are big endian */
 
 	/* RFC 1002 session packet types */
-#define RFC1002_SESSION_MESASAGE 0x00
-#define RFC1002_SESSION_REQUEST  0x81
-#define RFC1002_POSITIVE_SESSION_RESPONSE 0x82
-#define RFC1002_NEGATIVE_SESSION_RESPONSE 0x83
-#define RFC1002_RETARGET_SESSION_RESPONSE 0x83
-#define RFC1002_SESSION_KEEP_ALIVE 0x85
-
-	/* RFC 1002 flags (only one defined */
-#define RFC1002_LENGTH_EXTEND 0x80 /* high order bit of length (ie +64K) */
+#define RFC1002_SESSION_MESASAGE		0x00
+#define RFC1002_SESSION_REQUEST			0x81
+#define RFC1002_POSITIVE_SESSION_RESPONSE	0x82
+#define RFC1002_NEGATIVE_SESSION_RESPONSE	0x83
+#define RFC1002_RETARGET_SESSION_RESPONSE	0x83
+#define RFC1002_SESSION_KEEP_ALIVE		0x85
+
+	/* RFC 1002 flags (only one defined) */
+#define RFC1002_LENGTH_EXTEND			0x80	/* high order bit of
+							   length (ie +64K) */
 
 struct rfc1002_session_packet {
 	__u8	type;
@@ -55,25 +56,24 @@
 		} retarget_resp;
 		__u8 neg_ses_resp_error_code;
 		/* POSITIVE_SESSION_RESPONSE packet does not include trailer.
-		SESSION_KEEP_ALIVE packet also does not include a trailer.
-		Trailer for the SESSION_MESSAGE packet is SMB/CIFS header */
+		   SESSION_KEEP_ALIVE packet also does not include a trailer.
+		   Trailer for the SESSION_MESSAGE packet is SMB/CIFS header */
 	} trailer;
 };
 
 /* Negative Session Response error codes */
-#define RFC1002_NOT_LISTENING_CALLED  0x80 /* not listening on called name */
-#define RFC1002_NOT_LISTENING_CALLING 0x81 /* not listening on calling name */
-#define RFC1002_NOT_PRESENT           0x82 /* called name not present */
-#define RFC1002_INSUFFICIENT_RESOURCE 0x83
-#define RFC1002_UNSPECIFIED_ERROR     0x8F
-
-/* RFC 1002 Datagram service packets are not defined here as they
-are not needed for the network filesystem client unless we plan on
-implementing broadcast resolution of the server ip address (from
-server netbios name). Currently server names are resolved only via DNS
-(tcp name) or ip address or an /etc/hosts equivalent mapping to ip address.*/
+#define RFC1002_NOT_LISTENING_CALLED	0x80 /* not listening on called name */
+#define RFC1002_NOT_LISTENING_CALLING	0x81 /* not listening on calling name */
+#define RFC1002_NOT_PRESENT		0x82 /* called name not present */
+#define RFC1002_INSUFFICIENT_RESOURCE	0x83
+#define RFC1002_UNSPECIFIED_ERROR	0x8F
+
+/* RFC 1002 Datagram service packets are not defined here as they are not
+   needed for the network filesystem client unless we plan on implementing
+   broadcast resolution of the server ip address (from server netbios name).
+   Currently server names are resolved only via DNS (tcp name) or ip address or
+   an /etc/hosts equivalent mapping to ip address.*/
 
-#define DEFAULT_CIFS_CALLED_NAME  "*SMBSERVER      "
+#define DEFAULT_CIFS_CALLED_NAME	"*SMBSERVER      "
 
 #pragma pack()		/* resume default structure packing */
-                                                             



