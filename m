Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTBXS1m>; Mon, 24 Feb 2003 13:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbTBXS1E>; Mon, 24 Feb 2003 13:27:04 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:45013 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267546AbTBXS0P>; Mon, 24 Feb 2003 13:26:15 -0500
Date: Mon, 24 Feb 2003 19:36:24 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] extern in i2o_pci.c
In-Reply-To: <Pine.LNX.4.51.0302241919050.27815@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.51.0302241934360.7789@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0302241919050.27815@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's a following warning in 2.5.62-bk7:

drivers/message/i2o/i2o_pci.c: In function `i2o_pci_core_attach':
drivers/message/i2o/i2o_pci.c:373: warning: implicit declaration of
function `i2o_sys_init'

The following patch covers the extern.

--- linux-2.5.60/drivers/message/i2o/i2o_pci.c~	2003-02-24 19:31:41.000000000 +0100
+++ linux-2.5.60/drivers/message/i2o/i2o_pci.c	2003-02-24 19:30:04.000000000 +0100
@@ -37,6 +37,7 @@
 #endif // CONFIG_MTRR

 static int dpt;
+extern void i2o_sys_init(void);

 /**
  *	i2o_pci_dispose		-	Free bus specific resources
