Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbSLFDgP>; Thu, 5 Dec 2002 22:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267533AbSLFDgP>; Thu, 5 Dec 2002 22:36:15 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41481 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267528AbSLFDgN>; Thu, 5 Dec 2002 22:36:13 -0500
Date: Thu, 5 Dec 2002 22:42:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG]2.4.19-ck7
Message-ID: <Pine.LNX.3.96.1021205224111.20736A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This machine has been running this kernel since it was fairly new, just
started doing this on a regular basis.


ksymoops 2.4.1 on i686 2.4.19-ck7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-ck7/ (default)
     -m /boot/System.map-2.4.19-ck7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ips.o) for ips
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (pclose_local): find_objects pclose failed 0x100
Warning (compare_maps): ksyms_base symbol __wake_up_sync_R__ver___wake_up_sync not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol set_cpus_allowed_R__ver_set_cpus_allowed not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol cards_found  , pcnet32 says f89859e0, /lib/modules/2.4.19-ck7/kernel/drivers/net/pcnet32.o says f89856e0.  Ignoring /lib/modules/2.4.19-ck7/kernel/drivers/net/pcnet32.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says f893eed8, /lib/modules/2.4.19-ck7/kernel/drivers/usb/usbcore.o says f893ed38.  Ignoring /lib/modules/2.4.19-ck7/kernel/drivers/usb/usbcore.o entry
Warning (compare_maps): mismatch on symbol ahc_list_spinlock  , aic7xxx says f8822cc4, /lib/modules/2.4.19-ck7/kernel/drivers/scsi/aic7xxx/aic7xxx.o says f8820524.  Ignoring /lib/modules/2.4.19-ck7/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_detect_complete  , aic7xxx says f8822cc0, /lib/modules/2.4.19-ck7/kernel/drivers/scsi/aic7xxx/aic7xxx.o says f8820520.  Ignoring /lib/modules/2.4.19-ck7/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_periodic_otag  , aic7xxx says f8822cd4, /lib/modules/2.4.19-ck7/kernel/drivers/scsi/aic7xxx/aic7xxx.o says f8820534.  Ignoring /lib/modules/2.4.19-ck7/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_verbose  , aic7xxx says f8822ccc, /lib/modules/2.4.19-ck7/kernel/drivers/scsi/aic7xxx/aic7xxx.o says f882052c.  Ignoring /lib/modules/2.4.19-ck7/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Dec  5 10:52:20 newscon07 kernel: kernel BUG at skbuff.c:174!
Dec  5 10:52:20 newscon07 kernel: invalid operand: 0000
Dec  5 10:52:20 newscon07 kernel: CPU:    1
Dec  5 10:52:20 newscon07 kernel: EIP:    0010:[alloc_skb+78/448]    Not tainted
Dec  5 10:52:20 newscon07 kernel: EIP:    0010:[<c01fce0e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  5 10:52:20 newscon07 kernel: EFLAGS: 00010286
Dec  5 10:52:20 newscon07 kernel: eax: 0000003a   ebx: 00000003   ecx: f5578000   edx: 000009c0
Dec  5 10:52:20 newscon07 kernel: esi: 00000000   edi: 000001f0   ebp: f5579e20   esp: f5579e0c
Dec  5 10:52:20 newscon07 kernel: ds: 0018   es: 0018   ss: 0018
Dec  5 10:52:20 newscon07 kernel: Process earthquake (pid: 1010, stackpage=f5579000)
Dec  5 10:52:20 newscon07 kernel: Stack: c028a2e0 c021d024 cd28f97c 00000000 f55ae160 f5579ec0 c021d024 00000678 
Dec  5 10:52:20 newscon07 kernel:        000001f0 00000000 f5579e6c e4cd3128 f4a6d000 e4cd3128 f5579e84 c0213b4d 
Dec  5 10:52:20 newscon07 kernel:        00000002 00000001 e4cd3128 00000000 f5579e8c c827a8d0 f5578000 581386a8 
Dec  5 10:52:20 newscon07 kernel: Call Trace:    [tcp_sendmsg+692/5072] [tcp_sendmsg+692/5072] [ip_local_deliver+397/416] [ip_rcv_finish+459/529] [nf_hook_slow+244/464]
Dec  5 10:52:20 newscon07 kernel: Call Trace:    [<c021d024>] [<c021d024>] [<c0213b4d>] [<c021422b>] [<c020a004>]
Dec  5 10:52:20 newscon07 kernel:   [<c020a03a>] [<c023e065>] [<c01f90fc>] [<c0214060>] [<c01f92f5>] [<c014b11f>]
Dec  5 10:52:20 newscon07 kernel:   [<c010b371>] [<c01094db>]
Dec  5 10:52:20 newscon07 kernel: Code: 0f 0b ae 00 8b 0a 29 c0 58 5a 83 e7 ef b8 00 e0 ff ff 21 e0 

>>EIP; c01fce0e <alloc_skb+4e/1c0>   <=====
Trace; c021d024 <tcp_sendmsg+2b4/13d0>
Trace; c021d024 <tcp_sendmsg+2b4/13d0>
Trace; c0213b4d <ip_local_deliver+18d/1a0>
Trace; c021422b <ip_rcv_finish+1cb/211>
Trace; c020a004 <nf_hook_slow+f4/1d0>
Trace; c020a03a <nf_hook_slow+12a/1d0>
Trace; c023e065 <inet_sendmsg+35/40>
Trace; c01f90fc <sock_sendmsg+6c/90>
Trace; c0214060 <ip_rcv_finish+0/211>
Trace; c01f92f5 <sock_write+95/a0>
Trace; c014b11f <sys_write+9f/1e0>
Trace; c010b371 <do_IRQ+1f1/200>
Trace; c01094db <system_call+33/38>
Code;  c01fce0e <alloc_skb+4e/1c0>
00000000 <_EIP>:
Code;  c01fce0e <alloc_skb+4e/1c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01fce10 <alloc_skb+50/1c0>
   2:   ae                        scas   %es:(%edi),%al
Code;  c01fce11 <alloc_skb+51/1c0>
   3:   00 8b 0a 29 c0 58         add    %cl,0x58c0290a(%ebx)
Code;  c01fce17 <alloc_skb+57/1c0>
   9:   5a                        pop    %edx
Code;  c01fce18 <alloc_skb+58/1c0>
   a:   83 e7 ef                  and    $0xffffffef,%edi
Code;  c01fce1b <alloc_skb+5b/1c0>
   d:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c01fce20 <alloc_skb+60/1c0>
  12:   21 e0                     and    %esp,%eax


10 warnings and 3 errors issued.  Results may not be reliable.

