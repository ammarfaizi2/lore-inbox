Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTJCDHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 23:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTJCDHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 23:07:54 -0400
Received: from fmr04.intel.com ([143.183.121.6]:64692 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263623AbTJCDHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 23:07:50 -0400
Subject: Re: Broken ACPI in kernels > 2.5.69, blows up upon boot
From: Len Brown <len.brown@intel.com>
To: Paulo Andre <fscked@netvisao.pt>
Cc: acpi-support@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20031002214729.11c85558.fscked@netvisao.pt>
References: <20031002214729.11c85558.fscked@netvisao.pt>
Content-Type: text/plain
Organization: 
Message-Id: <1065150392.5327.106.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Oct 2003 23:06:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo,

This looks different from other failures I've seen in bugzilla.  Is it
possible for you to try the latest kernel (2.4 or 2.6 will do -- they
have the same ACPI code) and drop the info below into bugzilla?

thanks,
-Len
---

Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from dmesg -s40000 or the serial console log

Please attach the output from dmidecode, available in /usr/sbin/, or
here: http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here: 
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz

Please attach the output from lspci -vv







On Thu, 2003-10-02 at 16:47, Paulo Andre wrote:
> Hi Len, list..
> 
> I've been experiencing a most unfortunate problem using ACPI since
> kernel 2.5.70. I simply cannot boot a kernel with ACPI support, it
> oopses right upon boot when initializing ACPI and that's it. I've
> emailed about this a few months ago, when it was still Andy Grover
> maintaining ACPI and we got to no conclusive answer. I have a hard time
> believing my BIOS is fscked as far as ACPI is concerned considering it
> worked flawlessly in 2.5.69 (the kernel I'm still using..) and before.
> 
> Anyway, this is a Fujitsu Siemens E-7110 laptop and this breaks in every
> kernel starting from 2.5.70 up until 2.6.0-test6 with the latest acpi
> batch applied.
> 
> Here's the output from the serial console:
> 
> >> cut here
> 
>  ACPI: RSDP (v000 FUJ                        ) @ 0x000f62c0
>   ACPI: RSDT (v001 FUJ    RICKWOOD 00265.00000) @ 0x1feeba1f
>   ACPI: FADT (v001 FUJ    RICKWOOD 00265.00000) @ 0x1feefb8c
>   ACPI: DSDT (v001 FUJ    RICKWOOD 00265.00000) @ 0x00000000
>   ACPI: BIOS passes blacklist
>   ACPI: MADT not present
>   Building zonelist for node : 0
>   Kernel command line: BOOT_IMAGE=l260p1 ro root=305
>   console=ttyS0,38400n8 console=tty0 Local APIC disabled by BIOS --
>   reenabling. Found and enabled local APIC!
>   Initializing CPU#0
>   PID hash table entries: 2048 (order 11: 16384 bytes)
>   Detected 930.413 MHz processor.
>   Console: colour VGA+ 80x25
>   Calibrating delay loop... 1839.10 BogoMIPS
>   Memory: 510088k/523776k available (4302k kernel code, 12808k
>   reserved, 1594k data, 244k
>  init, 0k highmem)
>   Security Scaffold v1.0.0 initialized
>   Capability LSM initialized
>   Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>   Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>   Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>   - /dev
>   - /dev/console
>   - /root
>   CPU: L1 I cache: 16K, L1 D cache: 16K
>   CPU: L2 cache: 512K
>   Intel machine check architecture supported.
>   Intel machine check reporting enabled on CPU#0.
>   Enabling fast FPU save and restore... done.
>   Enabling unmasked SIMD FPU exception support... done.
>   Checking 'hlt' instruction... OK.
>   POSIX conformance testing by UNIFIX
>   CPU0: Intel(R) Pentium(R) III Mobile CPU       933MHz stepping 01
>   per-CPU timeslice cutoff: 1462.52 usecs.
>   task migration cache decay timeout: 2 msecs.
>   SMP motherboard not detected.
>   enabled ExtINT on CPU#0
>   ESR value before enabling vector: 00000000
>   ESR value after enabling vector: 00000000
>   Using local APIC timer interrupts.
>   calibrating APIC timer ...
>   ..... CPU clock speed is 235.0889 MHz.
>   ..... host bus clock speed is 132.0844 MHz.
>   Starting migration thread for cpu 0
>   CPUS done 32
>   Initializing RT netlink socket
>   PCI: PCI BIOS revision 2.10 entry at 0xfd97e, last bus=4
>   PCI: Using configuration type 1
>   mtrr: v2.0 (20020519)
>   BIO: pool of 256 setup, 15Kb (60 bytes/bio)
>   biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
>   biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
>   biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
>   biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
>   biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
>   biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
>   ACPI: Subsystem revision 20030619
>   ACPI: Interpreter enabled
>   ACPI: Using PIC for interrupt routing
>   ACPI: PCI Root Bridge [PCI0] (00:00)
>   PCI: Probing PCI hardware (bus 00)
>   Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
>   Unable to handle kernel NULL pointer dereference at virtual address
>   00000007
>    printing eip:
>   c02a622c
>   *pde = 00000000
>   Oops: 0000 [#1]
>   CPU:    0
>   EIP:    0060:[<c02a622c]    Not tainted
>   EFLAGS: 00010246
>   EIP is at acpi_ns_map_handle_to_node+0x1a/0x22
>   eax: 00000000   ebx: c167ef40   ecx: dfeddde4   edx: 00000007
>   esi: 00000000   edi: dfeddde4   ebp: dfedddb8   esp: dfedddb8
>   ds: 007b   es: 007b   ss: 0068
>   Process swapper (pid: 1, threadinfo=dfedc000 task=dfedf8c0)
>   Stack: dfedddd0 c02a5c3f 00000007 c167ef40 00000000 c167ef50 dfeddef8
>   c02b0ac0 
>          00000007 dfeddde4 dfeddde4 00000100 dfedddec 00000000 00000000
>          00000000 00000000 00000000 00000000 00000000 00000000 00000000
>          00000000 00000000 
>   Call Trace:
>    [<c02a5c3f] acpi_ns_handle_to_pathname+0x11/0x4a
>    [<c02b0ac0] acpi_pci_bind_root+0xa5/0xd5
>    [<c02afd0d] acpi_pci_root_add+0x177/0x1c9
>    [<c02b190e] acpi_bus_driver_init+0x2d/0x8f
>    [<c02b1c5d] acpi_bus_find_driver+0x86/0xe6
>    [<c02b212c] acpi_bus_add+0x127/0x155
>    [<c02b2254] acpi_bus_scan+0xfa/0x145
>    [<c06dbc38] acpi_scan_init+0x51/0x79
>    [<c06c6a1b] do_initcalls+0x2b/0xa0
>    [<c0137732] init_workqueues+0x12/0x29
>    [<c01050da] init+0x5a/0x1f0
>    [<c0105080] init+0x0/0x1f0
>    [<c01091e9] kernel_thread_helper+0x5/0xc
>   
>   Code: 80 3a aa 0f 44 c2 5d c3 55 89 e5 8b 45 08 5d c3 55 89 e5 ff 
>    <0Kernel panic: Attempted to kill init!
> 
> << cut here
> 
> I've tried to look into the code but newbie as I am, no conclusion was
> reached. Is there any idea what may have provoked this sudden break up?
> 
> Feel free to ask me for more details if need be.
> 
> Thanks in advance,
> 
> 		Paulo

