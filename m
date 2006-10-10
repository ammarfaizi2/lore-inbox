Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWJJR5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWJJR5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWJJR5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:57:31 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:28329
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964884AbWJJR5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:57:31 -0400
Subject: [PATCH] synclink remove PAGE_SIZE reference
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 12:57:11 -0500
Message-Id: <1160503031.5533.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove reference to PAGE_SIZE that causes
errors if PAGE_SIZE != 4096

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.18/drivers/char/synclink.c	2006-09-19 22:42:06.000000000 -0500
+++ b/drivers/char/synclink.c	2006-10-10 12:50:28.000000000 -0500
@@ -135,8 +135,8 @@ static MGSL_PARAMS default_params = {
 };
 
 #define SHARED_MEM_ADDRESS_SIZE 0x40000
-#define BUFFERLISTSIZE (PAGE_SIZE)
-#define DMABUFFERSIZE (PAGE_SIZE)
+#define BUFFERLISTSIZE 4096
+#define DMABUFFERSIZE 4096
 #define MAXRXFRAMES 7
 
 typedef struct _DMABUFFERENTRY


