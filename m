Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbULBJLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbULBJLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 04:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbULBJLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 04:11:07 -0500
Received: from netblock-66-245-225-118.dslextreme.com ([66.245.225.118]:6283
	"EHLO mail.knowplace.org") by vger.kernel.org with ESMTP
	id S261509AbULBJKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 04:10:45 -0500
From: Shane Chen <shane@electricmonks.org>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/slab.c:1442!
Date: Thu, 2 Dec 2004 01:11:35 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412020111.35749.shane@electricmonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------[ cut here ]------------
kernel BUG at mm/slab.c:1442!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: uhci_hcd st sr_mod
CPU:    1
EIP:    0060:[<c0146bfa>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-gentoo-r6)
EIP is at kmem_cache_create+0x41a/0x5e0
eax: 00000031   ebx: f7cd7f58   ecx: c042874c   edx: 00000282
esi: c032e9dd   edi: f885d443   ebp: f74287e0   esp: c23acf44
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4641, threadinfo=c23ac000 task=f7fee6b0)
Stack: c031c110 f885d435 00000004 00000000 c23acf68 f7428820 00000058 
c0000000
       fffffffc 00000018 00000000 fffffff4 c23ac000 c03596c4 f88370ab 
f885d435
       0000002c 00000004 00000000 00000000 00000000 c03596e0 f885f140 
c01387b2
Call Trace:
 [<f88370ab>] uhci_hcd_init+0xab/0x141 [uhci_hcd]
 [<c01387b2>] sys_init_module+0x192/0x240
 [<c010530b>] syscall_call+0x7/0xb
Code: e9 d6 01 00 00 c7 04 24 10 c1 31 c0 8b 4c 24 3c 89 4c 24 04 e8 d8 92 
fd ff b9 4c 87 42 c0 f0 ff 05 4c 87 42 c0 0f8e b7 1a 00 00 <0f> 0b a2 05 a0 
ba 31 c0 8b 0b e9 61 ff ff ff 8d b4 26 00 00 00
 kobject_register failed for hiddev (-17)
 [<c01c89ab>] kobject_register+0x5b/0x60
 [<c0236430>] bus_add_driver+0x50/0xc0
 [<c0275d0e>] usb_register+0x3e/0xa0
 [<f883907b>] hiddev_init+0x1b/0x1d [usbhid]
 [<f883900c>] hid_init+0xc/0x60 [usbhid]
 [<c01387b2>] sys_init_module+0x192/0x240
 [<c010530b>] syscall_call+0x7/0xb
usbcore: error -17 registering driver hiddev

--
Some additional info in case it matters:
Asus CUVX4-D MB w/ dual P3 1GHz & 2GB RAM
hda: Maxtor 52732U6, ATA DISK drive
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 8)
  Vendor: PIONEER   Model: DVD-ROM DVD-303F  Rev: 2.00
  Type:   CD-ROM                             ANSI SCSI revision: 02

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev c4)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP]
0000:00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
South] (rev 40)
0000:00:04.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 16)
0000:00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 16)
0000:00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
ACPI] (rev 40)
0000:00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
0000:00:0b.0 Ethernet controller: Linksys NC100 Network Everywhere Fast 
Ethernet 10/100 (rev 11)
0000:00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 
(rev 06)
0000:00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 06)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4600] (rev a3)

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1004.977
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1990.65

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1004.977
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 2007.04

# gcc -v
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/specs
Configured with: /var/tmp/portage/gcc-3.3.4-r1/work/gcc-3.3.4/configure 
--prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.3 
--includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/include 
--datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3 
--mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/man 
--infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/info --enable-shared 
--host=i686-pc-linux-gnu --target=i686-pc-linux-gnu --with-system-zlib 
--enable-languages=c,c++,f77 --enable-threads=posix --enable-long-long 
--disable-checking --disable-libunwind-exceptions --enable-cstdio=stdio 
--enable-version-specific-runtime-libs 
--with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/include/g++-v3 
--with-local-prefix=/usr/local --enable-shared --enable-nls 
--without-included-gettext --disable-multilib --enable-__cxa_atexit 
--enable-clocale=generic
Thread model: posix
gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)

# ld -V
GNU ld version 2.15.90.0.1.1 20040303
  Supported emulations:
   elf_i386
   i386linux
   elf_i386_glibc21

dmesg also reported later:
irq 19: nobody cared!
 [<c0107cfa>] __report_bad_irq+0x2a/0x90
 [<c0107df0>] note_interrupt+0x70/0xb0
 [<c0108122>] do_IRQ+0x182/0x1b0
 [<c0105c78>] common_interrupt+0x18/0x20
 [<c028958b>] uhci_irq+0x2b/0x1f0
 [<f947f751>] nv_kern_isr+0x106/0x146 [nvidia]
 [<c027bd36>] usb_hcd_irq+0x36/0x70
 [<c0107c94>] handle_IRQ_event+0x34/0x70
 [<c010807d>] do_IRQ+0xdd/0x1b0
 =======================
 [<c0105c78>] common_interrupt+0x18/0x20
 [<c0103030>] default_idle+0x0/0x40
 [<c010305c>] default_idle+0x2c/0x40
 [<c01030f2>] cpu_idle+0x42/0x60
 [<c03e093f>] start_kernel+0x16f/0x190
 [<c03e03a0>] unknown_bootoption+0x0/0x180
handlers:
[<f8d025e0>] (ahc_linux_isr+0x0/0x2a0 [aic7xxx])
Disabling IRQ #19

Please let me know if there's any additional info that might be helpful.

Thanks,
Shane
(not subscribed to the list, so please cc: me)
