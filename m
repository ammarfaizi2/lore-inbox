Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTIYJg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 05:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTIYJg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 05:36:28 -0400
Received: from mail.gmx.de ([213.165.64.20]:21733 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261776AbTIYJgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 05:36:25 -0400
Date: Thu, 25 Sep 2003 11:36:24 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, devik@cdi.cz
MIME-Version: 1.0
References: <16014.1064443965@www46.gmx.net>
Subject: Re: [OOPS] [2.6.0-test5] HTB QoS crash...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <27908.1064482584@www45.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Decoded through ksymoops.

---

ksymoops 2.4.9 on i686 2.6.0-test5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test5/ (default)
     -m /usr/src/linux/System.map (default)
 
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
 
Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c02d2314>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: dc246078   ecx: da60e004   edx: dc246004
esi: da60e004   edi: df4ffef8   ebp: da5ede0c   esp: da5eddf4
ds: 007b   es: 007b   ss: 0068
Stack: c1001040 00000000 c141f280 00000000 df4ffeac db3315fc da5ede20
c02da54e
       dc246004 da60e004 00000000 da5ede3c c02da7e7 df4ffef8 df4ffeac
db3315fc
       db3315a4 df4ffef8 da5ede58 c02da826 df4ffef8 db3315fc dc2463b0
db3315a4
Call Trace:
 [<c02da54e>] u32_destroy_key+0x6a/0x6c
 [<c02da7e7>] u32_clear_hnode+0x2e/0x48
 [<c02da826>] u32_destroy_hnode+0x25/0x86
 [<c02da955>] u32_destroy+0xce/0xec
 [<c02d148a>] htb_destroy_filters+0x1d/0x29
 [<c02d169d>] htb_destroy+0x67/0xd2
 [<c02c3fd4>] qdisc_destroy+0x81/0x92
 [<c02c4705>] dev_shutdown+0xaa/0x245
 [<c0138e4c>] wakeme_after_rcu+0x0/0xc
 [<c02b7d0c>] unregister_netdevice+0xdb/0x335
 [<c02bf84a>] rtnl_lock+0x22/0x37
 [<c0233ba7>] unregister_netdev+0x19/0x26
 [<c0239e26>] ppp_shutdown_interface+0x21e/0x3ba
 [<c0182376>] dput+0x23/0x685
 [<c0163e34>] __fput+0x7c/0xcd
 [<c0234011>] ppp_release+0x5f/0x61
 [<c0163e73>] __fput+0xbb/0xcd
 [<c0161f1d>] filp_close+0x57/0x81
 [<c016204b>] sys_close+0x104/0x228
 [<c010a34b>] syscall_call+0x7/0xb
Code: 83 ae 58 01 00 00 01 8b 5d f8 8b 75 fc 89 ec 5d c3 83 ab 3c
 
 
>>EIP; c02d2314 <htb_unbind_filter+49/6b>   <=====
 
>>ebx; dc246078 <_end+1bdcbfa4/3fb83f2c>
>>ecx; da60e004 <_end+1a193f30/3fb83f2c>
>>edx; dc246004 <_end+1bdcbf30/3fb83f2c>
>>esi; da60e004 <_end+1a193f30/3fb83f2c>
>>edi; df4ffef8 <_end+1f085e24/3fb83f2c>
>>ebp; da5ede0c <_end+1a173d38/3fb83f2c>
>>esp; da5eddf4 <_end+1a173d20/3fb83f2c>
 
Trace; c02da54e <u32_destroy_key+6a/6c>
Trace; c02da7e7 <u32_clear_hnode+2e/48>
Trace; c02da826 <u32_destroy_hnode+25/86>
Trace; c02da955 <u32_destroy+ce/ec>
Trace; c02d148a <htb_destroy_filters+1d/29>
Trace; c02d169d <htb_destroy+67/d2>
Trace; c02c3fd4 <qdisc_destroy+81/92>
Trace; c02c4705 <dev_shutdown+aa/245>
Trace; c0138e4c <wakeme_after_rcu+0/c>
Trace; c02b7d0c <unregister_netdevice+db/335>
Trace; c02bf84a <rtnl_lock+22/37>
Trace; c0233ba7 <unregister_netdev+19/26>
Trace; c0239e26 <ppp_shutdown_interface+21e/3ba>
Trace; c0182376 <dput+23/685>
Trace; c0163e34 <__fput+7c/cd>
Trace; c0234011 <ppp_release+5f/61>
Trace; c0163e73 <__fput+bb/cd>
Trace; c0161f1d <filp_close+57/81>
Trace; c016204b <sys_close+104/228>
Trace; c010a34b <syscall_call+7/b>
 
Code;  c02d2314 <htb_unbind_filter+49/6b>
00000000 <_EIP>:
Code;  c02d2314 <htb_unbind_filter+49/6b>   <=====
   0:   83 ae 58 01 00 00 01      subl   $0x1,0x158(%esi)   <=====
Code;  c02d231b <htb_unbind_filter+50/6b>
   7:   8b 5d f8                  mov    0xfffffff8(%ebp),%ebx
Code;  c02d231e <htb_unbind_filter+53/6b>
   a:   8b 75 fc                  mov    0xfffffffc(%ebp),%esi
Code;  c02d2321 <htb_unbind_filter+56/6b>
   d:   89 ec                     mov    %ebp,%esp
Code;  c02d2323 <htb_unbind_filter+58/6b>
   f:   5d                        pop    %ebp
Code;  c02d2324 <htb_unbind_filter+59/6b>
  10:   c3                        ret
Code;  c02d2325 <htb_unbind_filter+5a/6b>
  11:   83 ab 3c 00 00 00 00      subl   $0x0,0x3c(%ebx)
 
 <0>Kernel panic: Fatal exception in interrupt
 
1 warning and 1 error issued.  Results may not be reliable.

-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

