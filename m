Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286926AbRL1QB1>; Fri, 28 Dec 2001 11:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286925AbRL1QBS>; Fri, 28 Dec 2001 11:01:18 -0500
Received: from ADSLP35-NV-p104.adsl.netvision.net.il ([212.143.35.104]:44929
	"EHLO witch.dyndns.org") by vger.kernel.org with ESMTP
	id <S286931AbRL1QBC>; Fri, 28 Dec 2001 11:01:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hetz Ben Hamo <hetz@kde.org>
To: linux-kernel@vger.kernel.org
Subject: serious VM problems
Date: Fri, 28 Dec 2001 17:59:37 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16JzPf-0006i0-00@witch.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I had a VM problem for the last couple of months and I thought it due to my 
hardware, which I replaced this week and still get this problem. I'll explain:

I'm running here KDE 2.2.1 with server Konsole sessions running, and using 
mondo-archive program to backup my machine. After the backup finishes part of 
the backup - the VM panic randomly - sometimes it's the bzip2 process which 
the mondo uses, sometimes the afio which the mondo uses, sometimes its just 
the kswapd daemon, sometimes wineX which I'm testing - so as you can see from 
the pattern - it's not a program or a module that does it yet it happends to 
me on both machines

I have checked the RAM of the machines twice - with memtest86 2.8 for 24 
hours - no errors. 

I checked the machines - one AMD 800Mhz thunderbird + Asus A7V board, and 
once Pentium 4 1.5Ghz with Intel board (i845 chipset) - so it's not the 
processors or the boards.

I checked the hard drive (40GB EIDE IBM 7200RPM with a fan) - no sectors or 
any disk problems. Sound card is SBLive - no problems there either...

Here is the output from /var/log/messages:

Dec 28 16:47:30 gorgeous kernel: kernel BUG at slab.c:1198!
Dec 28 16:47:30 gorgeous kernel: invalid operand: 0000
Dec 28 16:47:30 gorgeous kernel: CPU:    0
Dec 28 16:47:30 gorgeous kernel: EIP:    0010:[kmem_extra_free_checks+50/160] 
   Not tainted
Dec 28 16:47:30 gorgeous kernel: EIP:    0010:[<c01289a2>]    Not tainted
Dec 28 16:47:30 gorgeous kernel: EFLAGS: 00010082
Dec 28 16:47:30 gorgeous kernel: eax: 0000001b   ebx: d397d080   ecx: 
00000001   edx: 00002466
Dec 28 16:47:30 gorgeous kernel: esi: 00000438   edi: c18064b8   ebp: 
d39fd000   esp: c1869ed0
Dec 28 16:47:30 gorgeous kernel: ds: 0018   es: 0018   ss: 0018
Dec 28 16:47:30 gorgeous kernel: Process kswapd (pid: 4, stackpage=c1869000)
Dec 28 16:47:30 gorgeous kernel: Stack: c01feb23 000004ae 004e7f40 d39fd000 
000001e8 d39fdbf0 c0128fe8 c18064b8
Dec 28 16:47:30 gorgeous kernel:        d39fd000 d39fdbf0 c1869f54 00000246 
d39fdbf4 c1869f40 ce69782c c1869f54
Dec 28 16:47:30 gorgeous kernel:        c01412ed c18064b8 d39fdbf4 d39fdbf4 
c0141e4e d39fdbf4 d39fdbf4 ce697644
Dec 28 16:47:30 gorgeous kernel: Call Trace: [kmem_cache_free+488/640] 
[destroy_inode+45/64] [dispose_list+62/80] [prune_icache+165/192] 
[shrink_icache_memory+32/64]
Dec 28 16:47:30 gorgeous kernel: Call Trace: [<c0128fe8>] [<c01412ed>] 
[<c0141e4e>] [<c0142075>] [<c01420b0>]
Dec 28 16:47:30 gorgeous kernel:    [shrink_caches+110/128] 
[try_to_free_pages+60/96] [kswapd_balance_pgdat+81/160] [kswapd_balance+38/64]
[kswapd+161/192] [kswapd+0/192]
Dec 28 16:47:30 gorgeous kernel:    [<c012a22e>] [<c012a27c>] [<c012a321>] 
[<c012a396>] [<c012a4d1>] [<c012a430>]
Dec 28 16:47:30 gorgeous kernel:    [_stext+0/48] [kernel_thread+38/48] 
[kswapd+0/192]
Dec 28 16:47:30 gorgeous kernel:    [<c0105000>] [<c0105516>] [<c012a430>]
Dec 28 16:47:30 gorgeous kernel:
Dec 28 16:47:30 gorgeous kernel: Code: 0f 0b 58 8b 5d 0c 8b 4f 18 5a 89 f0 0f 
af c1 8d 04 18 39 44

So if my RAM is ok, disk ok, processor ok, plenty of air cooling (6 fans!), 
graphics & sounds card seems working ok (SB Live & Geforce 2 Ti - with & 
without the binary only drivers, and I also tried Matrox G400 with the open 
source drivers) then what could cause this? 

Thanks,
Hetz

PS: It seems that there is still some problem with the vger server - I get 
the first email to subscribe but when I reply with the auth - it doesn't give 
me anything and I think my ISP doesn't have any issues with ECN.
