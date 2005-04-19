Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVDSVOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVDSVOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDSVOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 17:14:10 -0400
Received: from mail.dif.dk ([193.138.115.101]:36485 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261686AbVDSVNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 17:13:40 -0400
Date: Tue, 19 Apr 2005 23:16:42 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cifs: little cleanups for cifs_unicode.h - spaces
Message-ID: <Pine.LNX.4.62.0504192314110.2074@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the second part for fs/cifs/cifs_unicode.h


Fix spacing and remove pointless parenthesis from return.

This patch is also available at :
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs-cifs_unicode-spacing.patch


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

 fs/cifs/cifs_unicode.h |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.12-rc2-mm3/fs/cifs/cifs_unicode.h.with_patch1	2005-04-19 22:43:52.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/cifs/cifs_unicode.h	2005-04-19 22:55:03.000000000 +0200
@@ -68,9 +68,9 @@ static inline wchar_t *UniStrcat(wchar_t
 {
 	wchar_t *anchor = ucs1;	/* save a pointer to start of ucs1 */
 
-	while (*ucs1++) ;	/* To end of first string */
+	while (*ucs1++);	/* To end of first string */
 	ucs1--;			/* Return to the NULL */
-	while ((*ucs1++ = *ucs2++)) ;	/* copy string 2 over */
+	while ((*ucs1++ = *ucs2++));	/* copy string 2 over */
 	return anchor;
 }
 
@@ -83,7 +83,7 @@ static inline wchar_t *UniStrchr(const w
 		ucs++;
 
 	if (*ucs == uc)
-		return (wchar_t *) ucs;
+		return (wchar_t *)ucs;
 	return NULL;
 }
 
@@ -98,7 +98,7 @@ static inline int UniStrcmp(const wchar_
 		ucs1++;
 		ucs2++;
 	}
-	return (int) *ucs1 - (int) *ucs2;
+	return (int)*ucs1 - (int)*ucs2;
 }
 
 /* UniStrcpy:  Copy a string */
@@ -106,7 +106,7 @@ static inline wchar_t *UniStrcpy(wchar_t
 {
 	wchar_t *anchor = ucs1;	/* save the start of result string */
 
-	while ((*ucs1++ = *ucs2++)) ;
+	while ((*ucs1++ = *ucs2++));
 	return anchor;
 }
 
@@ -140,14 +140,14 @@ static inline wchar_t *UniStrncat(wchar_
 {
 	wchar_t *anchor = ucs1;	/* save pointer to string 1 */
 
-	while (*ucs1++) ;
+	while (*ucs1++);
 	ucs1--;			/* point to NULL terminator of s1 */
 	while (n-- && (*ucs1 = *ucs2)) {	/* copy s2 after s1 */
 		ucs1++;
 		ucs2++;
 	}
 	*ucs1 = 0;		/* NULL terminate the result */
-	return (anchor);
+	return anchor;
 }
 
 /* UniStrncmp:  Compare length limited string */
@@ -160,7 +160,7 @@ static inline int UniStrncmp(const wchar
 		ucs1++;
 		ucs2++;
 	}
-	return (int) *ucs1 - (int) *ucs2;
+	return (int)*ucs1 - (int)*ucs2;
 }
 
 /* UniStrncmp_le:  Compare length limited string - native to little-endian */
@@ -173,7 +173,7 @@ static inline int UniStrncmp_le(const wc
 		ucs1++;
 		ucs2++;
 	}
-	return (int) *ucs1 - (int) __le16_to_cpu(*ucs2);
+	return (int)*ucs1 - (int)__le16_to_cpu(*ucs2);
 }
 
 /* UniStrncpy:  Copy length limited string with pad */
@@ -219,14 +219,14 @@ static inline wchar_t *UniStrstr(const w
 			ucs2++;
 		} else {
 			if (!*ucs2)	/* Match found */
-				return (wchar_t *) anchor1;
+				return (wchar_t *)anchor1;
 			ucs1 = ++anchor1;	/* No match */
 			ucs2 = anchor2;
 		}
 	}
 
 	if (!*ucs2)	/* Both end together */
-		return (wchar_t *) anchor1;	/* Match found */
+		return (wchar_t *)anchor1;	/* Match found */
 	return NULL;	/* No match */
 }
 



