Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSJNHQ3>; Mon, 14 Oct 2002 03:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSJNHQ2>; Mon, 14 Oct 2002 03:16:28 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:5388 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id <S261855AbSJNHQ2> convert rfc822-to-8bit;
	Mon, 14 Oct 2002 03:16:28 -0400
Message-ID: <002301c27355$7cfa7b80$5fa864c2@windows>
From: "Matti Annala" <gval@mbnet.fi>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] include/asm-*/init.h removal
Date: Mon, 14 Oct 2002 10:44:11 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-OriginalArrivalTime: 14 Oct 2002 08:18:57.0428 (UTC) FILETIME=[57A1FD40:01C2735A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tiny patch below removes the last "#include <asm/init.h>" from the kernel tree and thus renders the include/asm-*/init.h headers useless. The source file didn't seem to need anything from the include/linux/init.h header so I simply removed the line. The include/asm-*/init.h headers can now be safely removed.

diff -ur linux-2.5.42/drivers/macintosh/via-macii.c difflinux/drivers/macintosh/via-macii.c
--- linux-2.5.42/drivers/macintosh/via-macii.c 2002-10-12 07:22:10.000000000 +0300
+++ difflinux/drivers/macintosh/via-macii.c 2002-10-11 17:35:38.000000000 +0300
@@ -27,7 +27,6 @@
 #include <asm/mac_via.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/init.h>
 
 static volatile unsigned char *via;
 


