Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVCGUw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVCGUw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVCGUol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:44:41 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:30641 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261790AbVCGUNA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:00 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [6/many] acrypto: crypto_conn.h
In-Reply-To: <1110227853764@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:34 +0300
Message-Id: <11102278544080@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:24 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_conn.h	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_conn.h	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,45 @@
+/*
+ * 	crypto_conn.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __CRYPTO_CONN_H
+#define __CRYPTO_CONN_H
+
+#include "acrypto.h"
+
+#define CRYPTO_READ_SESSIONS			0
+#define CRYPTO_REQUEST				1
+#define CRYPTO_GET_STAT				2
+
+struct crypto_conn_data 
+{
+	char 		name[SCACHE_NAMELEN];
+	__u16 		cmd;
+	__u16 		len;
+	__u8 		data[0];
+};
+
+#ifdef __KERNEL__
+
+int crypto_conn_init(void);
+void crypto_conn_fini(void);
+
+#endif				/* __KERNEL__ */
+#endif				/* __CRYPTO_CONN_H */

