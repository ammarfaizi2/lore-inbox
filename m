Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277367AbRJJTZ4>; Wed, 10 Oct 2001 15:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277372AbRJJTZr>; Wed, 10 Oct 2001 15:25:47 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:8169 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277367AbRJJTZf>; Wed, 10 Oct 2001 15:25:35 -0400
Date: Wed, 10 Oct 2001 21:25:11 +0200 (CEST)
From: eduard.epi@t-online.de (Peter Bornemann)
To: <linux-kernel@vger.kernel.org>
Subject: Invalid operand with 2.4.11
Message-ID: <Pine.LNX.4.33.0110102109460.1363-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am using a SuSE 7.2 distro. When I'm starting their yast2, it crashes
reliably and leaves this message in the log (run through ksymoops):

ksymoops 2.4.1 on i686 2.4.11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.11/ (default)
     -m /boot/System.map-2.4.11 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): snd symbol pm_register not found in
/lib/modules/2.4.11/misc/snd.o.  Ignoring /lib/modules/2.4.11/misc/snd.o
entry
Warning (compare_maps): snd symbol pm_send not found in
/lib/modules/2.4.11/misc/snd.o.  Ignoring /lib/modules/2.4.11/misc/snd.o
entry
Warning (compare_maps): snd symbol pm_unregister not found in
/lib/modules/2.4.11/misc/snd.o.  Ignoring /lib/modules/2.4.11/misc/snd.o
entry
Warning (compare_maps): mismatch on symbol icmpv6_socket  , ipv6 says
e0a17080, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a14d60.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol icmpv6_statistics  , ipv6 says
e0a16f80, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a14c60.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_dev_count  , ipv6 says
e0a16ae0, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a147c0.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_ifa_count  , ipv6 says
e0a16ae4, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a147c4.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_protos  , ipv6 says
e0a16f00, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a14be0.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inetsw6  , ipv6 says e0a16a80,
/lib/modules/2.4.11/kernel/net/ipv6/ipv6.o
says e0a14760.  Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ip6_ra_chain  , ipv6 says
e0a16d80, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a14a60.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ipv6_statistics  , ipv6 says
e0a16c80, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a14960.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol raw_v6_htable  , ipv6 says
e0a16e80, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a14b60.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol rt6_stats  , ipv6 says
e0a16c48, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a14928.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol udp_stats_in6  , ipv6 says
e0a16e00, /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o says e0a14ae0.
Ignoring /lib/modules/2.4.11/kernel/net/ipv6/ipv6.o entry
Oct 10 20:54:39 eduard kernel: invalid operand: 0000
Oct 10 20:54:39 eduard kernel: CPU:    0
Oct 10 20:54:39 eduard kernel: EIP:    0010:[kmem_cache_free+82/464]
Not tainted
Oct 10 20:54:39 eduard kernel: EFLAGS: 00010286
Oct 10 20:54:39 eduard kernel: eax: 0000001d   ebx: 00558280   ecx:
d5f5e000   edx: d707a304
Oct 10 20:54:39 eduard kernel: esi: d560a003   edi: d568871c   ebp:
c18062e0   esp: d5f5ff10
Oct 10 20:54:39 eduard kernel: ds: 0018   es: 0018   ss: 0018
Oct 10 20:54:39 eduard kernel: Process y2bignfat (pid: 902,
stackpage=d5f5f000)
Oct 10 20:54:39 eduard kernel: Stack: c0221262 d560a003 d5f5ff94 ffffffd8
d568871c d5f5ff8c d5609084 d5688790
Oct 10 20:54:39 eduard kernel:        d5f5ff94 ffffffd8 c013a4f4 c18062e0
d560a003 d5f5ff94 d568871c 000001a4
Oct 10 20:54:39 eduard kernel:        def33000 00000241 bfffd2f8 d5f5ff94
00000001 00000002 d5688790 c013062b
Oct 10 20:54:39 eduard kernel: Call Trace: [open_namei+1300/1328]
[filp_open+59/96] [sys_open+54/160] [system_call+51/56]
Oct 10 20:54:39 eduard kernel: Code: 0f 0b 83 c4 08 a1 2c 5c 2a c0 3b 2c
18 74 02 0f 0b 9c 8f 44
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   a1 2c 5c 2a c0            mov    0xc02a5c2c,%eax
Code;  0000000a Before first symbol
   a:   3b 2c 18                  cmp    (%eax,%ebx,1),%ebp
Code;  0000000d Before first symbol
   d:   74 02                     je     11 <_EIP+0x11> 00000011 Before
first symbol
Code;  0000000f Before first symbol
   f:   0f 0b                     ud2a
Code;  00000011 Before first symbol
  11:   9c                        pushf
Code;  00000012 Before first symbol
  12:   8f 44 00 00               popl   0x0(%eax,%eax,1)

15 warnings issued.  Results may not be reliable.


This did not happen with any kernel before ( 2.2.19 and 2.4.4-10 + some
pre ). gcc is:
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.3/specs
gcc version 2.95.3 20010315 (SuSE)

It was compiled for an Athlon/Duron/K7.

The process y2bignfat is started as a subroutine by yast2. It is an normal
ELF-executable.


Peter B


