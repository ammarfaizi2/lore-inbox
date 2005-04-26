Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVDZAtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVDZAtl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVDZAtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:49:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:5252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261225AbVDZAtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:49:17 -0400
Date: Mon, 25 Apr 2005 17:49:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, eike-kernel@sf-tec.de
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050425174900.688f18fa.rddunlap@osdl.org>
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005 01:25:32 -0700
Andrew Morton <akpm@osdl.org> wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/


I'm seeing some badness and a panic, goes away if I disable
PCI Express.


gargoyle login: Linux version 2.6.12-rc2-mm3 (rddunlap@gargoyle) (gcc version 3.3.3 (SuSE Linux)) #12 Mon Apr 25 16:25:48 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=lin2612rc2mm3EX root=309 elevator=cfq splash=silent desktop showopts console=ttyS0,115200n8 console=tty0 crashkernel=64M@16M debug
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1685.942 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x30
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 962204k/1048512k available (2603k kernel code, 85708k reserved, 1325k data, 224k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3325.95 BogoMIPS (lpj=1662976)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febfbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After all inits, caps: 3febfbf7 00000000 00000000 00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
softlockup thread 0 started up.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb110, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
fscache: general fs caching registered
CacheFS: general fs caching v0.1 registered
highmem bounce pool size: 64 pages
inotify device minor=63
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
fakephp: Fake PCI Hot Plug Controller Driver
Badness in kref_get at lib/kref.c:32
 [<c1003368>] dump_stack+0x16/0x18
 [<c10f7b32>] kref_get+0x28/0x32
 [<c10f7173>] kobject_get+0x14/0x1c
 [<c114b216>] get_bus+0x1a/0x2c
 [<c114b0e1>] bus_add_driver+0x12/0x93
 [<c13e67f7>] pcied_init+0x31/0x9d
 [<c13da714>] do_initcalls+0x4e/0xa0
 [<c10002a7>] init+0x25/0xce
 [<c1000b09>] kernel_thread_helper+0x5/0xb
Badness in kref_get at lib/kref.c:32
 [<c1003368>] dump_stack+0x16/0x18
 [<c10f7b32>] kref_get+0x28/0x32
 [<c10f7173>] kobject_get+0x14/0x1c
 [<c10f6d52>] kobject_init+0x2c/0x3f
 [<c10f7024>] kobject_register+0x17/0x4f
 [<c114b118>] bus_add_driver+0x49/0x93
 [<c13e67f7>] pcied_init+0x31/0x9d
 [<c13da714>] do_initcalls+0x4e/0xa0
 [<c10002a7>] init+0x25/0xce
 [<c1000b09>] kernel_thread_helper+0x5/0xb
lib/kobject.c:171: spin_is_locked on uninitialized spinlock c133e1b8.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c10f6f6f
*pde = 00000000
Oops: 0002 [#1]
DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c10f6f6f>]    Not tainted VLI
EFLAGS: 00010292   (2.6.12-rc2-mm3) 
EIP is at kobject_add+0xed/0x18b
eax: c133df00   ebx: c133dee4   ecx: 00000000   edx: c133e1b0
esi: ffffffea   edi: c133e1d0   ebp: c6341f90   esp: c6341f84
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c6340000 task=c631cac0)
Stack: c133dee4 ffffffea c133dee4 c6341fa8 c10f702a c133dee4 c133dee4 c133deb8 
       c133e120 c6341fc4 c114b118 c133dee4 00000000 00000000 00000000 00000000 
       c6341fd4 c13e67f7 c133deb8 c1408814 c6341fe4 c13da714 c1000282 00000000 
Call Trace:
 [<c100334a>] show_stack+0x7a/0x82
 [<c1003453>] show_registers+0xe9/0x153
 [<c100369f>] die+0x15c/0x23d
 [<c100e962>] do_page_fault+0x431/0x5a8
 [<c1002ed3>] error_code+0x4f/0x54
 [<c10f702a>] kobject_register+0x1d/0x4f
 [<c114b118>] bus_add_driver+0x49/0x93
 [<c13e67f7>] pcied_init+0x31/0x9d
 [<c13da714>] do_initcalls+0x4e/0xa0
 [<c10002a7>] init+0x25/0xce
 [<c1000b09>] kernel_thread_helper+0x5/0xb
Code: 28 c7 40 24 ab 00 00 00 75 0f 8b 43 28 83 c0 28 50 e8 05 02 00 00 89 c7 58 8b 53 28 8d 43 1c 83 c2 08 89 53 1c 8b 4a 04 89 42 04 <89> 01 89 48 04 8b 43 28 81 78 10 3c 4b 24 1d 74 1b 83 c0 10 50 
 <0>Kernel panic - not syncing: Attempted to kill init!
 


-- 
~Randy
