Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269324AbUJQXNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbUJQXNr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269325AbUJQXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:13:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:44254 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269324AbUJQXNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:13:42 -0400
Message-ID: <4172FA91.4090407@osdl.org>
Date: Sun, 17 Oct 2004 16:04:49 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       kraxel@bytesex.org
Subject: [PATCH] cx88: discarded reference
Content-Type: multipart/mixed;
 boundary="------------050504040503030103000001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050504040503030103000001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------050504040503030103000001
Content-Type: text/x-patch;
 name="cx88_devexit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cx88_devexit.patch"


Error: ./drivers/media/video/cx88/cx88-video.o .data refers to 0000000000000b28 R_X86_64_64       .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/media/video/cx88/cx88-video.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/media/video/cx88/cx88-video.c~cx88_devexit ./drivers/media/video/cx88/cx88-video.c
--- ./drivers/media/video/cx88/cx88-video.c~cx88_devexit	2004-08-13 22:36:59.000000000 -0700
+++ ./drivers/media/video/cx88/cx88-video.c	2004-10-17 11:29:36.000000000 -0700
@@ -2595,7 +2595,7 @@ static struct pci_driver cx8800_pci_driv
         .name     = "cx8800",
         .id_table = cx8800_pci_tbl,
         .probe    = cx8800_initdev,
-        .remove   = cx8800_finidev,
+        .remove   = __devexit_p(cx8800_finidev),
 
 	.suspend  = cx8800_suspend,
 	.resume   = cx8800_resume,


--------------050504040503030103000001--
