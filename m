Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267833AbRGRTXy>; Wed, 18 Jul 2001 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRTXo>; Wed, 18 Jul 2001 15:23:44 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:54614 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267833AbRGRTX2>; Wed, 18 Jul 2001 15:23:28 -0400
Date: Wed, 18 Jul 2001 15:23:33 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: acpi patch in 2.4.6
Message-ID: <20010718152333.A3393@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How is the following chunk taken from patch-2.4.6 ever going to work ?

diff -u --recursive --new-file v2.4.5/linux/drivers/acpi/os.c
linux/drivers/acpi/os.c
--- v2.4.5/linux/drivers/acpi/os.c      Mon Jan 22 13:23:43 2001
+++ linux/drivers/acpi/os.c     Sun Jun 24 20:53:07 2001
@@ -248,27 +293,27 @@
 void
 acpi_os_mem_out8 (ACPI_PHYSICAL_ADDRESS phys_addr, UINT8 value)
 {
-       *(u8*) (u32) phys_addr = value;
+       *(u8*) phys_to_virt(phys_addr) = value;
 }
 

