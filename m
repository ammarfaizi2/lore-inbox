Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264681AbUDVVRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264681AbUDVVRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUDVVRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:17:52 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:9681 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S264681AbUDVVRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:17:50 -0400
Message-ID: <40883663.5020506@suse.cz>
Date: Thu, 22 Apr 2004 23:17:23 +0200
From: Michal Ludvig <mludvig@suse.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] crypto_null autoload
Content-Type: multipart/mixed;
 boundary="------------020105070708060603050508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020105070708060603050508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the attached patch enables autoload of crypto_null module. Please apply.

Michal Ludvig
-- 
SUSE Labs                    mludvig@suse.cz
(+420) 296.545.373        http://www.suse.cz
Personal homepage http://www.logix.cz/michal

--------------020105070708060603050508
Content-Type: text/plain;
 name="kernel-cryptonull.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-cryptonull.diff"

--- linux-2.6.5.orig/crypto/crypto_null.c	2004-04-04 05:36:58.000000000 +0200
+++ linux-2.6.5/crypto/crypto_null.c	2004-04-22 22:47:22.323413336 +0200
@@ -94,6 +94,10 @@
 	.cia_decrypt		=	null_decrypt } }
 };
 
+MODULE_ALIAS("compress_null");
+MODULE_ALIAS("digest_null");
+MODULE_ALIAS("cipher_null");
+
 static int __init init(void)
 {
 	int ret = 0;

--------------020105070708060603050508--
