Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVCNAFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVCNAFf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVCNAFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:05:35 -0500
Received: from baikonur.stro.at ([213.239.196.228]:27571 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261594AbVCNAF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:05:26 -0500
Date: Mon, 14 Mar 2005 01:05:27 +0100
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: [patch] teles3 eliminate bad section references
Message-ID: <20050314000527.GA13729@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix teles3 section references:
  convert __initdata to __devinitdata.

Error: ./drivers/isdn/hisax/teles3.o .text refers to 000011ab R_386_32
.init.data
Error: ./drivers/isdn/hisax/teles3.o .text refers to 000011ba R_386_32
.init.data
Error: ./drivers/isdn/hisax/teles3.o .text refers to 000011e0 R_386_32
.init.data
Error: ./drivers/isdn/hisax/teles3.o .text refers to 000011fd R_386_32
.init.data
Error: ./drivers/isdn/hisax/teles3.o .text refers to 0000128c R_386_32
.init.data
Error: ./drivers/isdn/hisax/teles3.o .text refers to 00001294 R_386_32
.init.data
Error: ./drivers/isdn/hisax/teles3.o .text refers to 000012a6 R_386_32
.init.data


Signed-off-by: maximilian attems <janitor@sternwelten.at>


diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/teles3.c
linux-2.6.11-bk8-max/drivers/isdn/hisax/teles3.c
--- linux-2.6.11-bk8/drivers/isdn/hisax/teles3.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11-bk8-max/drivers/isdn/hisax/teles3.c	2005-03-14 00:47:32.000000000 +0100
@@ -254,7 +254,7 @@ Teles_card_msg(struct IsdnCardState *cs,
 
 #ifdef __ISAPNP__
 
-static struct isapnp_device_id teles_ids[] __initdata = {
+static struct isapnp_device_id teles_ids[] __devinitdata = {
 	{ ISAPNP_VENDOR('T', 'A', 'G'), ISAPNP_FUNCTION(0x2110),
 	  ISAPNP_VENDOR('T', 'A', 'G'), ISAPNP_FUNCTION(0x2110), 
 	  (unsigned long) "Teles 16.3 PnP" },
@@ -267,7 +267,7 @@ static struct isapnp_device_id teles_ids
 	{ 0, }
 };
 
-static struct isapnp_device_id *ipid __initdata = &teles_ids[0];
+static struct isapnp_device_id *ipid __devinitdata = &teles_ids[0];
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
