Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSLJRlh>; Tue, 10 Dec 2002 12:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSLJRlh>; Tue, 10 Dec 2002 12:41:37 -0500
Received: from dhcp5.colorado-research.com ([65.171.192.245]:44162 "EHLO
	dhcp5.colorado-research.com") by vger.kernel.org with ESMTP
	id <S263228AbSLJRld>; Tue, 10 Dec 2002 12:41:33 -0500
Message-ID: <3DF6291C.3090100@cora.nwra.com>
Date: Tue, 10 Dec 2002 10:49:16 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops on linux 2.4.20-ac1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having a number of issues, mostly system lockups, with a 
machine of ours - a dual proc athlon.  I've removed some hardware and I 
haven't seen a hand recently.  However, we got an Oops message recently. 
 I lost that message because it wasn't written to any log (any way I can 
fix that?).  So, I upgraded the kernel to 2.4.20-ac1.  Under that I 
started getting Oops quite frequently.  Here is my first attemp at 
processing the message.  Note that I switched back to the previous 
kernel, but it's running the same module list and I tried to point 
ksymoops to the correct pieces.  I also typed the oops message in from 
what I wrote down from the screen.  Please let me know if I made a 
mistake there.

ksymoops 2.4.1 on i686 2.4.19.  Options used
     -v /usr/src/linux-2.4.20-ac1/vmlinux (specified)
     -k /var/log/ksyms.1 (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-ac1 (specified)
     -m /boot/System.map-2.4.20-ac1 (specified)

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sym53c8xx.o) for sym53c8xx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/net/ipv4/netfilter/netfilter.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/net/fc/fc.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/sound/sounddrivers.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/cdrom/driver.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/ide/raid/idedriver-raid.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/ide/ppc/idedriver-ppc.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/ide/legacy/idedriver-legacy.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/ide/arm/idedriver-arm.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/misc/misc.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/parport/driver.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/media/radio/radio.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/media/video/video.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/media/media.o
Warning (read_object): no symbols in 
/lib/modules/2.4.20-ac1/build/drivers/hotplug/vmlinux-obj.o
Warning (compare_ksyms_lsmod): module 3c59x is in lsmod but not in 
ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module autofs is in lsmod but not in 
ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module binfmt_misc is in lsmod but not in 
ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module lockd is in lsmod but not in 
ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module nfs is in lsmod but not in ksyms, 
probably no symbols exported
Warning (compare_ksyms_lsmod): module nfsd is in lsmod but not in ksyms, 
probably no symbols exported
Warning (compare_ksyms_lsmod): module sunrpc is in lsmod but not in 
ksyms, probably no symbols exported
Warning (map_ksym_to_module): cannot match loaded module ext3 to a 
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module jbd to a unique 
module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module sym53c8xx to a 
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module sd_mod to a 
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module scsi_mod to a 
unique module object.  Trace may not be reliable.
Oops: 0002
CPU: 0
EIP: 0010:[<f89641eb>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: 00000040  ebx: 00000028  ecx: 00000060  edx: f590a960
esi: f590a800  edi: f590a960  ebp: c4650ed2  esp: f4a45eb0
ds: 0018  es: 0018  ss: 0018
Stack: 0000003c 0000001f 00000000 0000b800 00000060 f590a960 f5e4d62c 
00000082
       00000001 00000082 f5dd3fd8 00000001 00000086 00000001 00000086 
f5a98000
       00000000 0000000e f4a45f08 00000000 f5a4d600 f7ff0340 00000040 
c01beaff
Call Trace: [<c01beaff>] [<c0120593>] [<f896382a>]
            [<c011f92d>] [<c0109b89>] [<c0109cf8>]
Code: b8 01 30 00 00 83 c2 0e 66 ef 8b 7c 24 14 8b 87 dc 00 00 00

 >>EIP; f89641eb <END_OF_CODE+10598c/????>   <=====
Trace; c01beaff <netif_receive_skb+ff/130>
Trace; c0120593 <send_sig_info+73/90>
Trace; f896382a <END_OF_CODE+104fcb/????>
Trace; c011f92d <do_timer+3d/70>
Trace; c0109b89 <handle_IRQ_event+39/60>
Trace; c0109cf8 <do_IRQ+68/b0>
Code;  f89641eb <END_OF_CODE+10598c/????>
00000000 <_EIP>:
Code;  f89641eb <END_OF_CODE+10598c/????>   <=====
   0:   b8 01 30 00 00            mov    $0x3001,%eax   <=====
Code;  f89641f0 <END_OF_CODE+105991/????>
   5:   83 c2 0e                  add    $0xe,%edx
Code;  f89641f3 <END_OF_CODE+105994/????>
   8:   66 ef                     out    %ax,(%dx)
Code;  f89641f5 <END_OF_CODE+105996/????>
   a:   8b 7c 24 14               mov    0x14(%esp,1),%edi
Code;  f89641f9 <END_OF_CODE+10599a/????>
   e:   8b 87 dc 00 00 00         mov    0xdc(%edi),%eax


26 warnings and 5 errors issued.  Results may not be reliable.


