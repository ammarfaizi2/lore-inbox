Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbUKPX3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUKPX3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUKPX1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:27:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:15342 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261902AbUKPX0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:26:33 -0500
Message-ID: <419A89A8.10704@osdl.org>
Date: Tue, 16 Nov 2004 15:13:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: scottm@somanetworks.com, greg@kroah.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpcihp_generic: fix module_param data type
Content-Type: multipart/mixed;
 boundary="------------020709090809020501070506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020709090809020501070506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


drivers/pci/hotplug/cpcihp_generic.c:214: warning: return from
incompatible pointer type

diffstat:=
   drivers/pci/hotplug/cpcihp_generic.c |    2 +-
   1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


--------------020709090809020501070506
Content-Type: text/x-patch;
 name="cpcihp_charp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpcihp_charp.patch"

diff -Naurp ./drivers/pci/hotplug/cpcihp_generic.c~cpcihp_charp ./drivers/pci/hotplug/cpcihp_generic.c
--- ./drivers/pci/hotplug/cpcihp_generic.c~cpcihp_charp	2004-11-16 13:33:33.572046536 -0800
+++ ./drivers/pci/hotplug/cpcihp_generic.c	2004-11-16 14:30:06.588229672 -0800
@@ -63,7 +63,7 @@
 
 /* local variables */
 static int debug;
-static char bridge[256];
+static char *bridge;
 static u8 bridge_busnr;
 static u8 bridge_slot;
 static struct pci_bus *bus;


--------------020709090809020501070506--
