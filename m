Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSB0ANa>; Tue, 26 Feb 2002 19:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSB0ANU>; Tue, 26 Feb 2002 19:13:20 -0500
Received: from tassadar.physics.auth.gr ([155.207.123.25]:44161 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S290229AbSB0ANK>; Tue, 26 Feb 2002 19:13:10 -0500
Date: Wed, 27 Feb 2002 02:13:03 +0200 (EET)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org, <ext2-devel@lists.sourceforge.net>
Subject: Re: assertion failure : ext3 & lvm , 2.4.17 smp & 2.4.18-ac1 smp
In-Reply-To: <3C7C2264.7C255E9A@zip.com.au>
Message-ID: <Pine.LNX.4.44.0202270211560.540-100000@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there you go , a fresh one :)

ksymoops 2.4.3 on i686 2.4.18-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-ac1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c02202c0, System.map says c01573b0.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01635ea>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000007b   ebx: d5a8a294   ecx: 00000002   edx: 00000001
esi: d3a743c0   edi: d5a8a200   ebp: d7701d30   esp: d6713cd4
ds: 0018   es: 0018   ss: 0018
Process wget (pid: 456, stackpage=d6713000)
Stack: c02a7080 c02a748e c02a7060 000002da c02a7640 d5a8a200 d3a743c0 d7701d30
       d5a8a294 00000001 00000001 00000000 00000000 db800740 c01636ad d3a743c0
       d7701d30 00000000 00000000 000004e8 d7990c00 d6713d8c c0158a70 d3a743c0
Call Trace: [<c01636ad>] [<c0158a70>] [<c0252050>] [<c015a7b6>] [<c015aa8f>]
   [<c011a94f>] [<c0239349>] [<c015b0ee>] [<c015b236>] [<c013902b>] [<c013985e>]
   [<c015b1dc>] [<c015b6dd>] [<c015b1dc>] [<c01299b0>] [<c01593ba>] [<c0136717>]
   [<c0106e7b>]
Code: 0f 0b 83 c4 14 90 8b 4d 00 8b 41 38 0f b6 50 25 8b 7d 0c 8b

>>EIP; c01635ea <do_get_write_access+4b6/540>   <=====
Trace; c01636ac <journal_get_write_access+38/5c>
Trace; c0158a70 <ext3_new_block+478/774>
Trace; c0252050 <ip_rcv_finish+0/21e>
Trace; c015a7b6 <ext3_alloc_block+1e/24>
Trace; c015aa8e <ext3_alloc_branch+3e/288>
Trace; c011a94e <do_softirq+6e/cc>
Trace; c0239348 <_text_lock_netfilter+c0/e8>
Trace; c015b0ee <ext3_get_block_handle+1ca/2b8>
Trace; c015b236 <ext3_get_block+5a/60>
Trace; c013902a <__block_prepare_write+da/2dc>
Trace; c013985e <block_prepare_write+22/3c>
Trace; c015b1dc <ext3_get_block+0/60>
Trace; c015b6dc <ext3_prepare_write+d4/1c4>
Trace; c015b1dc <ext3_get_block+0/60>
Trace; c01299b0 <generic_file_write+488/758>
Trace; c01593ba <ext3_file_write+46/4c>
Trace; c0136716 <sys_write+8e/100>
Trace; c0106e7a <system_call+32/38>
Code;  c01635ea <do_get_write_access+4b6/540>
0000000000000000 <_EIP>:
Code;  c01635ea <do_get_write_access+4b6/540>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01635ec <do_get_write_access+4b8/540>
   2:   83 c4 14                  add    $0x14,%esp
Code;  c01635ee <do_get_write_access+4ba/540>
   5:   90                        nop
Code;  c01635f0 <do_get_write_access+4bc/540>
   6:   8b 4d 00                  mov    0x0(%ebp),%ecx
Code;  c01635f2 <do_get_write_access+4be/540>
   9:   8b 41 38                  mov    0x38(%ecx),%eax
Code;  c01635f6 <do_get_write_access+4c2/540>
   c:   0f b6 50 25               movzbl 0x25(%eax),%edx
Code;  c01635fa <do_get_write_access+4c6/540>
  10:   8b 7d 0c                  mov    0xc(%ebp),%edi
Code;  c01635fc <do_get_write_access+4c8/540>
  13:   8b 00                     mov    (%eax),%eax


2 warnings issued.  Results may not be reliable.


 kind regards
--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle Univercity of Thessaloniki , Greece
=============================================================================

