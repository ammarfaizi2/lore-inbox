Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTI2Uub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTI2Uub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:50:31 -0400
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:34217 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262202AbTI2Uu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:50:28 -0400
Message-ID: <3F789AAB.3000208@stesmi.com>
Date: Mon, 29 Sep 2003 22:48:43 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030916
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Subject: [PATCH]Aironet driver does not compile in 2.4.23-pre5
Content-Type: multipart/mixed;
 boundary="------------010402020501080407040900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010402020501080407040900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

The Aironet driver does not compile under 2.4.23-pre5. Simple fix
included.

// Stefan

--------------010402020501080407040900
Content-Type: text/plain;
 name="airo-fix-2.4.23-pre5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="airo-fix-2.4.23-pre5.diff"

diff -urN linux-2.4.23-pre5/drivers/net/wireless/airo.c linux-2.4.23-pre5-new/drivers/net/wireless/airo.c
--- linux-2.4.23-pre5/drivers/net/wireless/airo.c	2003-09-29 21:46:38.000000000 +0200
+++ linux-2.4.23-pre5-new/drivers/net/wireless/airo.c	2003-09-29 22:35:38.000000000 +0200
@@ -202,7 +202,7 @@
 #ifndef RUN_AT
 #define RUN_AT(x) (jiffies+(x))
 #endif
-#if LINUX_VERSION_CODE < 0x020500
+#if LINUX_VERSION_CODE < 0x020417	/* 2.4.23 */
 static inline struct proc_dir_entry *PDE(const struct inode *inode)
 {
 	return inode->u.generic_ip;

--------------010402020501080407040900--

