Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUKFTEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUKFTEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUKFTEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:04:22 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:41515 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261440AbUKFTEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:04:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=OUCIFGgAieaWSMJ/QuhGoGVyOxY5OppAYPLDEKHklQQNNHQO7i8Ib/+MKoNYOBo7gvGcfmarvhkvymrGD0E00P+/TIHpFANYq94oD6H0nwlsAjlAZYeWWUnH7zR3eGVSqUWrc2I2GZ3t1W/5iCD6XX6fOLqd+3J0YqWoa/sWo9Y=
Message-ID: <9dda349204110611043e093bca@mail.gmail.com>
Date: Sat, 6 Nov 2004 14:04:03 -0500
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm3
Cc: LKML <linux-kernel@vger.kernel.org>, Diffie <diffie@blazebox.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, 

mm3 oopses right at the startup, below is the captured output from
serial console.

vga=normal          
Loading Slackware................................
BIOS data check successful                          
Linux version 2.6.10-rc1-mm3 (root@blaze) (gcc version 3.3.4) #2 Sat
Nov 6 13:18
:16 EST 2004            
BIOS-provided physical RAM map:                               
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.                        
896MB LOWMEM available.                       
found SMP MP-table at 000f5240                              
DMI 2.3 present.                
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16                                 
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists                 
Initializing CPU#0                  
Kernel command line: BOOT_IMAGE=Slackware ro root=801 video=ve
am:128 console=ttyS0,57600n8 console=tty0 rootflags=quota
CPU 0 irqstacks, hard=c043f000 soft=c043e000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2204.992 MHz processor.                                
Using tsc for high-res timesource                                 
Console: colour VGA+ 80x25                          
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035224k/1048512k available (2295k kernel code, 12668k
reserved, 813k da
ta, 184k init, 131008k highmem)                               
Checking if this processor honours the WP bit even in supervisor
mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)                                   
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 3200+ stepping 00                                        
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.                                 
ENABLING IO-AP             
..TIMER: vector=0x31 pin1=2 pin2=-1                                   
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
checking if image is initramfs...it isn't (bad gzip magic numbers);
looks like a
n initrd        
Freeing initrd memory: 56k freed                                
NET: Registered protocol family 16                                  
PCI: PCI BIOS revision 2.10 entry at 0xfabc0, last bus=3
PCI: Using configuration type 1                               
mtrr: v2.0 (2           
ACPI: Subsystem revision 20041015                                 
ACPI: Interpreter enabled                         
ACPI: Using IOAPIC for interrupt routing                                        
ACPI: PCI Root Bridge [PCI0] (00:00)                                    
PCI: Probing PCI hardware (bus 00)                                  
PCI: nForce2 C1 Halt Disconnect fixup                                     
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
SCSI subsystem initialized                          
PCI: Using ACPI for IRQ routing                               
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.                           
Machine check exception polling timer started.
highmem bounce pool size: 64 pages                                  
Total HugeTLB memory allocated, 0                                 
VFS: Disk quotas dquot_6.5.1                            
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem                                  
Initializing Cryptographic API                              
vesafb: probe of vesafb0 failed                             
ACPI: Power Button (FF) [PWRF]                              
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:              
c027ff3a        
*pde = 00000000               
Oops: 0000 [#1]               
PREEMPT       
Modules linked in:                  
CPU:    0         
EIP:    0060:[<c027ff3a>]    Not tainted VLI
EFLAGS: 00010296   (2.6.10-rc1-mm3)                                   
EIP is at class_hotplug_name+0xa/0x10                                     
eax: 00000000   ebx: c03cf640   ecx: c18df660   edx: c027ff30
esi: c03cf628   edi: c1be91e0   ebp: c1be9160   esp: c18fee74
ds: 007b   es: 007b   ss: 0068                              
Process swapper (pid: 1, threadinfo=c18fe000
Stack: c0224190 c03cf640 c1be9174 c1be9174 000041ed 00000002 c1be9174
c1b46400
       c0352c88 c0195f2b 00000000 c1919cac c1be9178 00000000 c1be9174 c03cf640  
       c1be9174 c191aba8 00000000 c191ab94 c0223890 c1be9174 00000001 c1be9174
Call Trace:
 [<c0224190>] kobject_hotplug+0x290/0x2c0
 [<c0195f2b>] sysfs_create_dir+0x3b/0x80
 [<c0223890>] kobject_add+0xd0/0xf0
 [<c028022b>] class_device_add+0x7b/0x140
 [<c028019d>] class_device_initialize+0x1d/0x30
 [<c028088f>] class_simple_device_add+0x9f/0x110
 [<c0263792>] tty_register_device+0x72/0xe0
 [<c028108f>] kobj_map+0x4f/0x150
 [<c0164636>] cdev_add+0x46/0x50
 [<c0263a9f>] tty_register_driver+0x13f/0x230
 [<c0421b53>] legacy_pty_init+0x293/0x2d0
 [<c0421e55>] pty_init+0x5/0x10
 [<c040b87c>] do_initcalls+0x2c/0xc0
 [<c042707d>] sock_init+0x3d/0x80
 [<c0100450>] init+0x0/0x110
 [<c010047f>] init+0x2f/0x110
 [<c01042
Code: c0 75 03 8b 42 2c 3d 1c f6 3c c0 74 03 31 c0 c3 8b 42 34 85 c0 74 f6 b8 01
 00 00 00 c3 8d 74 26 00 8b 44 24 08 83 e8 08 8b 40 3c <8b> 00 c3 8d 76 00 83 ec
 3c 89 7c 24 34 89 6c 24 38 89 5c 24 2c
 <0>Kernel panic - not syncing: Attempted to kill init!

Thanks, 

Paul B.
-- 
FreeBSD the Power to Serve!
