Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbSJAQvR>; Tue, 1 Oct 2002 12:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262195AbSJAQuW>; Tue, 1 Oct 2002 12:50:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20957 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262173AbSJAQtU>;
	Tue, 1 Oct 2002 12:49:20 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200210011654.g91GsaU29508@eng2.beaverton.ibm.com>
Subject: USB OOPS in 2.5.40 ?
To: gregkh@us.ibm.com (Greg Kroah-Hartman)
Date: Tue, 1 Oct 2002 09:54:36 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get following Debug Stack while rebooting the machine. (8x P-III).
Is this USB related ? It is not causing me any trouble, just an
FYI.

Thanks,
Badari


Please stand by while rebooting the system...
Shutting down devices
hcd-pci.c: remove: 00:0f.2, state 3
usb.c: USB disconnect on device 1
Debug: sleeping function called from illegal context at /usr/src/linux-2.5.40/include/asm/semaphore.h:119
f73abdf4 c0119df6 c03ca360 c03c36e0 00000077 bffffcc8 c0182f5d c03c36e0 
       00000077 c3ddc850 c044f0a0 00000286 c0258283 c3ddc8f4 c0406b88 c3ddc850 
       f7a20784 f7a20784 c020dd06 c3ddc850 c044f0a0 000000cc 00000000 f79e6000 
Call Trace:
 [<c0119df6>]__might_sleep+0x56/0x5d
 [<c0182f5d>]driverfs_remove_file+0x1d/0x80
 [<c0258283>]device_remove_file+0x23/0x40
 [<c020dd06>]pci_pool_destroy+0x156/0x200
 [<c0307dbe>]hcd_buffer_destroy+0x2e/0x40
 [<c03089ba>]usb_hcd_pci_remove+0x6a/0x150
 [<c020e8c9>]pci_device_remove+0x19/0x30
 [<c0256af5>]device_shutdown+0xc5/0x180
 [<c012b36b>]sys_reboot+0x12b/0x370
 [<c013cc12>]free_block+0x1a2/0x2d0
 [<c013d4ad>]kmem_cache_free+0x14d/0x160
 [<c013d4ad>]kmem_cache_free+0x14d/0x160
 [<c035b734>]sock_destroy_inode+0x14/0x90
 [<c0169062>]destroy_inode+0x32/0x50
 [<c016681c>]dput+0x1c/0x240
 [<c014ffa0>]__fput+0x130/0x150
 [<c035befe>]sock_ioctl+0x7e/0xf0
 [<c014de4f>]filp_close+0x10f/0x120
 [<c014dee6>]sys_close+0x86/0xc0
 [<c01078af>]syscall_call+0x7/0xb

hcd.c: USB bus 1 deregistered
Restarting system.



