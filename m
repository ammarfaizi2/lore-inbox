Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVCNAaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVCNAaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVCNAaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:30:14 -0500
Received: from baikonur.stro.at ([213.239.196.228]:57779 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261600AbVCNA3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:29:55 -0500
Date: Mon, 14 Mar 2005 01:29:54 +0100
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: [patch] hfc_sx eliminate bad section references
Message-ID: <20050314002954.GC13729@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix hfc_sx section references:
  convert __initdata to __devinitdata.

Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000204d R_386_32
.init.data
Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000205c R_386_32
.init.data
Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 00002082 R_386_32
.init.data
Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000209f R_386_32
.init.data
Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 00002114 R_386_32
.init.data
Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000211c R_386_32          
.init.data
Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000212e R_386_32
.init.data

Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/hfc_sx.c
linux-2.6.11-bk8-max/drivers/isdn/hisax/hfc_sx.c
--- linux-2.6.11-bk8/drivers/isdn/hisax/hfc_sx.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6.11-bk8-max/drivers/isdn/hisax/hfc_sx.c	2005-03-14 01:03:42.000000000 +0100
@@ -1382,14 +1382,14 @@ hfcsx_card_msg(struct IsdnCardState *cs,
 }
 
 #ifdef __ISAPNP__
-static struct isapnp_device_id hfc_ids[] __initdata = {
+static struct isapnp_device_id hfc_ids[] __devinitdata = {
 	{ ISAPNP_VENDOR('T', 'A', 'G'), ISAPNP_FUNCTION(0x2620),
 	  ISAPNP_VENDOR('T', 'A', 'G'), ISAPNP_FUNCTION(0x2620), 
 	  (unsigned long) "Teles 16.3c2" },
 	{ 0, }
 };
 
-static struct isapnp_device_id *ipid __initdata = &hfc_ids[0];
+static struct isapnp_device_id *ipid __devinitdata = &hfc_ids[0];
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 

