Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269318AbUJQXN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269318AbUJQXN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269323AbUJQXN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:13:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:35294 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269318AbUJQXNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:13:25 -0400
Message-ID: <4172FA7F.5090303@osdl.org>
Date: Sun, 17 Oct 2004 16:04:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kraxel@bytesex.org, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: [PATCH] saa7134: discarded reference
Content-Type: multipart/mixed;
 boundary="------------050803000908060906000506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050803000908060906000506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050803000908060906000506
Content-Type: text/x-patch;
 name="saa7134_devexit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="saa7134_devexit.patch"


Error: ./drivers/media/video/saa7134/saa7134-core.o .data refers to 0000000000000028 R_X86_64_64       .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/media/video/saa7134/saa7134-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/media/video/saa7134/saa7134-core.c~saa7134_devexit ./drivers/media/video/saa7134/saa7134-core.c
--- ./drivers/media/video/saa7134/saa7134-core.c~saa7134_devexit	2004-10-11 21:17:56.000000000 -0700
+++ ./drivers/media/video/saa7134/saa7134-core.c	2004-10-17 11:31:09.000000000 -0700
@@ -1085,7 +1085,7 @@ static struct pci_driver saa7134_pci_dri
         .name     = "saa7134",
         .id_table = saa7134_pci_tbl,
         .probe    = saa7134_initdev,
-        .remove   = saa7134_finidev,
+        .remove   = __devexit_p(saa7134_finidev),
 };
 
 static int saa7134_init(void)

--------------050803000908060906000506--
