Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315757AbSENPK1>; Tue, 14 May 2002 11:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSENPK1>; Tue, 14 May 2002 11:10:27 -0400
Received: from krynn.axis.se ([193.13.178.10]:36012 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S315757AbSENPKZ>;
	Tue, 14 May 2002 11:10:25 -0400
Message-ID: <20f701c1fb59$a3344f20$0b070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: <marcelo@conectiva.com.br>, <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Missing include of asm/io.h in mm/bootmem.c
Date: Tue, 14 May 2002 17:11:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's needed by phys_to_virt() but it happens to work on i386
since dma.h includes io.h for that arch.

Please apply to both 2.4 and 2.5.

/Johan


--- linux/mm/bootmem.c   7 Jan 2002 13:33:59 -0000       1.1.1.7
+++ linux/mm/bootmem.c   7 Jan 2002 15:23:19 -0000       1.12
@@ -18,6 +18,7 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <asm/dma.h>
+#include <asm/io.h>


