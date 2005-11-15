Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVKOVm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVKOVm1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVKOVm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:42:27 -0500
Received: from heidi.rubysoft.com ([64.34.164.143]:53444 "EHLO
	heidi.rubysoft.com") by vger.kernel.org with ESMTP id S1750839AbVKOVm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:42:26 -0500
Message-ID: <437A5630.90401@cardaccess-inc.com>
Date: Tue, 15 Nov 2005 14:42:08 -0700
From: Jeff Hansen <jhansen@cardaccess-inc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IXDP425 Setup Bug
Content-Type: multipart/mixed;
 boundary="------------020902020407080407020802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020902020407080407020802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

To whom it is concerned:

There is a typo in the ARM IXDP425 setup definition that mistakenly 
tries to use UART1's IRQ for UART2's traffic.  The patch is attached.

-Jeff Hansen
Card Access, Inc.


--------------020902020407080407020802
Content-Type: text/x-patch;
 name="ixdp425-setup.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ixdp425-setup.c.patch"

--- arch/arm/mach-ixp4xx/ixdp425-setup.c.orig	2005-11-15 13:54:16.000000000 -0700
+++ arch/arm/mach-ixp4xx/ixdp425-setup.c	2005-11-15 14:20:23.000000000 -0700
@@ -90,7 +90,7 @@
 	{
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
 		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
-		.irq		= IRQ_IXP4XX_UART1,
+		.irq		= IRQ_IXP4XX_UART2,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,

--------------020902020407080407020802--
