Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263744AbTH1Fqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTH1Foc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:44:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:27557 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263734AbTH1FHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:07:07 -0400
Date: Wed, 27 Aug 2003 22:05:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: [PATCH] fix arcnet printk parameter types
Message-Id: <20030827220513.6f102378.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Please apply.

patch_name:	arcnet_sizes.patch
patch_version:	2003-08-27.18:18:38
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	arcnet: fix printk parameter types;
product:	Linux
product_versions: 260-test4
maintainer:	??

diff -Naur ./drivers/net/arcnet/arcnet.c~arcsize ./drivers/net/arcnet/arcnet.c
--- ./drivers/net/arcnet/arcnet.c~arcsize	Fri Aug 22 16:57:49 2003
+++ ./drivers/net/arcnet/arcnet.c	Wed Aug 27 11:39:26 2003
@@ -135,7 +135,7 @@
 		arc_proto_map[count] = arc_proto_default;
 
 	BUGLVL(D_DURING)
-	    printk("arcnet: struct sizes: %d %d %d %d %d\n",
+	    printk("arcnet: struct sizes: %Zd %Zd %Zd %Zd %Zd\n",
 		 sizeof(struct arc_hardware), sizeof(struct arc_rfc1201),
 		sizeof(struct arc_rfc1051), sizeof(struct arc_eth_encap),
 		   sizeof(struct archdr));


--
~Randy
