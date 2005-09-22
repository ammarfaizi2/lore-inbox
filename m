Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVIVS7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVIVS7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVIVS7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:59:35 -0400
Received: from dvhart.com ([64.146.134.43]:44424 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751121AbVIVS7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:59:35 -0400
Date: Thu, 22 Sep 2005 11:59:37 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <64900000.1127415577@[10.10.2.4]>
In-Reply-To: <20050921222839.76c53ba1.akpm@osdl.org>
References: <20050921222839.76c53ba1.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Build breaks with this config (x440/summit): 
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67

arch/i386/kernel/built-in.o(.init.text+0x389d): In function `set_nmi_ipi_callback':
/usr/local/autobench/var/tmp/build/arch/i386/kernel/traps.c:727: undefined reference to `usb_early_handoff'
arch/i386/kernel/built-in.o(.init.text+0x4ee0): In function `smp_read_mpc':
/usr/local/autobench/var/tmp/build/include/asm-i386/mach-summit/mach_mpparse.h:35: undefined reference to `usb_early_handoff'


Plus it panics on boot on Power-4 LPAR

Memory: 30962716k/31457280k available (4308k kernel code, 494564k reserved, 1112k data, 253k bss, 420k init)
Mount-cache hash table entries: 256
softlockup thread 0 started up.
Processor 1 found.
softlockup thread 1 started up.
Processor 2 found.
softlockup thread 2 started up.
Processor 3 found.
Brought up 4 CPUs
softlockup thread 3 started up.
NET: Registered protocol family 16
PCI: Probing PCI hardware
IOMMU table initialized, virtual merging disabled
PCI_DMA: iommu_table_setparms: /pci@3fffde0a000/pci@2,2 has missing tce entries !
Kernel panic - not syncing: iommu_init_table: Can't allocate 1729382256943765922 bytes

 <7>RTAS: event: 3, Type: Internal Device Failure, Severity: 5
ibm,os-term call failed -1

