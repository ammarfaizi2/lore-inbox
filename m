Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUI0SPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUI0SPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUI0SPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:15:00 -0400
Received: from cpc2-nmkt1-3-0-cust96.cmbg.cable.ntl.com ([62.253.137.96]:34568
	"EHLO colossus.warpdgfx.com") by vger.kernel.org with ESMTP
	id S266884AbUI0SNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:13:00 -0400
From: Adam J Watson <magius@warpdgfx.com>
To: linux-kernel@vger.kernel.org
Subject: OOPS: KDE making my kernel flake out?
Date: Mon, 27 Sep 2004 19:12:32 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409271912.32480.magius@warpdgfx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

Mysterious failing of software.

[2.] Full description of the problem/report:

This happened once before when I was messing with DRI.  So I reinstalled and 
it was still acting up.  I tweaked my BIOS memory settings and it seemed to 
fix it for a couple of weeks and then today it started up again.  This time I 
didn't get a hard crash (Kernel Panic) but I thought it might be noteworthy.

The Oops actually came from the system just after the Oops occured.  The other 
data was after I rebooted.  I think the kernel may have been 2.6.7.  If you 
could point me to what might be the problem (ie. Software, or Distro problem, 
etc.) I would greatly appreciate it.

Other pertinent Info:  Fedora Core 2 (with latest updates)
    Soyo Dragon Plus Ver 1.0
    1 GB Memory (generic OEM from BuyAib.com) PC2700
    AMD Athlon XP 2400+ Thoroughbred Core
    Saphire Radeon 9100se AGP v3 8x 256MB

[3.] Keywords (i.e., modules, networking, kernel):

kernel

[4.] Kernel version (from /proc/version):

Linux version 2.6.8-1.521 (bhcompile@tweety.build.redhat.com) (gcc version 
3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Mon Aug 16 09:01:18 EDT 2004

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

kernel/sched.c:2483: spin_is_locked on uninitialized spinlock 2fb7b548.
Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():0[expected: 0], irqs_disabled():1
 [<0211b765>] __might_sleep+0x82/0x8c
 [<0215d7dd>] rw_vm+0x20d/0x467
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<0215df26>] get_user_size+0x2e/0x55
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<021180b9>] __is_prefetch+0x1ae/0x29c
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<02118451>] do_page_fault+0x2aa/0x489
 [<0211be12>] autoremove_wake_function+0xd/0x2d
 [<0211a930>] __wake_up_common+0x36/0x5b
 [<0211a9e2>] __wake_up+0x8d/0xf2
 [<021181a7>] do_page_fault+0x0/0x489
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<02121616>] do_exit+0x15f/0x767
 [<02121ddf>] sys_exit_group+0x0/0xd
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
022f43ec
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: snd_mixer_oss appletalk ipx p8022 psnap llc 
snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec 
snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc lp 
parport autofs4 sunrpc via_rhine mii floppy sg scsi_mod dm_mod joydev 
uhci_hcd ehci_hcd button battery asus_acpi ac radeon md5 ipv6 ext3 jbd
CPU:    0
EIP:    0060:[<022f43ec>]    Not tainted
EFLAGS: 00210002   (2.6.8-1.521)
EIP is at wait_for_completion+0xdc/0x252
eax: 2fb7b560   ebx: 2fb7b544   ecx: 33dbef74   edx: 00000000
esi: 33dbef5c   edi: 33dbef7c   ebp: 33dbef94   esp: 33dbef48
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 5800, threadinfo=33dbe000 task=414d06a0)
Stack: 00000000 414d06a0 0211a8ee 00000000 00000000 14663318 146631c8 00200246
       00000001 414d06a0 0211a8ee 2fb7b560 00000000 00200246 414d06a0 2fb7b360
       2fb7b360 414d06a0 2fb7b390 00000000 02121616 33dbefc4 13b90800 00000000
Call Trace:
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<02121616>] do_exit+0x15f/0x767
 [<02121ddf>] sys_exit_group+0x0/0xd
Code: 89 0a 89 55 e4 b8 00 f0 ff ff 21 e0 8b 00 c7 00 02 00 00 00
 <3>kernel/sched.c:2483: spin_is_locked on uninitialized spinlock 2fb7b548.
kernel/sched.c:2491: spin_is_locked on uninitialized spinlock 2fb7b548.
Unable to handle kernel paging request at virtual address 001516e0
 printing eip:001516e0
*pde = 00000000
Oops: 0000 [#2]
Modules linked in: snd_mixer_oss appletalk ipx p8022 psnap llc 
snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec 
snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc lp 
parport autofs4 sunrpc via_rhine mii floppy sg scsi_mod dm_mod joydev 
uhci_hcd ehci_hcd button battery asus_acpi ac radeon md5 ipv6 ext3 jbd
CPU:    0
EIP:    0060:[<001516e0>]    Not tainted
EFLAGS: 00210206   (2.6.8-1.521)
EIP is at 0x1516e0
eax: 00000000   ebx: 2fb7b040   ecx: 00001000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: 2fb10f38
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 5801, threadinfo=2fb10000 task=30402090)
Stack: 021518a8 00000000 00000022 00000003 2fb7b070 00000022 00000000 02151102
       00000000 00000022 00000000 00000000 00000001 00000000 00000004 2fb7b040
       00001000 00000000 000001f4 00000000 00000000 2fb7b040 2fb7b070 00000022
Call Trace:
 [<021518a8>] get_unmapped_area_prot+0xaf/0xba
 [<02151102>] do_mmap_pgoff+0x106/0x61a
 [<0210cd59>] sys_mmap2+0x7d/0xb0
Code:  Bad EIP value.
 <1>Unable to handle kernel paging request at virtual address 001516e0
printing eip:001516e0
*pde = 00000000
Oops: 0000 [#3]
Modules linked in: snd_mixer_oss appletalk ipx p8022 psnap llc 
snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec 
snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc lp 
parport autofs4 sunrpc via_rhine mii floppy sg scsi_mod dm_mod joydev 
uhci_hcd ehci_hcd button battery asus_acpi ac radeon md5 ipv6 ext3 jbd
CPU:    0
EIP:    0060:[<001516e0>]    Not tainted
EFLAGS: 00210206   (2.6.8-1.521)
EIP is at 0x1516e0
eax: 00000000   ebx: 2fb7bcc0   ecx: 00001000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: 19b4bf38
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 5808, threadinfo=19b4b000 task=414d0cb0)
Stack: 021518a8 00000000 00000022 00000003 2fb7bcf0 00000022 00000000 02151102
       00000000 00000022 00000000 00000000 00000001 00000000 00000004 2fb7bcc0
       00001000 00000000 000001f4 00000000 00000000 2fb7bcc0 2fb7bcf0 00000022
Call Trace:
 [<021518a8>] get_unmapped_area_prot+0xaf/0xba
 [<02151102>] do_mmap_pgoff+0x106/0x61a
 [<0210cd59>] sys_mmap2+0x7d/0xb0
Code:  Bad EIP value.
 <3>kernel/sched.c:2483: spin_is_locked on uninitialized spinlock 2fb7bb88.
Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():0[expected: 0], irqs_disabled():1
 [<0211b765>] __might_sleep+0x82/0x8c
 [<0215d7dd>] rw_vm+0x20d/0x467
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<0215df26>] get_user_size+0x2e/0x55
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<021180b9>] __is_prefetch+0x1ae/0x29c
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<02118451>] do_page_fault+0x2aa/0x489
 [<0211be12>] autoremove_wake_function+0xd/0x2d
 [<0211a930>] __wake_up_common+0x36/0x5b
 [<0211a9e2>] __wake_up+0x8d/0xf2
 [<021181a7>] do_page_fault+0x0/0x489
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<02121616>] do_exit+0x15f/0x767
 [<02121ddf>] sys_exit_group+0x0/0xd
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
022f43ec
*pde = 00000000
Oops: 0002 [#4]
Modules linked in: snd_mixer_oss appletalk ipx p8022 psnap llc 
snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec 
snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc lp 
parport autofs4 sunrpc via_rhine mii floppy sg scsi_mod dm_mod joydev 
uhci_hcd ehci_hcd button battery asus_acpi ac radeon md5 ipv6 ext3 jbd
CPU:    0
EIP:    0060:[<022f43ec>]    Not tainted
EFLAGS: 00210002   (2.6.8-1.521)
EIP is at wait_for_completion+0xdc/0x252
eax: 2fb7bba0   ebx: 2fb7bb84   ecx: 13457f74   edx: 00000000
esi: 13457f5c   edi: 13457f7c   ebp: 13457f94   esp: 13457f48
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 5802, threadinfo=13457000 task=304026a0)
Stack: 00000000 304026a0 0211a8ee 00000000 00000000 1717d900 1717d7b0 00200246
       00000001 304026a0 0211a8ee 2fb7bba0 00000000 00200246 304026a0 2fb7b9a0
       2fb7b9a0 304026a0 2fb7b9d0 00000000 02121616 13457fc4 13b90080 00000000
Call Trace:
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<02121616>] do_exit+0x15f/0x767
 [<02121ddf>] sys_exit_group+0x0/0xd
Code: 89 0a 89 55 e4 b8 00 f0 ff ff 21 e0 8b 00 c7 00 02 00 00 00
 <3>kernel/sched.c:2483: spin_is_locked on uninitialized spinlock 2fb7bb88.
kernel/sched.c:2491: spin_is_locked on uninitialized spinlock 2fb7bb88.
kernel/sched.c:2483: spin_is_locked on uninitialized spinlock 2fb7b868.
Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():0[expected: 0], irqs_disabled():1
 [<0211b765>] __might_sleep+0x82/0x8c
 [<0215d7dd>] rw_vm+0x20d/0x467
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<0215df26>] get_user_size+0x2e/0x55
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<021180b9>] __is_prefetch+0x1ae/0x29c
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<02118451>] do_page_fault+0x2aa/0x489
 [<0211be12>] autoremove_wake_function+0xd/0x2d
 [<0211a930>] __wake_up_common+0x36/0x5b
 [<0211a9e2>] __wake_up+0x8d/0xf2
 [<021181a7>] do_page_fault+0x0/0x489
 [<022f43ec>] wait_for_completion+0xdc/0x252
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<02121616>] do_exit+0x15f/0x767
 [<02121ddf>] sys_exit_group+0x0/0xd
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
022f43ec
*pde = 00000000
Oops: 0002 [#5]
Modules linked in: snd_mixer_oss appletalk ipx p8022 psnap llc 
snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec 
snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc lp 
parport autofs4 sunrpc via_rhine mii floppy sg scsi_mod dm_mod joydev 
uhci_hcd ehci_hcd button battery asus_acpi ac radeon md5 ipv6 ext3 jbd
CPU:    0
EIP:    0060:[<022f43ec>]    Not tainted
EFLAGS: 00210002   (2.6.8-1.521)
EIP is at wait_for_completion+0xdc/0x252
eax: 2fb7b880   ebx: 2fb7b864   ecx: 0afabf74   edx: 00000000
esi: 0afabf5c   edi: 0afabf7c   ebp: 0afabf94   esp: 0afabf48
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 5806, threadinfo=0afab000 task=3428f3a0)
Stack: 00000000 3428f3a0 0211a8ee 00000000 00000000 414e5d44 19b4aba0 00200246
       00000001 3428f3a0 0211a8ee 2fb7b880 00000000 00200246 3428f3a0 2fb7b680
       2fb7b680 3428f3a0 2fb7b6b0 00000000 02121616 0afabfc4 13b90c80 00000000
Call Trace:
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<0211a8ee>] default_wake_function+0x0/0xc
 [<02121616>] do_exit+0x15f/0x767
 [<02121ddf>] sys_exit_group+0x0/0xd
Code: 89 0a 89 55 e4 b8 00 f0 ff ff 21 e0 8b 00 c7 00 02 00 00 00
 <3>kernel/sched.c:2483: spin_is_locked on uninitialized spinlock 2fb7b868.
kernel/sched.c:2491: spin_is_locked on uninitialized spinlock 2fb7b868.



[6.] A small shell script or example program which triggers the
     problem (if possible)

No shell script.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

 Linux storm.warpdgfx.com 2.6.8-1.521 #1 Mon Aug 16 09:01:18 EDT 2004 i686         
athlon i386 GNU/Linux

 Gnu C                  3.3.3
 Gnu make               3.80
 binutils               2.15.90.0.3
 util-linux             2.12
 mount                  2.12
 module-init-tools      2.4.26
 e2fsprogs              1.35
 pcmcia-cs              3.2.7
 quota-tools            3.10.
 PPP                    2.4.2
 isdn4k-utils           3.3
 nfs-utils              1.0.6
 Linux C Library        2.3.3
 Dynamic linker (ldd)   2.3.3
 Procps                 3.2.0
 Net-tools              1.60
 Kbd                    1.12
 Sh-utils               5.2.1
 Modules Loaded         appletalk ipx p8022 psnap llc snd_emu10k1 snd_rawmidi    
snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem 
snd_hwdep snd soundcore radeon parport_pc lp parport autofs4 sunrpc via_rhine 
mii floppy sg scsi_mod dm_mod joydev uhci_hcd ehci_hcd button battery 
asus_acpi ac md5 ipv6 ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 1800+
stepping        : 1
cpu MHz         : 1500.284
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2940.92

[7.3.] Module information (from /proc/modules):

appletalk 25641 2 - Live 0x42e1f000
ipx 25321 2 - Live 0x42d35000
p8022 1857 1 ipx, Live 0x42957000
psnap 3397 2 appletalk,ipx, Live 0x42d33000
llc 5205 2 p8022,psnap, Live 0x4295c000
snd_emu10k1 88521 1 - Live 0x42da4000
snd_rawmidi 21733 1 snd_emu10k1, Live 0x42d57000
snd_pcm 83529 2 snd_emu10k1, Live 0x42d72000
snd_timer 25413 1 snd_pcm, Live 0x42d3d000
snd_seq_device 6473 2 snd_emu10k1,snd_rawmidi, Live 0x42959000
snd_ac97_codec 58821 1 snd_emu10k1, Live 0x42d47000
snd_page_alloc 8393 2 snd_emu10k1,snd_pcm, Live 0x42949000
snd_util_mem 3521 1 snd_emu10k1, Live 0x42953000
snd_hwdep 6597 1 snd_emu10k1, Live 0x42950000
snd 45477 9 
snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, 
Live 0x42960000
soundcore 7713 1 snd, Live 0x4294d000
radeon 113669 2 - Live 0x42992000
parport_pc 21249 1 - Live 0x42942000
lp 9133 0 - Live 0x428c9000
parport 35977 2 parport_pc,lp, Live 0x4291c000
autofs4 20677 0 - Live 0x42915000
sunrpc 141861 1 - Live 0x4296e000
via_rhine 19273 0 - Live 0x42857000
mii 3777 1 via_rhine, Live 0x42832000
floppy 54001 0 - Live 0x4288b000
sg 28513 0 - Live 0x42904000
scsi_mod 105360 1 sg, Live 0x42927000
dm_mod 47317 0 - Live 0x4289b000
joydev 7169 0 - Live 0x42854000
uhci_hcd 28505 0 - Live 0x42866000
ehci_hcd 27973 0 - Live 0x4285e000
button 4825 0 - Live 0x4283b000
battery 7117 0 - Live 0x4282b000
asus_acpi 9177 0 - Live 0x42837000
ac 3533 0 - Live 0x4282e000
md5 3905 1 - Live 0x42830000
ipv6 217349 10 - Live 0x428cd000
ext3 96937 4 - Live 0x42872000
jbd 66521 1 ext3, Live 0x42842000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

(/proc/ioports)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d000-d01f : 0000:00:0b.0
  d000-d01f : EMU10K1
d400-d407 : 0000:00:0b.1
d800-d80f : 0000:00:0f.0
  d800-d807 : ide0
  d808-d80f : ide1
dc00-dc1f : 0000:00:10.0
  dc00-dc1f : uhci_hcd
e000-e01f : 0000:00:10.1
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:10.2
  e400-e41f : uhci_hcd
e800-e81f : 0000:00:10.3
  e800-e81f : uhci_hcd
ec00-ecff : 0000:00:12.0
  ec00-ecff : via-rhine

(/proc/iomem)
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002f6fff : Kernel code
  002f7000-00399bff : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
  d8000000-dfffffff : 0000:01:00.1
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
  e5000000-e500ffff : 0000:01:00.0
  e5010000-e501ffff : 0000:01:00.1
e6000000-e60000ff : 0000:00:10.4
  e6000000-e60000ff : ehci_hcd
e6001000-e60010ff : 0000:00:12.0
  e6001000-e60010ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host 
Bridge (rev 80)
        Subsystem: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        Expansion ROM at 0000c000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
        Subsystem: Creative Labs CT4760 SBLive!
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d000
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at d400
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
[Master SecP PriP])
        Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at e800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 
[EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 10
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at e6000000 (32-bit, non-prefetchable)
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
        Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
        Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet 
Controller on VT8235
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00
        Region 1: Memory at e6001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] 
(rev 01) (prog-if 00 [VGA])
        Subsystem: PC Partner Limited: Unknown device 7c13
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable)
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] 
(Secondary) (rev 01)
        Subsystem: PC Partner Limited: Unknown device 7c12
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled]
        Region 1: Memory at e5010000 (32-bit, non-prefetchable) [disabled] 
[size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI Devices

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

