Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUEVUJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUEVUJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUEVUJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 16:09:36 -0400
Received: from village.ehouse.ru ([193.111.92.18]:22278 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261897AbUEVUJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 16:09:35 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] befs: nls fix
Date: Sun, 23 May 2004 00:09:36 +0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405230009.36637.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] befs: nls fix

Fix nls support for character sets with character width large than 1.

===== fs/befs/linuxvfs.c 1.20 vs edited =====
--- 1.20/fs/befs/linuxvfs.c	Sat May 15 06:00:21 2004
+++ edited/fs/befs/linuxvfs.c	Sat May 22 23:38:50 2004
@@ -571,7 +571,7 @@
 		}
 
 		/* convert from Unicode to nls */
-		unilen = nls->uni2char(uni, &result[o], 1);
+		unilen = nls->uni2char(uni, &result[o], in_len - o);
 		if (unilen < 0) {
 			goto conv_err;
 		}



