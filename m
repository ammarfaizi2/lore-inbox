Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbVCEG0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbVCEG0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVCEGUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:20:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:19596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261964AbVCEGKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:10:25 -0500
Date: Fri, 4 Mar 2005 21:58:43 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-sound@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] oss/sscape: fix section references
Message-Id: <20050304215843.3a111600.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oss/sscape: fix initdata reference used in exit:

Error: ./sound/oss/sscape.o .exit.text refers to 000000000000007d R_X86_64_PC32     .init.data+0x0000000000000003

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/sscape.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./sound/oss/sscape.c~oss_sscape_sections ./sound/oss/sscape.c
--- ./sound/oss/sscape.c~oss_sscape_sections	2005-03-01 23:38:12.000000000 -0800
+++ ./sound/oss/sscape.c	2005-03-04 21:32:05.000000000 -0800
@@ -1393,7 +1393,7 @@ static struct address_info cfg;
 static struct address_info cfg_mpu;
 
 static int __initdata spea = -1;
-static int __initdata mss = 0;
+static int mss = 0;
 static int __initdata dma = -1;
 static int __initdata irq = -1;
 static int __initdata io = -1;


---
