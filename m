Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTEVPlR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTEVPlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:41:16 -0400
Received: from holomorphy.com ([66.224.33.161]:30860 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262016AbTEVPlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:41:14 -0400
Date: Thu, 22 May 2003 08:54:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: arch/i386/kernel/srat.c cast warning fix
Message-ID: <20030522155411.GQ29926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@digeo.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -prauN mm8-2.5.69-1/arch/i386/kernel/srat.c mm8-2.5.69-2/arch/i386/kernel/srat.c
--- mm8-2.5.69-1/arch/i386/kernel/srat.c	2003-05-04 16:53:07.000000000 -0700
+++ mm8-2.5.69-2/arch/i386/kernel/srat.c	2003-05-22 08:06:42.000000000 -0700
@@ -312,7 +312,8 @@ void __init get_memcfg_from_srat(void)
 
 	if (rsdp_address->pointer_type == ACPI_PHYSICAL_POINTER) {
 		printk("%s: assigning address to rsdp\n", __FUNCTION__);
-		rsdp = (struct acpi_table_rsdp *)rsdp_address->pointer.physical;
+		rsdp = (struct acpi_table_rsdp *)
+				(u32)rsdp_address->pointer.physical;
 	} else {
 		printk("%s: rsdp_address is not a physical pointer\n", __FUNCTION__);
 		return;
