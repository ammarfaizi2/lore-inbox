Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264327AbRFDQRZ>; Mon, 4 Jun 2001 12:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264325AbRFDQE6>; Mon, 4 Jun 2001 12:04:58 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:25098 "EHLO dcs.qmw.ac.uk")
	by vger.kernel.org with ESMTP id <S264324AbRFDQEj>;
	Mon, 4 Jun 2001 12:04:39 -0400
Date: Mon, 4 Jun 2001 17:04:37 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5-ac5 BUG in slab.c
Message-ID: <Pine.LNX.4.33.0106041701080.28721-100000@nick.dcs.qmw.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing with (a romfs) initrd and modularising everything, including
ext2 and ide-*. (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81))

More info on request.

ksymoops 2.4.0 on i686 2.4.5-ac5-4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac5-4/ (default)
     -m /boot/System.map-2.4.5-ac5-4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext2.o) for ext2
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/eepro100.o) for eepro100
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/ide-disk.o) for ide-disk
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/ide-probe-mod.o) for ide-probe-mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/ide-mod.o) for ide-mod
ksymoops: No such file or directory
kernel BUG at slab.c:1200!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01280d9>]
EFLAGS: 00210082
eax: 0000001b   ebx: c824e000   ecx: 00000001   edx: 00006518
esi: 00000000   edi: c144713c   ebp: cd14fa4c   esp: c6fd7ee8
ds: 0018   es: 0018   ss: 0018
Process netscape-commun (pid: 3901, stackpage=c6fd7000)
Stack: c01bfacb 000004b0 c824e019 cd14fa4c c824f019 c824e019 c01286a5 c144713c
       cd14fa4c c824e019 00000001 00200246 ce680934 ffffffeb c6fd7f84 cb5c0de4
       c013bafe c144713c c824e019 c6fd7f84 ce680934 00000001 00000002 fffffffb
Call Trace: [<c01286a5>] [<c013bafe>] [<c013e3d8>] [<c0130254>] [<c0130543>]
   [<c0106e5b>]

Code: 0f 0b 5a 59 8b 5d 14 83 fb ff 74 2b 8d 74 26 00 8d bc 27 00
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/net/ipv4/netfilter/netfilter.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/net/ipv6/netfilter/netfilter.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/md/mddev.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/net/wireless/orinoco_drvs.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/char/drm/drm.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/misc/misc.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/cdrom/driver.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/media/radio/radio.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/media/video/video.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/media/media.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/sound/sounddrivers.o
Warning (read_object): no symbols in /lib/modules/2.4.5-ac5-4/build/drivers/parport/driver.o
Warning (map_ksym_to_module): cannot match loaded module ext2 to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module eepro100 to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module ide-disk to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module ide-probe-mod to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module ide-mod to a unique module object.  Trace may not be reliable.
Reading Oops report from the terminal
kernel BUG at slab.c:1200!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01280d9>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210082
eax: 0000001b   ebx: c824e000   ecx: 00000001   edx: 00006518
esi: 00000000   edi: c144713c   ebp: cd14fa4c   esp: c6fd7ee8
ds: 0018   es: 0018   ss: 0018
Process netscape-commun (pid: 3901, stackpage=c6fd7000)
Stack: c01bfacb 000004b0 c824e019 cd14fa4c c824f019 c824e019 c01286a5 c144713c
       cd14fa4c c824e019 00000001 00200246 ce680934 ffffffeb c6fd7f84 cb5c0de4
       c013bafe c144713c c824e019 c6fd7f84 ce680934 00000001 00000002 fffffffb
Call Trace: [<c01286a5>] [<c013bafe>] [<c013e3d8>] [<c0130254>] [<c0130543>]
   [<c0106e5b>]
Code: 0f 0b 5a 59 8b 5d 14 83 fb ff 74 2b 8d 74 26 00 8d bc 27 00

>>EIP; c01280d9 <kmem_extra_free_checks+59/a0>   <=====
Trace; c01286a5 <kmem_cache_free+215/2c0>
Trace; c013bafe <open_namei+5ee/600>
Trace; c013e3d8 <vfs_readdir+58/80>
Trace; c0130254 <filp_open+34/60>
Trace; c0130543 <sys_open+33/b0>
Trace; c0106e5b <system_call+33/38>
Code;  c01280d9 <kmem_extra_free_checks+59/a0>
00000000 <_EIP>:
Code;  c01280d9 <kmem_extra_free_checks+59/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01280db <kmem_extra_free_checks+5b/a0>
   2:   5a                        pop    %edx
Code;  c01280dc <kmem_extra_free_checks+5c/a0>
   3:   59                        pop    %ecx
Code;  c01280dd <kmem_extra_free_checks+5d/a0>
   4:   8b 5d 14                  mov    0x14(%ebp),%ebx
Code;  c01280e0 <kmem_extra_free_checks+60/a0>
   7:   83 fb ff                  cmp    $0xffffffff,%ebx
Code;  c01280e3 <kmem_extra_free_checks+63/a0>
   a:   74 2b                     je     37 <_EIP+0x37> c0128110 <kmem_extra_free_checks+90/a0>
Code;  c01280e5 <kmem_extra_free_checks+65/a0>
   c:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01280e9 <kmem_extra_free_checks+69/a0>
  10:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi


18 warnings and 5 errors issued.  Results may not be reliable.

