Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284153AbRLTLTS>; Thu, 20 Dec 2001 06:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284178AbRLTLTJ>; Thu, 20 Dec 2001 06:19:09 -0500
Received: from [200.248.92.2] ([200.248.92.2]:47775 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S284153AbRLTLTD>; Thu, 20 Dec 2001 06:19:03 -0500
Message-Id: <200112201110.JAA11126@inter.lojasrenner.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.14-pre6 and 2.4.14-pre9aa1
Date: Thu, 20 Dec 2001 09:16:47 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011218195509.U2272-100000@gerard> <1008804413.926.5.camel@PC2> <3C21C21F.92F834AB@idb.hist.no>
In-Reply-To: <3C21C21F.92F834AB@idb.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a Application server  in a DELL POWEREDGE 8450 with 4xP-III 700 
Mhz, 4GB Memory. After 40 days running kernel 2.4.14-pre6 my system reports 
the following error in /var/adm/messages:

Dec 13 13:52:42 front01 kernel: invalid operand: 0000
Dec 13 13:52:42 front01 kernel: CPU:    3
Dec 13 13:52:42 front01 kernel: EIP:    0010:[<c012e764>]    Not tainted
Dec 13 13:52:42 front01 kernel: EFLAGS: 00010282
Dec 13 13:52:42 front01 kernel: eax: 00000880   ebx: c855e280   ecx: c855e280 
  edx: 00000000
Dec 13 13:52:42 front01 kernel: esi: fe000ff4   edi: 00000000   ebp: 00000ff1 
  esp: ce439eb0
Dec 13 13:52:42 front01 kernel: ds: 0018   es: 0018   ss: 0018
Dec 13 13:52:42 front01 kernel: Process ps.bin (pid: 29154, 
stackpage=ce439000)
Dec 13 13:52:42 front01 kernel: Stack: c855e280 fe000ff4 e58f3003 00000ff1 
f40252a3 c01f4bd8 c021bb70 c01504aa
Dec 13 13:52:42 front01 kernel:        c855e280 c012eebc c011daf8 00000003 
00000003 bffffff1 eef09920 c011dbb6
Dec 13 13:52:42 front01 kernel:        ca07b400 eef09920 bffffff1 e58f3000 
00000003 00000000 ca07b400 ca07b41c
Dec 13 13:52:42 front01 kernel: Call Trace: [<c01504aa>] [<c012eebc>] 
[<c011daf8>] [<c011dbb6>] [<c011dc3a>]
Dec 13 13:52:42 front01 kernel:    [<c014f66a>] [<c014f8db>] [<c01343d7>] 
[<c0106f73>]
Dec 13 13:52:42 front01 kernel:
Dec 13 13:52:42 front01 kernel: Code: 0f 0b ba 00 e0 ff ff 80 63 18 eb 21 e2 
f6 42 05 20 0f 85 55

I change ther kernel to 2.4.15-pre9aa1 and today the same error occurs, one 
week later, with this message:
Dec 20 01:21:58 front01 kernel: invalid operand: 0000
Dec 20 01:21:58 front01 kernel: CPU:    3
Dec 20 01:21:58 front01 kernel: EIP:    0010:[<c013153b>]    Not tainted
Dec 20 01:21:58 front01 kernel: EFLAGS: 00010202
Dec 20 01:21:58 front01 kernel: eax: 00000840   ebx: c5ba3ec0   ecx: c5ba3ec0 
  edx: 00000000
Dec 20 01:21:58 front01 kernel: esi: fe000f81   edi: 00000000   ebp: 00000f7b 
  esp: c2cebeb0
Dec 20 01:21:58 front01 kernel: ds: 0018   es: 0018   ss: 0018
Dec 20 01:21:58 front01 kernel: Process ps.bin (pid: 19556, 
stackpage=c2ceb000)
Dec 20 01:21:58 front01 kernel: Stack: c5ba3ec0 fe000f81 cd7b1006 00000f7b 
c0238fb0 c0154d8a d51db340 d51db340
Dec 20 01:21:58 front01 kernel:        c5ba3ec0 c0131d98 c011ffb8 00000006 
00000006 bfffff7b c8b8e740 c0120076
Dec 20 01:21:58 front01 kernel:        c294b820 c8b8e740 bfffff7b cd7b1000 
00000006 00000000 c294b83c c294b820
Dec 20 01:21:58 front01 kernel: Call Trace: [<c0154d8a>] [<c0131d98>] 
[<c011ffb8>] [<c0120076>] [<c0120119>]
Dec 20 01:21:58 front01 kernel:    [<c0153f3a>] [<c01541ab>] [<c0138117>] 
[<c0106f73>]
Dec 20 01:21:58 front01 kernel:
Dec 20 01:21:58 front01 kernel: Code: 0f 0b 8b 43 18 a8 80 74 02 0f 0b b9 00 
e0 ff ff 80 63 18 eb

ksymoops:

ksymoops 2.4.1 on i686 2.4.15-pre9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre9/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/reiserfs.o) for reiserfs
Error (expand_objects): cannot stat(/lib/sym53c8xx.o) for sym53c8xx
Error (expand_objects): cannot stat(/lib/qla2x00.o) for qla2x00
Error (expand_objects): cannot stat(/lib/megaraid.o) for megaraid
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/net/ipv4/netfilter/netfilter.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/net/ipv6/netfilter/netfilter.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/net/fc/fc.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/net/wan/wan.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/net/appletalk/appletalk.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/net/tokenring/tr.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/net/pcmcia/pcmcia_net.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/net/wireless/wireless_net.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/misc/misc.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/cdrom/driver.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/media/radio/radio.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/media/video/video.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/media/media.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/sound/sounddrivers.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/parport/driver.o
Warning (read_object): no symbols in 
/lib/modules/2.4.15-pre9/build/drivers/hotplug/vmlinux-obj.o
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says 
c01a3160, System.map says c0158b20.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol vg  , lvm-mod says c89d8b20, 
/lib/modules/2.4.15-pre9/kernel/drivers/md/lvm-mod.o says c89d8780.  Ignoring 
/lib/modules/2.4.15-pre9/kernel/drivers/md/lvm-mod.o entry
Warning (map_ksym_to_module): cannot match loaded module reiserfs to a unique 
module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module sym53c8xx to a 
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module qla2x00 to a unique 
module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module megaraid to a unique 
mole object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module scsi_mod to a unique 
module object.  Trace may not be reliable.
Dec 20 01:21:58 front01 kernel: invalid operand: 0000
Dec 20 01:21:58 front01 kernel: CPU:    3
Dec 20 01:21:58 front01 kernel: EIP:    0010:[<c013153b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 20 01:21:58 front01 kernel: EFLAGS: 00010202
Dec 20 01:21:58 front01 kernel: eax: 00000840   ebx: c5ba3ec0   ecx: c5ba3ec0 
edx: 00000000
Dec 20 01:21:58 front01 kernel: esi: fe000f81   edi: 00000000   ebp: 00000f7b 
esp: c2cebeb0
Dec 20 01:21:58 front01 kernel: ds: 0018   es: 0018   ss: 0018
Dec 20 01:21:58 front01 kernel: Process ps.bin (pid: 19556, 
stackpage=c2ceb000)
Dec 20 01:21:58 front01 kernel: Stack: c5ba3ec0 fe000f81 cd7b1006 00000f7b 
c0238fb0 c0154d8a d51db340 d51db340 
Dec 20 01:21:58 front01 kernel:        c5ba3ec0 c0131d98 c011ffb8 00000006 
00000006 bfffff7b c8b8e740 c0120076 
Dec 20 01:21:58 front01 kernel:        c294b820 c8b8e740 bfffff7b cd7b1000 
00000006 00000000 c294b83c c294b820 
Dec 20 01:21:58 front01 kernel: Call Trace: [<c0154d8a>] [<c0131d98>] 
[<c011ffb8>] [<c0120076>] [<c0120119>]

Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c013153b <__free_pages_ok+4b/238>   <=====
Trace; c0154d8a <proc_base_lookup+22a/23c>
Trace; c0131d98 <__free_pages+1c/20>
Trace; c011ffb8 <access_one_page+244/2a0>
Trace; c0120076 <access_mm+62/7c>
Trace; c0120119 <access_process_vm+89/c4>
Trace; c0153f3a <proc_pid_cmdline+62/e8>
Trace; c01541ab <proc_info_read+53/110>
Trace; c0138117 <sys_read+8f/c4>
Trace; c0106f73 <system_call+33/38>


26 warnings and 6 errors issued.  Results may not be reliable.


In all oops the system stay up, but if you run a ps command this process 
freeze.

It's possible to reboot the machine using reboot -f


Any help?



Thank's in advance




Andre Margis
