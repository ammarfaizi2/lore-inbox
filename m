Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290578AbSARB6a>; Thu, 17 Jan 2002 20:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290581AbSARB6V>; Thu, 17 Jan 2002 20:58:21 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:24498 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S290578AbSARB6K>;
	Thu, 17 Jan 2002 20:58:10 -0500
Date: Thu, 17 Jan 2002 19:58:08 -0600
From: Josh Pieper <jjp@umr.edu>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.17
Message-ID: <20020118015808.GA13333@umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an oops I can get somehwat repeatably on my SMP system by compiling
a large program with make -j2.  This was captured when compiling evolution
1.0.1.  The kernel is 2.4.17, however it has been occuring for
all of 2.4 and possibly earlier.  Don't know if it is a hardware problem or
not.  Any help?  I can provide any information needed.

Please cc me, I am not subscribed.

Thanks,
Josh Pieper

---------------

Module                  Size  Used by    Tainted: P  
serial                 44640   0 
emu10k1                55488   1 
sound                  54540   0  [emu10k1]
soundcore               3844   7  [emu10k1 sound]
ac97_codec              9408   0  [emu10k1]
lp                      5568   0 
parport_pc             12356   1 
parport                15072   1  [lp parport_pc]
vfat                    9340   0  (unused)
fat                    29976   0  [vfat]
tuner                   8036   1  (autoclean)
tvaudio                 9792   1  (autoclean)
bttv                   58432   0  (unused)
videodev                4896   2  [bttv]
i2c-algo-bit            7052   1  [bttv]
i2c-core               13056   0  [tuner tvaudio bttv i2c-algo-bit]
8139too                12832   1 


-----------------

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan 17 19:13:53 zaphod kernel: invalid operand: 0000
Jan 17 19:13:53 zaphod kernel: CPU:    0
Jan 17 19:13:53 zaphod kernel: EIP:    0010:[rmqueue+405/456]    Tainted: P 
Jan 17 19:13:53 zaphod kernel: EFLAGS: 00010202
Jan 17 19:13:53 zaphod kernel: eax: 00000040   ebx: c028b240   ecx: c028b228   edx: 000041c5
Jan 17 19:13:53 zaphod kernel: esi: c1107140   edi: 00000000   ebp: 00000001   esp: c89d9e80
Jan 17 19:13:53 zaphod kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 19:13:53 zaphod kernel: Process sh (pid: 18295, stackpage=c89d9000)
Jan 17 19:13:53 zaphod kernel: Stack: c028b39c 000001ff 00000001 00000000 000031c5 00000286 00000000 c028b228 
Jan 17 19:13:53 zaphod kernel:        c012dadf 000001d2 00000000 00000001 cb22d4e0 c028b228 c028b398 000001d2 
Jan 17 19:13:53 zaphod kernel:        c85ea000 c012d932 c1112280 c0123fbf c7735cc0 080ca2d0 00000001 cb22d4e0 
Jan 17 19:13:53 zaphod kernel: Call Trace: [__alloc_pages+51/356] [_alloc_pages+22/24] [do_wp_page+147/392] [handle_mm_fault+135/188] [do_page_fault+382/1208] 
Jan 17 19:13:53 zaphod kernel: Code: 0f 0b 8b 46 18 a8 80 74 02 0f 0b 89 f0 eb 1c 47 83 c5 0c 83 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   8b 46 18                  mov    0x18(%esi),%eax
Code;  00000004 Before first symbol
   5:   a8 80                     test   $0x80,%al
Code;  00000006 Before first symbol
   7:   74 02                     je     b <_EIP+0xb> 0000000a Before first symbol
Code;  00000008 Before first symbol
   9:   0f 0b                     ud2a   
Code;  0000000a Before first symbol
   b:   89 f0                     mov    %esi,%eax
Code;  0000000c Before first symbol
   d:   eb 1c                     jmp    2b <_EIP+0x2b> 0000002a Before first symbol
Code;  0000000e Before first symbol
   f:   47                        inc    %edi
Code;  00000010 Before first symbol
  10:   83 c5 0c                  add    $0xc,%ebp
Code;  00000012 Before first symbol
  13:   83 00 00                  addl   $0x0,(%eax)

Jan 17 19:13:53 zaphod kernel:  invalid operand: 0000
Jan 17 19:13:53 zaphod kernel: CPU:    1
Jan 17 19:13:53 zaphod kernel: EIP:    0010:[rmqueue+405/456]    Tainted: P 
Jan 17 19:13:53 zaphod kernel: EFLAGS: 00010202
Jan 17 19:13:53 zaphod kernel: eax: 0000004c   ebx: c028b24c   ecx: c028b228   edx: 000041c4
Jan 17 19:13:53 zaphod kernel: esi: c1107100   edi: 00000001   ebp: 00000002   esp: c7541f2c
Jan 17 19:13:53 zaphod kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 19:13:53 zaphod kernel: Process sh (pid: 18298, stackpage=c7541000)
Jan 17 19:13:53 zaphod kernel: Stack: c028b37c 00000200 00000000 00000001 000031c4 00000286 00000001 c028b228 
Jan 17 19:13:53 zaphod kernel:        c012dadf 000001f0 bfffea20 00000000 00000011 c028b228 c028b378 000001f0 
Jan 17 19:13:53 zaphod kernel:        00000003 c012d932 c7540000 c012dc1a c01162cb c7540000 bfffea20 00000000 
Jan 17 19:13:53 zaphod kernel: Call Trace: [__alloc_pages+51/356] [_alloc_pages+22/24] [__get_free_pages+10/24] [do_fork+67/1776] [sys_fork+20/28] 
Jan 17 19:13:53 zaphod kernel: Code: 0f 0b 8b 46 18 a8 80 74 02 0f 0b 89 f0 eb 1c 47 83 c5 0c 83 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   8b 46 18                  mov    0x18(%esi),%eax
Code;  00000004 Before first symbol
   5:   a8 80                     test   $0x80,%al
Code;  00000006 Before first symbol
   7:   74 02                     je     b <_EIP+0xb> 0000000a Before first symbol
Code;  00000008 Before first symbol
   9:   0f 0b                     ud2a   
Code;  0000000a Before first symbol
   b:   89 f0                     mov    %esi,%eax
Code;  0000000c Before first symbol
   d:   eb 1c                     jmp    2b <_EIP+0x2b> 0000002a Before first symbol
Code;  0000000e Before first symbol
   f:   47                        inc    %edi
Code;  00000010 Before first symbol
  10:   83 c5 0c                  add    $0xc,%ebp
Code;  00000012 Before first symbol
  13:   83 00 00                  addl   $0x0,(%eax)

Jan 17 19:18:34 zaphod kernel:  invalid operand: 0000
Jan 17 19:18:34 zaphod kernel: CPU:    0
Jan 17 19:18:34 zaphod kernel: EIP:    0010:[__free_pages_ok+26/516]    Tainted: P 
Jan 17 19:18:34 zaphod kernel: EFLAGS: 00013286
Jan 17 19:18:34 zaphod kernel: eax: c1107100   ebx: c1107100   ecx: c1107100   edx: c1cfde50
Jan 17 19:18:34 zaphod kernel: esi: c1107100   edi: 00000000   ebp: 00000134   esp: ca897dc8
Jan 17 19:18:34 zaphod kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 19:18:34 zaphod kernel: Process XFree86 (pid: 303, stackpage=ca897000)
Jan 17 19:18:34 zaphod kernel: Stack: c1107100 c1107100 00000010 00000134 c01355ec c1107100 000001d2 c76822a0 
Jan 17 19:18:34 zaphod kernel:        c012c796 c012dc79 c76822a0 c012ce77 00000020 000001d2 00000020 00000006 
Jan 17 19:18:34 zaphod kernel:        ca896000 ca896000 00000c20 000001d2 c028b228 c012d0e6 00000006 00000014 
Jan 17 19:18:34 zaphod kernel: Call Trace: [try_to_release_page+60/68] [lru_cache_del+18/28] [page_cache_release+45/48] [shrink_cache+611/924] [shrink_caches+86/124] 
Jan 17 19:18:34 zaphod kernel: Code: 0f 0b 89 d8 2b 05 8c cb 30 c0 c1 f8 06 3b 05 80 cb 30 c0 72 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   89 d8                     mov    %ebx,%eax
Code;  00000004 Before first symbol
   4:   2b 05 8c cb 30 c0         sub    0xc030cb8c,%eax
Code;  0000000a Before first symbol
   a:   c1 f8 06                  sar    $0x6,%eax
Code;  0000000c Before first symbol
   d:   3b 05 80 cb 30 c0         cmp    0xc030cb80,%eax
Code;  00000012 Before first symbol
  13:   72 00                     jb     15 <_EIP+0x15> 00000014 Before first symbol


1 warning issued.  Results may not be reliable.
