Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271565AbTGQV4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271567AbTGQV4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:56:40 -0400
Received: from mcmmta2.mediacapital.pt ([193.126.240.147]:36503 "EHLO
	mcmmta2.mediacapital.pt") by vger.kernel.org with ESMTP
	id S271565AbTGQV4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:56:31 -0400
Date: Thu, 17 Jul 2003 23:08:38 +0100
From: "Paulo Andre'" <fscked@netvisao.pt>
Subject: Re: [ACPI] fujitsu-siemens e-6624 kernel oops 2.6.0testing1 acpi
In-reply-to: <001201c34c6f$0e0ab750$5001690a@fbi>
To: Bencsath Boldizsar <boldi@dc.hu>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       andrew.grover@intel.com, Pawel Jochym <jochym@rozeta.com.pl>,
       Nuno Monteiro <nuno@paradigma.co.pt>
Message-id: <20030717230838.581321d8.fscked@netvisao.pt>
Organization: Transatlantic Inc.
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <001201c34c6f$0e0ab750$5001690a@fbi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing exactly the same problem and this is by far my biggest
concern with 2.5/2.6 these days. I subscribe everything Bencsath
Boldizsar said and I can add a bit more detail pertaining to this
problem.

Namely, I've started to notice this less than desirable behaviour under
2.5.70 and later kernels (up to 2.6.0-test1[-ac2,-mm1]. In particular,
the problem seems to have been introduced with patch
acpi-20030523-2.5.69. My call trace is just like the one quoted below so
I'll refrain from pasting mine(though I will quote it below for
reference). Moreover, booting with acpi=off prevents the oops from being
triggered whereas pci=noacpi doesn't.

Other than that, let me point out that I'm also having this trouble in a
Fujitsu E series, though it is a E-7110 running Slackware 9.0.

By the way, Bencsath, could you please give 2.5.69 a spin and see if
ACPI works for you? Thanks in advance.

		Paulo


On Thu, 17 Jul 2003 16:23:54 +0200
Bencsath Boldizsar wrote:

> Hi,
>  I have only bad experience with both acpi and apm on my Fujitsu
>  Siemens E-6624
> notebook(933Mhz PIII-M,512M SD133 ram, some nasty stuff like
> "security" keys on the front of the notebook). ACPI did not work with
> the 2.4 series and nowtime I tried it again on the 2.5 series. It is
> still not working with the latest 2.6.0testing1 too. (In 2.4 series,
> with ACPI enabled the kernel hanged if I pressed any special keys
> (fn+brightness etc.), now it drops OOPS at kernel start. 
>  
>  I would be pretty happy to solve the issue.
>  Details:
>  Kernel: Simple 2.6.0testing1. Debian unstable - kernel from source.
>  
>  Dump of the serial console:
>  Linux version 2.6.0-test1 (root@fbi) (gcc version 3.3.1 20030626
>  (Debian prerelease)) #2
> SMP Tue Jul 15 16:00:47 CEST 2003
>  Video mode to be used for restore is ffff
>  BIOS-provided physical RAM map:
>   BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
>   BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
>   BIOS-e820: 00000000000e6400 - 0000000000100000 (reserved)
>   BIOS-e820: 0000000000100000 - 000000001fee0000 (usable)
>   BIOS-e820: 000000001fee0000 - 000000001feefc00 (ACPI data)
>   BIOS-e820: 000000001feefc00 - 000000001fef0000 (ACPI NVS)
>   BIOS-e820: 000000001fef0000 - 000000001ff00000 (reserved)
>   BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
>   BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
>   BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
>  511MB LOWMEM available.
>  On node 0 totalpages: 130944
>    DMA zone: 4096 pages, LIFO batch:1
>    Normal zone: 126848 pages, LIFO batch:16
>    HighMem zone: 0 pages, LIFO batch:1
>  ACPI: RSDP (v000 FUJ                        ) @ 0x000f62c0
>  ACPI: RSDT (v001 FUJ    RICKWOOD 00265.00000) @ 0x1feeba1f
>  ACPI: FADT (v001 FUJ    RICKWOOD 00265.00000) @ 0x1feefb8c
>  ACPI: DSDT (v001 FUJ    RICKWOOD 00265.00000) @ 0x00000000
>  ACPI: BIOS passes blacklist
>  ACPI: MADT not present
>  Building zonelist for node : 0
>  Kernel command line: BOOT_IMAGE=l260p1 ro root=305
>  console=ttyS0,38400n8 console=tty0 Local APIC disabled by BIOS --
>  reenabling. Found and enabled local APIC!
>  Initializing CPU#0
>  PID hash table entries: 2048 (order 11: 16384 bytes)
>  Detected 930.413 MHz processor.
>  Console: colour VGA+ 80x25
>  Calibrating delay loop... 1839.10 BogoMIPS
>  Memory: 510088k/523776k available (4302k kernel code, 12808k
>  reserved, 1594k data, 244k
> init, 0k highmem)
>  Security Scaffold v1.0.0 initialized
>  Capability LSM initialized
>  Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>  Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>  Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>  -> /dev
>  -> /dev/console
>  -> /root
>  CPU: L1 I cache: 16K, L1 D cache: 16K
>  CPU: L2 cache: 512K
>  Intel machine check architecture supported.
>  Intel machine check reporting enabled on CPU#0.
>  Enabling fast FPU save and restore... done.
>  Enabling unmasked SIMD FPU exception support... done.
>  Checking 'hlt' instruction... OK.
>  POSIX conformance testing by UNIFIX
>  CPU0: Intel(R) Pentium(R) III Mobile CPU       933MHz stepping 01
>  per-CPU timeslice cutoff: 1462.52 usecs.
>  task migration cache decay timeout: 2 msecs.
>  SMP motherboard not detected.
>  enabled ExtINT on CPU#0
>  ESR value before enabling vector: 00000000
>  ESR value after enabling vector: 00000000
>  Using local APIC timer interrupts.
>  calibrating APIC timer ...
>  ..... CPU clock speed is 235.0889 MHz.
>  ..... host bus clock speed is 132.0844 MHz.
>  Starting migration thread for cpu 0
>  CPUS done 32
>  Initializing RT netlink socket
>  PCI: PCI BIOS revision 2.10 entry at 0xfd97e, last bus=4
>  PCI: Using configuration type 1
>  mtrr: v2.0 (20020519)
>  BIO: pool of 256 setup, 15Kb (60 bytes/bio)
>  biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
>  biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
>  biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
>  biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
>  biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
>  biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
>  ACPI: Subsystem revision 20030619
>  ACPI: Interpreter enabled
>  ACPI: Using PIC for interrupt routing
>  ACPI: PCI Root Bridge [PCI0] (00:00)
>  PCI: Probing PCI hardware (bus 00)
>  Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
>  Unable to handle kernel NULL pointer dereference at virtual address
>  00000007
>   printing eip:
>  c02a622c
>  *pde = 00000000
>  Oops: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<c02a622c>]    Not tainted
>  EFLAGS: 00010246
>  EIP is at acpi_ns_map_handle_to_node+0x1a/0x22
>  eax: 00000000   ebx: c167ef40   ecx: dfeddde4   edx: 00000007
>  esi: 00000000   edi: dfeddde4   ebp: dfedddb8   esp: dfedddb8
>  ds: 007b   es: 007b   ss: 0068
>  Process swapper (pid: 1, threadinfo=dfedc000 task=dfedf8c0)
>  Stack: dfedddd0 c02a5c3f 00000007 c167ef40 00000000 c167ef50 dfeddef8
>  c02b0ac0 
>         00000007 dfeddde4 dfeddde4 00000100 dfedddec 00000000 00000000
>         00000000 00000000 00000000 00000000 00000000 00000000 00000000
>         00000000 00000000 
>  Call Trace:
>   [<c02a5c3f>] acpi_ns_handle_to_pathname+0x11/0x4a
>   [<c02b0ac0>] acpi_pci_bind_root+0xa5/0xd5
>   [<c02afd0d>] acpi_pci_root_add+0x177/0x1c9
>   [<c02b190e>] acpi_bus_driver_init+0x2d/0x8f
>   [<c02b1c5d>] acpi_bus_find_driver+0x86/0xe6
>   [<c02b212c>] acpi_bus_add+0x127/0x155
>   [<c02b2254>] acpi_bus_scan+0xfa/0x145
>   [<c06dbc38>] acpi_scan_init+0x51/0x79
>   [<c06c6a1b>] do_initcalls+0x2b/0xa0
>   [<c0137732>] init_workqueues+0x12/0x29
>   [<c01050da>] init+0x5a/0x1f0
>   [<c0105080>] init+0x0/0x1f0
>   [<c01091e9>] kernel_thread_helper+0x5/0xc
>  
>  Code: 80 3a aa 0f 44 c2 5d c3 55 89 e5 8b 45 08 5d c3 55 89 e5 ff 
>   <0>Kernel panic: Attempted to kill init!
>   
>  ===============================-------------
>  ksymoops, If it succeeded:
>  ksymoops 2.4.8 on i686 2.6.0-test1.  Options used
>       -V (default)
>       -k /proc/ksyms (default)
>       -l /proc/modules (default)
>       -o /lib/modules/2.6.0-test1/ (default)
>       -m /boot/System.map (specified)
>  
>  Error (regular_file): read_ksyms stat /proc/ksyms failed
>  No modules in ksyms, skipping objects
>  No ksyms, skipping lsmod
>  Reading Oops report from the terminal
>  Unable to handle kernel NULL pointer dereference at virtual address
>  00000007 c02a622c
>  *pde = 00000000
>  Oops: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<c02a622c>]    Not tainted
>  Using defaults from ksymoops -t elf32-i386 -a i386
>  EFLAGS: 00010246
>  eax: 00000000   ebx: c167ef40   ecx: dfeddde4   edx: 00000007
>  esi: 00000000   edi: dfeddde4   ebp: dfedddb8   esp: dfedddb8
>  ds: 007b   es: 007b   ss: 0068
>  Stack: dfedddd0 c02a5c3f 00000007 c167ef40 00000000 c167ef50 dfeddef8
>  c02b0ac0
>         00000007 dfeddde4 dfeddde4 00000100 dfedddec 00000000 00000000
>         00000000 00000000 00000000 00000000 00000000 00000000 00000000
>         00000000 00000000
>  Call Trace:
>   [<c02a5c3f>] acpi_ns_handle_to_pathname+0x11/0x4a
>   [<c02b0ac0>] acpi_pci_bind_root+0xa5/0xd5
>   [<c02afd0d>] acpi_pci_root_add+0x177/0x1c9
>   [<c02b190e>] acpi_bus_driver_init+0x2d/0x8f
>   [<c02b1c5d>] acpi_bus_find_driver+0x86/0xe6
>   [<c02b212c>] acpi_bus_add+0x127/0x155
>   [<c02b2254>] acpi_bus_scan+0xfa/0x145
>   [<c06dbc38>] acpi_scan_init+0x51/0x79
>   [<c06c6a1b>] do_initcalls+0x2b/0xa0
>   [<c0137732>] init_workqueues+0x12/0x29
>   [<c01050da>] init+0x5a/0x1f0
>   [<c0105080>] init+0x0/0x1f0
>   [<c01091e9>] kernel_thread_helper+0x5/0xc
>  Code: 80 3a aa 0f 44 c2 5d c3 55 89 e5 8b 45 08 5d c3 55 89 e5 ff
>  
>  
>  >>EIP; c02a622c <acpi_ns_map_handle_to_node+1a/22>   <=====
>  
>  >>ebx; c167ef40 <_end+f1a1f8/3f8992b8>
>  >>ecx; dfeddde4 <_end+1f77909c/3f8992b8>
>  >>edi; dfeddde4 <_end+1f77909c/3f8992b8>
>  >>ebp; dfedddb8 <_end+1f779070/3f8992b8>
>  >>esp; dfedddb8 <_end+1f779070/3f8992b8>
>  
>  Trace; c02a5c3f <acpi_ns_handle_to_pathname+11/4a>
>  Trace; c02b0ac0 <acpi_pci_bind_root+a5/d5>
>  Trace; c02afd0d <acpi_pci_root_add+177/1c9>
>  Trace; c02b190e <acpi_bus_driver_init+2d/8f>
>  Trace; c02b1c5d <acpi_bus_find_driver+86/e6>
>  Trace; c02b212c <acpi_bus_add+127/155>
>  Trace; c02b2254 <acpi_bus_scan+fa/145>
>  Trace; c06dbc38 <pte_chain_init+58/60>
>  Trace; c06c6a1b <_edata+71b/1d00>
>  Trace; c0137732 <init_workqueues+12/29>
>  Trace; c01050da <init+5a/1f0>
>  Trace; c0105080 <init+0/1f0>
>  Trace; c01091e9 <kernel_thread_helper+5/c>
>  
>  Code;  c02a622c <acpi_ns_map_handle_to_node+1a/22>
>  00000000 <_EIP>:
>  Code;  c02a622c <acpi_ns_map_handle_to_node+1a/22>   <=====
>     0:   80 3a aa                  cmpb   $0xaa,(%edx)   <=====
>  Code;  c02a622f <acpi_ns_map_handle_to_node+1d/22>
>     3:   0f 44 c2                  cmove  %edx,%eax
>  Code;  c02a6232 <acpi_ns_map_handle_to_node+20/22>
>     6:   5d                        pop    %ebp
>  Code;  c02a6233 <acpi_ns_map_handle_to_node+21/22>
>     7:   c3                        ret    
>  Code;  c02a6234 <acpi_ns_convert_entry_to_handle+0/8>
>     8:   55                        push   %ebp
>  Code;  c02a6235 <acpi_ns_convert_entry_to_handle+1/8>
>     9:   89 e5                     mov    %esp,%ebp
>  Code;  c02a6237 <acpi_ns_convert_entry_to_handle+3/8>
>     b:   8b 45 08                  mov    0x8(%ebp),%eax
>  Code;  c02a623a <acpi_ns_convert_entry_to_handle+6/8>
>     e:   5d                        pop    %ebp
>  Code;  c02a623b <acpi_ns_convert_entry_to_handle+7/8>
>     f:   c3                        ret    
>  Code;  c02a623c <acpi_ns_terminate+0/31>
>    10:   55                        push   %ebp
>  Code;  c02a623d <acpi_ns_terminate+1/31>
>    11:   89 e5                     mov    %esp,%ebp
>  Code;  c02a623f <acpi_ns_terminate+3/31>
>    13:   ff 00                     incl   (%eax)
>  
>   <0>Kernel panic: Attempted to kill init!
>  
>  1 error issued.  Results may not be reliable.
>  
>  
>  (FYI: apm -s or -S 1. does nothing 2. does not suspend 3. does
>  suspend but it cannot
> resume)
>  (FYI2: with acpi=off kernel says everything is on the same IRQ
>  (shared), and recommends
> pci=umasqpirq)
>  
>  
>  any answers are welcome, I can send more detail or check anything as
>  you wish. CC: to me
> please,
>  boldizsar
> 


		Paulo
