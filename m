Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVCNA2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVCNA2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVCNA2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:28:40 -0500
Received: from baikonur.stro.at ([213.239.196.228]:56755 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261599AbVCNA2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:28:37 -0500
Date: Mon, 14 Mar 2005 01:28:38 +0100
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: [patch] elsa eliminate bad section references
Message-ID: <20050314002838.GB13729@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix elsa section references:
  convert __initdata to __devinitdata.

Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003d28 R_386_32
.init.data
Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003d37 R_386_32
.init.data
Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003d56 R_386_32
.init.data
Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003d77 R_386_32
.init.data
Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003ddb R_386_32
.init.data
Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003e0e R_386_32
.init.data
Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003e20 R_386_32
.init.data

Signed-off-by: maximilian attems <janitor@sternwelten.at>


diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/elsa.c
linux-2.6.11-bk8-max/drivers/isdn/hisax/elsa.c
--- linux-2.6.11-bk8/drivers/isdn/hisax/elsa.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.11-bk8-max/drivers/isdn/hisax/elsa.c	2005-03-14 01:04:02.000000000 +0100
@@ -838,7 +838,7 @@ static 	struct pci_dev *dev_qs1000 __dev
 static 	struct pci_dev *dev_qs3000 __devinitdata = NULL;
 
 #ifdef __ISAPNP__
-static struct isapnp_device_id elsa_ids[] __initdata = {
+static struct isapnp_device_id elsa_ids[] __devinitdata = {
 	{ ISAPNP_VENDOR('E', 'L', 'S'), ISAPNP_FUNCTION(0x0133),
 	  ISAPNP_VENDOR('E', 'L', 'S'), ISAPNP_FUNCTION(0x0133), 
 	  (unsigned long) "Elsa QS1000" },
@@ -848,7 +848,7 @@ static struct isapnp_device_id elsa_ids[
 	{ 0, }
 };
 
-static struct isapnp_device_id *ipid __initdata = &elsa_ids[0];
+static struct isapnp_device_id *ipid __devinitdata = &elsa_ids[0];
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 

