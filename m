Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269328AbUJQXPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269328AbUJQXPf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269335AbUJQXPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:15:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:61662 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269328AbUJQXOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:14:24 -0400
Message-ID: <4172FA8B.6010308@osdl.org>
Date: Sun, 17 Oct 2004 16:04:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jolt@tuxbox.org
Subject: [PATCH] bt878: discarded reference
Content-Type: multipart/mixed;
 boundary="------------060000000900040709030504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060000000900040709030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------060000000900040709030504
Content-Type: text/x-patch;
 name="bt878_devexit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bt878_devexit.patch"


Error: ./drivers/media/dvb/bt8xx/bt878.o .data refers to 0000000000000048 R_X86_64_64       .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/media/dvb/bt8xx/bt878.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/media/dvb/bt8xx/bt878.c~bt878_devexit ./drivers/media/dvb/bt8xx/bt878.c
--- ./drivers/media/dvb/bt8xx/bt878.c~bt878_devexit	2004-10-11 21:17:56.000000000 -0700
+++ ./drivers/media/dvb/bt8xx/bt878.c	2004-10-17 11:27:29.000000000 -0700
@@ -559,7 +559,7 @@ static struct pci_driver bt878_pci_drive
       .name 	= "bt878",
       .id_table = bt878_pci_tbl,
       .probe 	= bt878_probe,
-      .remove 	= bt878_remove,
+      .remove 	= __devexit_p(bt878_remove),
 };
 
 static int bt878_pci_driver_registered = 0;


--------------060000000900040709030504--
