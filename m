Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282934AbRLGQsL>; Fri, 7 Dec 2001 11:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282920AbRLGQru>; Fri, 7 Dec 2001 11:47:50 -0500
Received: from [12.246.164.220] ([12.246.164.220]:25136 "EHLO
	defiant.sysadminzone.com") by vger.kernel.org with ESMTP
	id <S282907AbRLGQpj>; Fri, 7 Dec 2001 11:45:39 -0500
Date: Sat, 8 Dec 2001 08:44:34 -0800 (PST)
From: David Wambolt <wambolt@sysadminzone.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem Compiling iph5526 module
Message-ID: <Pine.LNX.4.33.0112080841510.14757-100000@defiant.sysadminzone.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** I tried sending this yesterday and I never saw it come through **

Hello,

I'm a bit new to Linux kernel compiling, but I've been doing Sun Solaris
Admin work for many years.  I have a Sun Ultra 5 400mhz running SuSe Linux
7.3 for Sparc.  Everything runs great, except it does not come with a
precompiled version of the Interphase 5526 Fibre Channel module.  So I
figured I'd download the 2.4.16 kernel, enable the module and recompile
the kernel.  I've compiled kernels on x86 machines many times typically
with no problems, or at least problems I could fix.

I've:

1. Extracted the new kernel
2. make mrproper
3. make menuconfig
4. enabled the Interphase Module
5. make dep
6. make clean
7. make vmlinux
8. make modules
9. make modules_install

When doing #9, I get this error:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.16; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.16/kernel/drivers/net/fc/iph5526.o
depmod:         bus_to_virt_not_defined_use_pci_map
depmod:         virt_to_bus_not_defined_use_pci_map

Also here are the error's during #8 make modules for the iph5526 module:

iph5526.c: In function `handle_OCI_interrupt':
iph5526.c:923: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:982: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c: In function `handle_MFS_interrupt':
iph5526.c:1061: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1061: warning: assignment makes pointer from integer without a
cast
iph5526.c:1091: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1091: warning: assignment makes pointer from integer without a
cast
iph5526.c: In function `handle_Bad_SCSI_Frame_interrupt':
iph5526.c:1159: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1159: warning: assignment makes pointer from integer without a
cast
iph5526.c:1194: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1194: warning: assignment makes pointer from integer without a
cast
iph5526.c:1201: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1201: warning: assignment makes pointer from integer without a
cast
iph5526.c: In function `handle_Inbound_SCSI_Status_interrupt':
iph5526.c:1309: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1309: warning: assignment makes pointer from integer without a
cast
iph5526.c:1313: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1313: warning: assignment makes pointer from integer without a
cast
iph5526.c: In function `invalidate_SEST_entry':
iph5526.c:1367: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1367: warning: assignment makes pointer from integer without a
cast
iph5526.c:1378: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1378: warning: assignment makes pointer from integer without a
cast
iph5526.c: In function `handle_SFS_interrupt':
iph5526.c:1467: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:1467: warning: assignment makes pointer from integer without a
cast
iph5526.c: In function `abort_exchange':
iph5526.c:4136: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast
iph5526.c:4136: warning: assignment makes pointer from integer without a
cast
iph5526.c: In function `iph5526_release':
iph5526.c:4509: warning: unused variable `fi'
iph5526.c: In function `clean_up_memory':
iph5526.c:4603: warning: passing arg 1 of
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a
cast

Any help would be very much appreciated.  I'm pretty sure it's something
related to how the Sparc handles PCI - so I might be SOL.

Thanks

Dave

