Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVCNAao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVCNAao (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVCNAao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:30:44 -0500
Received: from baikonur.stro.at ([213.239.196.228]:62643 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261602AbVCNAaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:30:19 -0500
Date: Mon, 14 Mar 2005 01:30:18 +0100
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: [patch] sedlbauer eliminate bad section references
Message-ID: <20050314003018.GD13729@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sedlbauer section references:
  convert __initdata to __devinitdata.


Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 0000235f R_386_32
.init.data
Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 0000236e R_386_32
.init.data
Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 0000238d R_386_32
.init.data
Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 000023b2 R_386_32
.init.data
Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 00002417 R_386_32
.init.data
Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 0000244c R_386_32
.init.data

Signed-off-by: maximilian attems <janitor@sternwelten.at>


diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/sedlbauer.c
linux-2.6.11-bk8-max/drivers/isdn/hisax/sedlbauer.c
--- linux-2.6.11-bk8/drivers/isdn/hisax/sedlbauer.c	2005-03-02 08:38:32.000000000 +0100
+++ linux-2.6.11-bk8-max/drivers/isdn/hisax/sedlbauer.c	2005-03-14 01:03:14.000000000 +0100
@@ -516,7 +516,7 @@ Sedl_card_msg(struct IsdnCardState *cs, 
 static struct pci_dev *dev_sedl __devinitdata = NULL;
 
 #ifdef __ISAPNP__
-static struct isapnp_device_id sedl_ids[] __initdata = {
+static struct isapnp_device_id sedl_ids[] __devinitdata = {
 	{ ISAPNP_VENDOR('S', 'A', 'G'), ISAPNP_FUNCTION(0x01),
 	  ISAPNP_VENDOR('S', 'A', 'G'), ISAPNP_FUNCTION(0x01), 
 	  (unsigned long) "Speed win" },
@@ -526,7 +526,7 @@ static struct isapnp_device_id sedl_ids[
 	{ 0, }
 };
 
-static struct isapnp_device_id *ipid __initdata = &sedl_ids[0];
+static struct isapnp_device_id *ipid __devinitdata = &sedl_ids[0];
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
