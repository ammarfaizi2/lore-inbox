Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUKPXd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUKPXd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUKPXc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:32:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:55680 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261897AbUKPX3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:29:44 -0500
Message-ID: <419A89A3.90903@osdl.org>
Date: Tue, 16 Nov 2004 15:13:39 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kraxel@bytesex.org, jelle@foks.8m.com, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: [PATCH] cx88: fix printk arg. type
Content-Type: multipart/mixed;
 boundary="------------080503030009050902080503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080503030009050902080503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


drivers/media/video/cx88/cx88-blackbird.c:366: warning: long int
format, size_t arg (arg 3)

diffstat:=
   drivers/media/video/cx88/cx88-blackbird.c |    2 +-
   1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


--------------080503030009050902080503
Content-Type: text/x-patch;
 name="cx88_types.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cx88_types.patch"

diff -Naurp ./drivers/media/video/cx88/cx88-blackbird.c~cx88_types ./drivers/media/video/cx88/cx88-blackbird.c
--- ./drivers/media/video/cx88/cx88-blackbird.c~cx88_types	2004-11-16 13:33:31.446369688 -0800
+++ ./drivers/media/video/cx88/cx88-blackbird.c	2004-11-16 14:34:56.221198768 -0800
@@ -363,7 +363,7 @@ static int blackbird_load_firmware(struc
 	}
 
 	if (firmware->size != BLACKBIRD_FIRM_IMAGE_SIZE) {
-		dprintk(0, "ERROR: Firmware size mismatch (have %ld, expected %d)\n",
+		dprintk(0, "ERROR: Firmware size mismatch (have %Zd, expected %d)\n",
 			firmware->size, BLACKBIRD_FIRM_IMAGE_SIZE);
 		return -1;
 	}


--------------080503030009050902080503--
