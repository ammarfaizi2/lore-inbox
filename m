Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUDNU6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUDNU6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:58:16 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:60548 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261744AbUDNU4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:56:24 -0400
Date: Wed, 14 Apr 2004 04:57:11 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.5
Message-ID: <20040414045711.GE12732@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20040414045552.GB12732@neo.rr.com> <20040414045622.GC12732@neo.rr.com> <20040414045645.GD12732@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414045645.GD12732@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Wed Apr 14 04:41:24 2004
+++ b/arch/i386/kernel/dmi_scan.c	Wed Apr 14 04:41:24 2004
@@ -778,11 +778,15 @@
 			MATCH(DMI_BIOS_DATE, "10/26/01"), NO_MATCH
 			} },

-	{ exploding_pnp_bios, "Higraded P14H", {	/* BIOSPnP problem */
+	{ exploding_pnp_bios, "Higraded P14H", {	/* PnPBIOS GPF on boot */
 			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
 			MATCH(DMI_BIOS_VERSION, "07.00T"),
 			MATCH(DMI_SYS_VENDOR, "Higraded"),
 			MATCH(DMI_PRODUCT_NAME, "P14H")
+			} },
+	{ exploding_pnp_bios, "ASUS P4P800", {	/* PnPBIOS GPF on boot */
+			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
+			MATCH(DMI_BOARD_NAME, "P4P800"),
 			} },

 	/* Machines which have problems handling enabled local APICs */
