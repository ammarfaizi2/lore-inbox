Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbSJBLXh>; Wed, 2 Oct 2002 07:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263055AbSJBLXh>; Wed, 2 Oct 2002 07:23:37 -0400
Received: from server1.mpc.com.br ([200.246.0.242]:24069 "EHLO
	server1.mpc.com.br") by vger.kernel.org with ESMTP
	id <S263049AbSJBLX2>; Wed, 2 Oct 2002 07:23:28 -0400
Date: Wed, 2 Oct 2002 08:28:42 -0300
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.4.20-pre8 VM oops
Message-ID: <20021002112842.GA3719@mpcnet.com.br>
Mail-Followup-To: pellegrini@mpcnet.com.br,
	LKML <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: pellegrini@mpcnet.com.br (Jeronimo Pellegrini)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I found this (multilpe) oops this morning. 
CPU is an Athlon 1.3MHz. I do not know what the box was running when it
happened. Is there anything else I should send?

J.

Linux socrates 2.4.20-pre8 #1 Sat Sep 28 23:34:03 BRT 2002 i686 unknown
unknown GNU/Linux
 
 Gnu C                  2.95.4
 Gnu make               3.79.1
 util-linux             2.11n
 mount                  2.11n
 modutils               2.4.19
 e2fsprogs              1.29
 PPP                    2.4.1
 Linux C Library        2.2.5
 Dynamic linker (ldd)   2.2.5
 Procps                 2.0.7
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               4.5.1
 Modules Loaded         sr_mod ipt_TOS ipt_LOG ipt_limit ipt_state
 iptable_mangle iptable_nat iptable_filter ip_conntrack_irc
 ip_conntrack_ftp ip_conntrack ip_tables ppp_deflate zlib_inflate
 zlib_deflate bsd_comp parport_pc lp parport ppp_async ppp_generic slhc
 rtc nls_iso8859-1 nls_cp437 vfat fat ide-scsi scsi_mod 8139too mii
 i2c-viapro w83781d eeprom i2c-proc i2c-isa i2c-core es1371 soundcore
 ac97_codec gameport


ksymoops 2.4.6 on i686 2.4.20-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre8/ (default)
     -m /boot/System.map-2.4.20-pre8 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct  1 23:54:38 localhost kernel: kernel BUG at vmscan.c:553!
Oct  1 23:54:38 localhost kernel: invalid operand: 0000
Oct  1 23:54:38 localhost kernel: CPU:    0
Oct  1 23:54:38 localhost kernel: EIP:    0010:[refill_inactive+159/240]    Not tainted
Oct  1 23:54:38 localhost kernel: EFLAGS: 00010246
Oct  1 23:54:38 localhost kernel: eax: 00000023   ebx: c10264ac   ecx: c10264c8   edx: c1130f00
Oct  1 23:54:38 localhost kernel: esi: c1130f00   edi: 0000000f   ebp: 00000002   esp: c12eff68
Oct  1 23:54:38 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 23:54:38 localhost kernel: Process kswapd (pid: 4, stackpage=c12ef000)
Oct  1 23:54:38 localhost kernel: Stack: 00000020 000001d0 00000020 00000006 c012e488 00000011 00000006 00000020 
Oct  1 23:54:38 localhost kernel:        000001d0 c02c5194 c02c5194 c012e4fc 00000020 c02c5194 00000001 c12ee000 
Oct  1 23:54:38 localhost kernel:        00000000 c012e601 c02c50e0 00000000 c12ee249 0008e000 c012e666 c02c50e0 
Oct  1 23:54:38 localhost kernel: Call Trace:    [shrink_caches+72/128] [try_to_free_pages_zone+60/96] [kswapd_balance_pgdat+65/144] [kswapd_balance+22/48] [kswapd+157/192]
Oct  1 23:54:38 localhost kernel: Code: 0f 0b 29 02 9c 30 27 c0 8b 43 18 a8 80 74 08 0f 0b 29 02 9c 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c10264ac <_end+cd25c8/1050417c>
>>ecx; c10264c8 <_end+cd25e4/1050417c>
>>edx; c1130f00 <_end+ddd01c/1050417c>
>>esi; c1130f00 <_end+ddd01c/1050417c>
>>esp; c12eff68 <_end+f9c084/1050417c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   29 02                     sub    %eax,(%edx)
Code;  00000004 Before first symbol
   4:   9c                        pushf  
Code;  00000005 Before first symbol
   5:   30 27                     xor    %ah,(%edi)
Code;  00000007 Before first symbol
   7:   c0 8b 43 18 a8 80 74      rorb   $0x74,0x80a81843(%ebx)
Code;  0000000e Before first symbol
   e:   08 0f                     or     %cl,(%edi)
Code;  00000010 Before first symbol
  10:   0b 29                     or     (%ecx),%ebp
Code;  00000012 Before first symbol
  12:   02 9c 00 00 00 00 00      add    0x0(%eax,%eax,1),%bl

Oct  1 23:55:38 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct  1 23:55:38 localhost kernel: c012e3cd
Oct  1 23:55:38 localhost kernel: *pde = 00000000
Oct  1 23:55:38 localhost kernel: Oops: 0002
Oct  1 23:55:38 localhost kernel: CPU:    0
Oct  1 23:55:38 localhost kernel: EIP:    0010:[refill_inactive+125/240]    Not tainted
Oct  1 23:55:38 localhost kernel: EFLAGS: 00010206
Oct  1 23:55:38 localhost kernel: eax: c02c5008   ebx: c1130ee4   ecx: c1130f00   edx: 00000000
Oct  1 23:55:38 localhost kernel: esi: 00000000   edi: 00000011   ebp: 00000002   esp: c24a9e0c
Oct  1 23:55:38 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 23:55:38 localhost kernel: Process cc1plus (pid: 23400, stackpage=c24a9000)
Oct  1 23:55:38 localhost kernel: Stack: 00000020 000001d2 00000020 00000006 c012e488 00000012 00000006 00000020 
Oct  1 23:55:38 localhost kernel:        000001d2 c02c5194 c02c5194 c012e4fc 00000020 c24a8000 00000000 00000010 
Oct  1 23:55:38 localhost kernel:        c02c5194 c012eef0 c02c5328 00000120 00000010 00000000 00000a30 00000286 
Oct  1 23:55:38 localhost kernel: Call Trace:    [shrink_caches+72/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [mmx_clear_page+38/48]
Oct  1 23:55:38 localhost kernel: Code: 89 02 c7 43 1c 00 00 00 00 c7 41 04 00 00 00 00 0f ba 73 18 


>>eax; c02c5008 <active_list+0/8>
>>ebx; c1130ee4 <_end+ddd000/1050417c>
>>ecx; c1130f00 <_end+ddd01c/1050417c>
>>esp; c24a9e0c <_end+2155f28/1050417c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 02                     mov    %eax,(%edx)
Code;  00000002 Before first symbol
   2:   c7 43 1c 00 00 00 00      movl   $0x0,0x1c(%ebx)
Code;  00000009 Before first symbol
   9:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  00000010 Before first symbol
  10:   0f ba 73 18 00            btrl   $0x0,0x18(%ebx)

Oct  1 23:55:40 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Oct  1 23:55:40 localhost kernel: c012e37a
Oct  1 23:55:40 localhost kernel: *pde = 00000000
Oct  1 23:55:40 localhost kernel: Oops: 0000
Oct  1 23:55:40 localhost kernel: CPU:    0
Oct  1 23:55:40 localhost kernel: EIP:    0010:[refill_inactive+42/240]    Not tainted
Oct  1 23:55:40 localhost kernel: EFLAGS: 00010213
Oct  1 23:55:40 localhost kernel: eax: 00000012   ebx: ffffffe4   ecx: 00000012   edx: 00008254
Oct  1 23:55:40 localhost kernel: esi: 00000000   edi: 00000012   ebp: 00000002   esp: c4d49e0c
Oct  1 23:55:40 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 23:55:40 localhost kernel: Process cc1plus (pid: 23403, stackpage=c4d49000)
Oct  1 23:55:40 localhost kernel: Stack: 00000020 000001d2 00000020 00000006 c012e488 00000012 00000006 00000020 
Oct  1 23:55:40 localhost kernel:        000001d2 c02c5194 c02c5194 c012e4fc 00000020 c4d48000 00000000 00000010 
Oct  1 23:55:40 localhost kernel:        c02c5194 c012eef0 c02c5328 00000120 00000010 00000000 000006d0 00000286 
Oct  1 23:55:40 localhost kernel: Call Trace:    [shrink_caches+72/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [mmx_clear_page+38/48]
Oct  1 23:55:40 localhost kernel: Code: 8b 76 04 0f b3 6b 18 19 c0 85 c0 74 39 8d 4b 1c 8b 51 04 8b 


>>esp; c4d49e0c <_end+49f5f28/1050417c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 04                  mov    0x4(%esi),%esi
Code;  00000003 Before first symbol
   3:   0f b3 6b 18               btr    %ebp,0x18(%ebx)
Code;  00000007 Before first symbol
   7:   19 c0                     sbb    %eax,%eax
Code;  00000009 Before first symbol
   9:   85 c0                     test   %eax,%eax
Code;  0000000b Before first symbol
   b:   74 39                     je     46 <_EIP+0x46> 00000046 Before first symbol
Code;  0000000d Before first symbol
   d:   8d 4b 1c                  lea    0x1c(%ebx),%ecx
Code;  00000010 Before first symbol
  10:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Oct  1 23:58:18 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Oct  1 23:58:18 localhost kernel: c012e37a
Oct  1 23:58:18 localhost kernel: *pde = 00000000
Oct  1 23:58:18 localhost kernel: Oops: 0000
Oct  1 23:58:18 localhost kernel: CPU:    0
Oct  1 23:58:18 localhost kernel: EIP:    0010:[refill_inactive+42/240]    Not tainted
Oct  1 23:58:18 localhost kernel: EFLAGS: 00010213
Oct  1 23:58:18 localhost kernel: eax: 00000013   ebx: ffffffe4   ecx: 00000013   edx: 0000061e
Oct  1 23:58:18 localhost kernel: esi: 00000000   edi: 00000013   ebp: 00000002   esp: c0837e34
Oct  1 23:58:18 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 23:58:18 localhost kernel: Process spamd (pid: 23429, stackpage=c0837000)
Oct  1 23:58:18 localhost kernel: Stack: 00000020 000001d2 00000020 00000006 c012e488 00000013 00000006 00000020 
Oct  1 23:58:18 localhost kernel:        000001d2 c02c5194 c02c5194 c012e4fc 00000020 c0836000 00000000 00000010 
Oct  1 23:58:18 localhost kernel:        c02c5194 c012eef0 c02c5328 00000120 00000010 00000000 00000a30 00000296 
Oct  1 23:58:18 localhost kernel: Call Trace:    [shrink_caches+72/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [_alloc_pages+22/32]
Oct  1 23:58:18 localhost kernel: Code: 8b 76 04 0f b3 6b 18 19 c0 85 c0 74 39 8d 4b 1c 8b 51 04 8b 


>>esp; c0837e34 <_end+4e3f50/1050417c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 04                  mov    0x4(%esi),%esi
Code;  00000003 Before first symbol
   3:   0f b3 6b 18               btr    %ebp,0x18(%ebx)
Code;  00000007 Before first symbol
   7:   19 c0                     sbb    %eax,%eax
Code;  00000009 Before first symbol
   9:   85 c0                     test   %eax,%eax
Code;  0000000b Before first symbol
   b:   74 39                     je     46 <_EIP+0x46> 00000046 Before first symbol
Code;  0000000d Before first symbol
   d:   8d 4b 1c                  lea    0x1c(%ebx),%ecx
Code;  00000010 Before first symbol
  10:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Oct  1 23:58:18 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Oct  1 23:58:18 localhost kernel: c012e37a
Oct  1 23:58:18 localhost kernel: *pde = 00000000
Oct  1 23:58:18 localhost kernel: Oops: 0000
Oct  1 23:58:18 localhost kernel: CPU:    0
Oct  1 23:58:18 localhost kernel: EIP:    0010:[refill_inactive+42/240]    Not tainted
Oct  1 23:58:18 localhost kernel: EFLAGS: 00010213
Oct  1 23:58:18 localhost kernel: eax: 00000013   ebx: ffffffe4   ecx: 00000013   edx: 00000c5e
Oct  1 23:58:18 localhost kernel: esi: 00000000   edi: 00000013   ebp: 00000002   esp: c0df1e34
Oct  1 23:58:18 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 23:58:18 localhost kernel: Process spamd (pid: 23435, stackpage=c0df1000)
Oct  1 23:58:18 localhost kernel: Stack: 00000020 000001d2 00000020 00000006 c012e488 00000013 00000006 00000020 
Oct  1 23:58:18 localhost kernel:        000001d2 c02c5194 c02c5194 c012e4fc 00000020 c0df0000 00000000 00000010 
Oct  1 23:58:18 localhost kernel:        c02c5194 c012eef0 c02c5328 00000120 00000010 00000000 000009f0 00000296 
Oct  1 23:58:18 localhost kernel: Call Trace:    [shrink_caches+72/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [_alloc_pages+22/32]
Oct  1 23:58:18 localhost kernel: Code: 8b 76 04 0f b3 6b 18 19 c0 85 c0 74 39 8d 4b 1c 8b 51 04 8b 


>>esp; c0df1e34 <_end+a9df50/1050417c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 04                  mov    0x4(%esi),%esi
Code;  00000003 Before first symbol
   3:   0f b3 6b 18               btr    %ebp,0x18(%ebx)
Code;  00000007 Before first symbol
   7:   19 c0                     sbb    %eax,%eax
Code;  00000009 Before first symbol
   9:   85 c0                     test   %eax,%eax
Code;  0000000b Before first symbol
   b:   74 39                     je     46 <_EIP+0x46> 00000046 Before first symbol
Code;  0000000d Before first symbol
   d:   8d 4b 1c                  lea    0x1c(%ebx),%ecx
Code;  00000010 Before first symbol
  10:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Oct  1 23:58:19 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Oct  1 23:58:19 localhost kernel: c012e37a
Oct  1 23:58:19 localhost kernel: *pde = 00000000
Oct  1 23:58:19 localhost kernel: Oops: 0000
Oct  1 23:58:19 localhost kernel: CPU:    0
Oct  1 23:58:19 localhost kernel: EIP:    0010:[refill_inactive+42/240]    Not tainted
Oct  1 23:58:19 localhost kernel: EFLAGS: 00010213
Oct  1 23:58:19 localhost kernel: eax: 00000013   ebx: ffffffe4   ecx: 00000013   edx: 00001646
Oct  1 23:58:19 localhost kernel: esi: 00000000   edi: 00000013   ebp: 00000002   esp: c4717e34
Oct  1 23:58:19 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 23:58:19 localhost kernel: Process spamd (pid: 23441, stackpage=c4717000)
Oct  1 23:58:19 localhost kernel: Stack: 00000020 000001d2 00000020 00000006 c012e488 00000013 00000006 00000020 
Oct  1 23:58:19 localhost kernel:        000001d2 c02c5194 c02c5194 c012e4fc 00000020 c4716000 00000000 00000010 
Oct  1 23:58:19 localhost kernel:        c02c5194 c012eef0 c02c5328 00000120 00000010 00000000 00000b00 00000296 
Oct  1 23:58:19 localhost kernel: Call Trace:    [shrink_caches+72/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [_alloc_pages+22/32]
Oct  1 23:58:19 localhost kernel: Code: 8b 76 04 0f b3 6b 18 19 c0 85 c0 74 39 8d 4b 1c 8b 51 04 8b 


>>esp; c4717e34 <_end+43c3f50/1050417c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 04                  mov    0x4(%esi),%esi
Code;  00000003 Before first symbol
   3:   0f b3 6b 18               btr    %ebp,0x18(%ebx)
Code;  00000007 Before first symbol
   7:   19 c0                     sbb    %eax,%eax
Code;  00000009 Before first symbol
   9:   85 c0                     test   %eax,%eax
Code;  0000000b Before first symbol
   b:   74 39                     je     46 <_EIP+0x46> 00000046 Before first symbol
Code;  0000000d Before first symbol
   d:   8d 4b 1c                  lea    0x1c(%ebx),%ecx
Code;  00000010 Before first symbol
  10:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Oct  1 23:58:19 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Oct  1 23:58:19 localhost kernel: c012e37a
Oct  1 23:58:19 localhost kernel: *pde = 00000000
Oct  1 23:58:19 localhost kernel: Oops: 0000
Oct  1 23:58:19 localhost kernel: CPU:    0
Oct  1 23:58:19 localhost kernel: EIP:    0010:[refill_inactive+42/240]    Not tainted
Oct  1 23:58:19 localhost kernel: EFLAGS: 00010213
Oct  1 23:58:19 localhost kernel: eax: 00000013   ebx: ffffffe4   ecx: 00000013   edx: 0000301e
Oct  1 23:58:19 localhost kernel: esi: 00000000   edi: 00000013   ebp: 00000002   esp: c7cbbe34
Oct  1 23:58:19 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 23:58:19 localhost kernel: Process spamd (pid: 915, stackpage=c7cbb000)
Oct  1 23:58:19 localhost kernel: Stack: 00000020 000001d2 00000020 00000006 c012e488 00000013 00000006 00000020 
Oct  1 23:58:19 localhost kernel:        000001d2 c02c5194 c02c5194 c012e4fc 00000020 c7cba000 00000000 00000010 
Oct  1 23:58:19 localhost kernel:        c02c5194 c012eef0 c02c5328 00000120 00000010 00000000 00000db0 00000296 
Oct  1 23:58:19 localhost kernel: Call Trace:    [shrink_caches+72/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [_alloc_pages+22/32]
Oct  1 23:58:19 localhost kernel: Code: 8b 76 04 0f b3 6b 18 19 c0 85 c0 74 39 8d 4b 1c 8b 51 04 8b 


>>esp; c7cbbe34 <_end+7967f50/1050417c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 04                  mov    0x4(%esi),%esi
Code;  00000003 Before first symbol
   3:   0f b3 6b 18               btr    %ebp,0x18(%ebx)
Code;  00000007 Before first symbol
   7:   19 c0                     sbb    %eax,%eax
Code;  00000009 Before first symbol
   9:   85 c0                     test   %eax,%eax
Code;  0000000b Before first symbol
   b:   74 39                     je     46 <_EIP+0x46> 00000046 Before first symbol
Code;  0000000d Before first symbol
   d:   8d 4b 1c                  lea    0x1c(%ebx),%ecx
Code;  00000010 Before first symbol
  10:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Oct  1 23:58:20 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Oct  1 23:58:20 localhost kernel: c012e37a
Oct  1 23:58:20 localhost kernel: *pde = 00000000
Oct  1 23:58:20 localhost kernel: Oops: 0000
Oct  1 23:58:20 localhost kernel: CPU:    0
Oct  1 23:58:20 localhost kernel: EIP:    0010:[refill_inactive+42/240]    Not tainted
Oct  1 23:58:20 localhost kernel: EFLAGS: 00010213
Oct  1 23:58:20 localhost kernel: eax: 00000013   ebx: ffffffe4   ecx: 00000013   edx: 00003064
Oct  1 23:58:20 localhost kernel: esi: 00000000   edi: 00000013   ebp: 00000002   esp: c0ed9e0c
Oct  1 23:58:20 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 23:58:20 localhost kernel: Process spamd (pid: 23446, stackpage=c0ed9000)
Oct  1 23:58:20 localhost kernel: Stack: 00000020 000001d2 00000020 00000006 c012e488 00000013 00000006 00000020 
Oct  1 23:58:20 localhost kernel:        000001d2 c02c5194 c02c5194 c012e4fc 00000020 c0ed8000 00000000 00000010 
Oct  1 23:58:20 localhost kernel:        c02c5194 c012eef0 c02c5328 00000120 00000010 00000000 000009f0 00000286 
Oct  1 23:58:20 localhost kernel: Call Trace:    [shrink_caches+72/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [_alloc_pages+22/32]
Oct  1 23:58:20 localhost kernel: Code: 8b 76 04 0f b3 6b 18 19 c0 85 c0 74 39 8d 4b 1c 8b 51 04 8b 


>>esp; c0ed9e0c <_end+b85f28/1050417c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 04                  mov    0x4(%esi),%esi
Code;  00000003 Before first symbol
   3:   0f b3 6b 18               btr    %ebp,0x18(%ebx)
Code;  00000007 Before first symbol
   7:   19 c0                     sbb    %eax,%eax
Code;  00000009 Before first symbol
   9:   85 c0                     test   %eax,%eax
Code;  0000000b Before first symbol
   b:   74 39                     je     46 <_EIP+0x46> 00000046 Before first symbol
Code;  0000000d Before first symbol
   d:   8d 4b 1c                  lea    0x1c(%ebx),%ecx
Code;  00000010 Before first symbol
  10:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax


1 warning issued.  Results may not be reliable.

-- 
