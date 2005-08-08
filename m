Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVHHRdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVHHRdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVHHRdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:33:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:51095 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932134AbVHHRdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:33:38 -0400
Date: Mon, 8 Aug 2005 19:33:36 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Andreas Kleen <ak@suse.de>
Subject: [PATCH] add MODULE_ALIAS for x86_64 aes
Message-ID: <20050808173336.GA11503@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


modprobe aes does not work on x86_64. i386 has a similar line,
this could be the right fix. Would be nice to have in 2.6.13 final.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/x86_64/crypto/aes.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.13-rc6-aes/arch/x86_64/crypto/aes.c
===================================================================
--- linux-2.6.13-rc6-aes.orig/arch/x86_64/crypto/aes.c
+++ linux-2.6.13-rc6-aes/arch/x86_64/crypto/aes.c
@@ -322,3 +322,4 @@ module_exit(aes_fini);
 
 MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("aes");
