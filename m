Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUCJRKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUCJRKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:10:36 -0500
Received: from mail19f.dulles19-verio.com ([198.170.241.24]:27737 "HELO
	mail19f.dulles19-verio.com") by vger.kernel.org with SMTP
	id S262731AbUCJRKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:10:00 -0500
Message-ID: <013501c406c2$757f5e00$6a00a8c0@reddy>
From: "Sasidhar Mukkmalla" <msreddy@guardiansolutions.com>
To: <linux-kernel@vger.kernel.org>
References: <006301c40619$1cbaa6c0$6a00a8c0@reddy> <200403100952.42522.vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Kernel Oops and crashes Updated
Date: Wed, 10 Mar 2004 12:09:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Being new to this group I am not completely aware of posting policies here.
Should have read posting procedures. Excuse me for my stupid post last time.

System Hardware
Intel 2.4GHz processor on ATX MBD 845E chipset.
These machines have 512MB ram and two hard drives of 200GB.
All are raided at level 1.

KERNEL: 2.4.20-6

Here is the output from lsmod

[root@QA_Demo guard]# /sbin/lsmod
Module                  Size  Used by    Tainted: GF
tuner                  11808   0  (autoclean) (unused)
bttv                   74176   4  (autoclean)
soundcore               6404   0  (autoclean) [bttv]
i2c-algo-bit            8872   4  (autoclean) [bttv]
i2c-core               19172   0  (autoclean) [tuner bttv i2c-algo-bit]
videodev                8288  12  (autoclean) [bttv]
softdog                 2972   1
parport_pc             19076   1  (autoclean)
lp                      8996   0  (autoclean)
parport                37056   1  (autoclean) [parport_pc lp]
rocket                 34148   0
autofs                 13268   0  (autoclean) (unused)
e100                   60644   1
sg                     36524   0  (autoclean)
sr_mod                 18136   0  (autoclean)
microcode               4668   0  (autoclean)
ide-scsi               12208   0
scsi_mod              107160   3  [sg sr_mod ide-scsi]
ide-cd                 35708   0
cdrom                  33728   0  [sr_mod ide-cd]
keybdev                 2944   0  (unused)
mousedev                5492   0  (unused)
hid                    22148   0  (unused)
input                   5856   0  [keybdev mousedev hid]
usb-uhci               26348   0  (unused)
ehci-hcd               19976   0  (unused)
usbcore                78784   1  [hid usb-uhci ehci-hcd]
ext3                   70784   3
jbd                    51892   3  [ext3]
raid1                  14956   4


Output from lspci
[root@QA_Demo guard]# /sbin/lspci
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
(rev 11)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 11)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev
01)
02:01.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 11)
02:04.0 Communication controller: Comtrol Corporation RocketPort 32 Intf
(rev 01)
02:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0d)
02:0c.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01)
03:00.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
03:00.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
03:01.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
03:01.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
03:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
03:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
03:03.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
03:03.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)



Kerenel OOPS ran through ksymoops.


[root@DVRS8-3 ksymoops-2.4.2]# ./ksymoops
ksymoops 2.4.2 on i686 2.4.20-6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-6/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
./ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
./ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/raid1.o) for raid1
./ksymoops: No such file or directory
Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
./ksymoops: No such file or directory
Warning (compare_maps): usbcore symbol
GPLONLY_usb_find_interface_driver_for_ifnum not found in
/lib/modules/2.4.20-6/kernel/drivers/usb/usbcore.o.  Ignoring
/lib/modules/2.4.20-6/kernel/drivers/usb/usbcore.o entry
Warning (compare_maps): usbcore symbol GPLONLY_usb_ifnum_to_ifpos not found
in /lib/modules/2.4.20-6/kernel/drivers/usb/usbcore.o.  Ignoring
/lib/modules/2.4.20-6/kernel/drivers/usb/usbcore.o entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique
module object.  Trace may not be reliable.
Reading Oops report from the terminal
Feb 28 09:30:00 DVRS8-3 kernel: Unable to handle kernel paging request at
virtual address 615b585d
Feb 28 09:30:00 DVRS8-3 kernel:  printing eip:
Feb 28 09:30:00 DVRS8-3 kernel: c0139c30
Feb 28 09:30:00 DVRS8-3 kernel: *pde = 00000000
Feb 28 09:30:00 DVRS8-3 kernel: Oops: 0000
Feb 28 09:30:00 DVRS8-3 kernel: softdog parport_pc lp parport rocket
iptable_filter ip_tables autofs bttv soundcore i
2c-algo-bit i2c-core videodev e100 sg sr_mod microcode ide-scsi scsi_mod
Feb 28 09:30:00 DVRS8-3 kernel: CPU:    0
Feb 28 09:30:00 DVRS8-3 kernel: EIP:    0060:[<c0139c30>]    Tainted: GF
Feb 28 09:30:00 DVRS8-3 kernel: EFLAGS: 00010887
Feb 28 09:30:00 DVRS8-3 kernel:
Feb 28 09:30:00 DVRS8-3 kernel: EIP is at kmem_cache_reap [kernel] 0x150
(2.4.20-6)
Feb 28 09:30:00 DVRS8-3 kernel: eax: 615b585d   ebx: 00000081   ecx:
c25a7f58   edx: c25a7f68
Feb 28 09:30:00 DVRS8-3 kernel: esi: 00000009   edi: 000001d2   ebp:
00000000   esp: c0cf3e2c
Feb 28 09:30:00 DVRS8-3 kernel: ds: 0068   es: 0068   ss: 0068
Feb 28 09:30:00 DVRS8-3 kernel: Process mrtg (pid: 4702, stackpage=c0cf3000)
Feb 28 09:30:00 DVRS8-3 kernel: Stack: c039fdd8 0000000b c25a7f58 00000000
00000000 00000000 00001f0d 000001d2
Feb 28 09:30:00 DVRS8-3 kernel:        000001d2 00000000 c013cc6e c25a51d8
000001d2 c0cf2000 00000001 c013d311
Feb 28 09:30:00 DVRS8-3 kernel:        000001d2 c030d6ac 0000061e c013e9dc
c030d6a0 00000000 00000001 00000001
Feb 28 09:30:00 DVRS8-3 kernel: Call Trace:   [<c013cc6e>]
do_try_to_free_pages [kernel] 0x5e (0xc0cf3e54))
Feb 28 09:30:00 DVRS8-3 kernel: [<c013d311>] try_to_free_pages [kernel] 0x51
(0xc0cf3e68))
Feb 28 09:30:00 DVRS8-3 kernel: [<c013e9dc>] __alloc_pages [kernel] 0x17c
(0xc0cf3e78))
Feb 28 09:30:00 DVRS8-3 kernel: [<c01303c8>] do_anonymous_page [kernel] 0x78
(0xc0cf3eb4))
Feb 28 09:30:00 DVRS8-3 kernel: [<c01308e1>] handle_mm_fault [kernel] 0x81
(0xc0cf3ed8))
Feb 28 09:30:00 DVRS8-3 kernel: [<c011737c>] do_page_fault [kernel] 0x18c
(0xc0cf3f08))
Feb 28 09:30:00 DVRS8-3 kernel: [<c0134530>] file_read_actor [kernel] 0x0
(0xc0cf3f38))
Feb 28 09:30:00 DVRS8-3 kernel: [<c013247b>] do_brk [kernel] 0x12b
(0xc0cf3f4c))
Feb 28 09:30:00 DVRS8-3 kernel: [<c0131328>] sys_brk [kernel] 0x108
(0xc0cf3f98))
Feb 28 09:30:00 DVRS8-3 kernel: [<c01171f0>] do_page_fault [kernel] 0x0
(0xc0cf3fb0))
Feb 28 09:30:00 DVRS8-3 kernel: [<c0109628>] error_code [kernel] 0x34
(0xc0cf3fb8))
Feb 28 09:30:00 DVRS8-3 kernel:
Feb 28 09:30:00 DVRS8-3 kernel:
Feb 28 09:30:00 DVRS8-3 kernel: Code: 8b 00 43 39 d0 75 f9 8b 44 24 08 89 da
8b 78 24 8b 40 44 89
Feb 28 09:30:00 DVRS8-3 kernel: Unable to handle kernel paging request at
virtual address 615b585d
Feb 28 09:30:00 DVRS8-3 kernel: c0139c30
Feb 28 09:30:00 DVRS8-3 kernel: *pde = 00000000
Feb 28 09:30:00 DVRS8-3 kernel: Oops: 0000
Feb 28 09:30:00 DVRS8-3 kernel: CPU:    0
Feb 28 09:30:00 DVRS8-3 kernel: EIP:    0060:[<c0139c30>]    Tainted: GF
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 28 09:30:00 DVRS8-3 kernel: EFLAGS: 00010887
Feb 28 09:30:00 DVRS8-3 kernel: eax: 615b585d   ebx: 00000081   ecx:
c25a7f58   edx: c25a7f68
Feb 28 09:30:00 DVRS8-3 kernel: esi: 00000009   edi: 000001d2   ebp:
00000000   esp: c0cf3e2c
Feb 28 09:30:00 DVRS8-3 kernel: ds: 0068   es: 0068   ss: 0068
Feb 28 09:30:00 DVRS8-3 kernel: Process mrtg (pid: 4702, stackpage=c0cf3000)
Feb 28 09:30:00 DVRS8-3 kernel: Stack: c039fdd8 0000000b c25a7f58 00000000
00000000 00000000 00001f0d 000001d2
Feb 28 09:30:00 DVRS8-3 kernel:        000001d2 00000000 c013cc6e c25a51d8
000001d2 c0cf2000 00000001 c013d311
Feb 28 09:30:00 DVRS8-3 kernel:        000001d2 c030d6ac 0000061e c013e9dc
c030d6a0 00000000 00000001 00000001
Feb 28 09:30:00 DVRS8-3 kernel: Call Trace:   [<c013cc6e>]
do_try_to_free_pages [kernel] 0x5e (0xc0cf3e54))
Feb 28 09:30:00 DVRS8-3 kernel: [<c013d311>] try_to_free_pages [kernel] 0x51
(0xc0cf3e68))
Feb 28 09:30:00 DVRS8-3 kernel: [<c013e9dc>] __alloc_pages [kernel] 0x17c
(0xc0cf3e78))
Feb 28 09:30:00 DVRS8-3 kernel: [<c01303c8>] do_anonymous_page [kernel] 0x78
(0xc0cf3eb4))
Feb 28 09:30:00 DVRS8-3 kernel: [<c01308e1>] handle_mm_fault [kernel] 0x81
(0xc0cf3ed8))
Feb 28 09:30:00 DVRS8-3 kernel: [<c011737c>] do_page_fault [kernel] 0x18c
(0xc0cf3f08))
Feb 28 09:30:00 DVRS8-3 kernel: [<c0134530>] file_read_actor [kernel] 0x0
(0xc0cf3f38))
Feb 28 09:30:00 DVRS8-3 kernel: [<c013247b>] do_brk [kernel] 0x12b
(0xc0cf3f4c))
Feb 28 09:30:00 DVRS8-3 kernel: [<c0131328>] sys_brk [kernel] 0x108
(0xc0cf3f98))
Feb 28 09:30:00 DVRS8-3 kernel: [<c01171f0>] do_page_fault [kernel] 0x0
(0xc0cf3fb0))
Feb 28 09:30:00 DVRS8-3 kernel: [<c0109628>] error_code [kernel] 0x34
(0xc0cf3fb8))
Feb 28 09:30:00 DVRS8-3 kernel: Code: 8b 00 43 39 d0 75 f9 8b 44 24 08 89 da
8b 78 24 8b 40 44 89

>>EIP; c0139c30 <kmem_find_general_cachep+1a0/4cc0>   <=====
Trace; c013cc6e <kmem_find_general_cachep+31de/4cc0>
Trace; c013d310 <kmem_find_general_cachep+3880/4cc0>
Trace; c013e9dc <__alloc_pages+17c/320>
Trace; c01303c8 <vmtruncate+458/b00>
Trace; c01308e0 <vmtruncate+970/b00>
Trace; c011737c <__verify_write+32c/940>
Trace; c0134530 <do_generic_file_read+750/830>
Trace; c013247a <do_brk+12a/5e0>
Trace; c0131328 <vmalloc_to_page+8b8/b40>
Trace; c01171f0 <__verify_write+1a0/940>
Trace; c0109628 <__up_wakeup+1188/1470>
Code;  c0139c30 <kmem_find_general_cachep+1a0/4cc0>
00000000 <_EIP>:
Code;  c0139c30 <kmem_find_general_cachep+1a0/4cc0>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c0139c32 <kmem_find_general_cachep+1a2/4cc0>
   2:   43                        inc    %ebx
Code;  c0139c32 <kmem_find_general_cachep+1a2/4cc0>
   3:   39 d0                     cmp    %edx,%eax
Code;  c0139c34 <kmem_find_general_cachep+1a4/4cc0>
   5:   75 f9                     jne    0 <_EIP>
Code;  c0139c36 <kmem_find_general_cachep+1a6/4cc0>
   7:   8b 44 24 08               mov    0x8(%esp,1),%eax
Code;  c0139c3a <kmem_find_general_cachep+1aa/4cc0>
   b:   89 da                     mov    %ebx,%edx
Code;  c0139c3c <kmem_find_general_cachep+1ac/4cc0>
   d:   8b 78 24                  mov    0x24(%eax),%edi
Code;  c0139c40 <kmem_find_general_cachep+1b0/4cc0>
  10:   8b 40 44                  mov    0x44(%eax),%eax
Code;  c0139c42 <kmem_find_general_cachep+1b2/4cc0>
  13:   89 00                     mov    %eax,(%eax)



[root@QA_Demo guard]# cat /etc/modules.conf
alias eth0 e100
alias usb-controller ehci-hcd
alias sound-slot-0 i810_audio
post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null
2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null
2>&1 || :
alias char-major-81 bttv
alias usb-controller1 usb-uhci
options softdog='softmargin=600'

Kernel is tainted and I am not sure what cuased it. We only loaded
rocketport and bt848 drivers apart from what comes in the kernel.

