Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284445AbRLCIvh>; Mon, 3 Dec 2001 03:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284448AbRLCIu2>; Mon, 3 Dec 2001 03:50:28 -0500
Received: from pool-151-204-72-40.delv.east.verizon.net ([151.204.72.40]:32078
	"EHLO saimiri.owsla.net") by vger.kernel.org with ESMTP
	id <S284569AbRLCBO6>; Sun, 2 Dec 2001 20:14:58 -0500
Date: Sun, 2 Dec 2001 20:16:13 -0500
From: Andrew Ferguson <andrew@owsla.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: andrew@owsla.cjb.net
Subject: [OOPS] kswapd/VM problem in 2.5.1-pre1
Message-ID: <20011202201613.A1168@saimiri.princeton.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_6TrnltStXW4iwm"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=_6TrnltStXW4iwm
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi,
	My system experienced two oops, both in the same place (I think). 
This is on a 1.4 ghz athlon with 1.0 Gb of ram (1-4gb HighMem enabled) and 
512 mb of swap. I was away from the computer at the time, but I suspect 
that it was as I had left it, that is, with the ram nearly filled with the 
cache and a few megabytes of swap used. The system was probably five hours 
into a six hour divxencoding with drip. The kernel is stock 2.5.1-pre1 
with the 2.6.2 i2c and lm_sensors patches applied. Ksymoops output for the 
first oops is attached. More information is available upon request and 
please CC me because I am not on the list. Thanks.

_________________________________________________
Andrew Ferguson
http://owsla.cjb.net | andrew@owsla.cjb.net
Tintin Webring: http://owsla.cjb.net/tintin/ring/

--=_6TrnltStXW4iwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.txt"

---- Ksymoops output ----

ksymoops 2.4.3 on i686 2.5.1-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.1-pre1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Dec  2 16:33:59 saimiri kernel: invalid operand: 0000
Dec  2 16:33:59 saimiri kernel: CPU:    0
Dec  2 16:33:59 saimiri kernel: EIP:    0010:[shrink_cache+142/720]    Not tainted
Dec  2 16:33:59 saimiri kernel: EIP:    0010:[<c01284ae>]    Not tainted
Dec  2 16:33:59 saimiri kernel: EFLAGS: 00010202
Dec  2 16:33:59 saimiri kernel: eax: 00000040   ebx: 00000000   ecx: c1b40c1c   edx: f7ef8000
Dec  2 16:33:59 saimiri kernel: esi: c1b40c00   edi: 0000000f   ebp: 0000329c   esp: f7ef9f34
Dec  2 16:33:59 saimiri kernel: ds: 0018   es: 0018   ss: 0018
Dec  2 16:33:59 saimiri kernel: Process kswapd (pid: 4, stackpage=f7ef9000)
Dec  2 16:33:59 saimiri kernel: Stack: f7ea6000 f7ef8000 00000096 000001d0 c0242050 c02aee40 f7ea8cc0 c200b1a0 
Dec  2 16:33:59 saimiri kernel:        00000000 00000020 000001d0 00000006 00000020 c0128820 00000006 0000001f 
Dec  2 16:33:59 saimiri kernel:        c0242050 00000006 000001d0 c0242050 00000000 c012887c 00000020 c0242050 
Dec  2 16:33:59 saimiri kernel: Call Trace: [shrink_caches+80/128] [try_to_free_pages+44/80] [kswapd_balance_pgdat+81/160] [kswapd_balance+38/64] [kswapd+161/192] 
Dec  2 16:33:59 saimiri kernel: Call Trace: [<c0128820>] [<c012887c>] [<c0128921>] [<c0128996>] [<c0128ad1>] 
Dec  2 16:33:59 saimiri kernel:    [kswapd+0/192] [_stext+0/48] [kernel_thread+38/48] [kswapd+0/192] 
Dec  2 16:33:59 saimiri kernel:    [<c0128a30>] [<c0105000>] [<c0105746>] [<c0128a30>]
Dec  2 16:33:59 saimiri kernel: 
Dec  2 16:33:59 saimiri kernel: Code: 0f 0b 8b 41 fc a9 80 00 00 00 74 02 0f 0b 8b 01 8b 51 04 31 
Dec  2 16:33:59 saimiri kernel: invalid operand: 0000
Dec  2 16:33:59 saimiri kernel: CPU:    0
Dec  2 16:33:59 saimiri kernel: EIP:    0010:[shrink_cache+142/720]    Not tainted
Dec  2 16:33:59 saimiri kernel: EIP:    0010:[<c01284ae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  2 16:33:59 saimiri kernel: EFLAGS: 00010202
Dec  2 16:33:59 saimiri kernel: eax: 00000040   ebx: 00000000   ecx: c1b40c1c   edx: f7ef8000
Dec  2 16:33:59 saimiri kernel: esi: c1b40c00   edi: 0000000f   ebp: 0000329c   esp: f7ef9f34
Dec  2 16:33:59 saimiri kernel: ds: 0018   es: 0018   ss: 0018
Dec  2 16:33:59 saimiri kernel: Process kswapd (pid: 4, stackpage=f7ef9000)
Dec  2 16:33:59 saimiri kernel: Stack: f7ea6000 f7ef8000 00000096 000001d0 c0242050 c02aee40 f7ea8cc0 c200b1a0 
Dec  2 16:33:59 saimiri kernel:        00000000 00000020 000001d0 00000006 00000020 c0128820 00000006 0000001f 
Dec  2 16:33:59 saimiri kernel:        c0242050 00000006 000001d0 c0242050 00000000 c012887c 00000020 c0242050 
Dec  2 16:33:59 saimiri kernel: Call Trace: [shrink_caches+80/128] [try_to_free_pages+44/80] [kswapd_balance_pgdat+81/160] [kswapd_balance+38/64] [kswapd+161/192] 
Dec  2 16:33:59 saimiri kernel: Call Trace: [<c0128820>] [<c012887c>] [<c0128921>] [<c0128996>] [<c0128ad1>] 
Dec  2 16:33:59 saimiri kernel:    [<c0128a30>] [<c0105000>] [<c0105746>] [<c0128a30>] 
Dec  2 16:33:59 saimiri kernel: Code: 0f 0b 8b 41 fc a9 80 00 00 00 74 02 0f 0b 8b 01 8b 51 04 31 

>>EIP; c01284ae <shrink_cache+8e/2d0>   <=====
Trace; c0128820 <shrink_caches+50/80>
Trace; c012887c <try_to_free_pages+2c/50>
Trace; c0128920 <kswapd_balance_pgdat+50/a0>
Trace; c0128996 <kswapd_balance+26/40>
Trace; c0128ad0 <kswapd+a0/c0>
Trace; c0128a30 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105746 <kernel_thread+26/30>
Trace; c0128a30 <kswapd+0/c0>
Code;  c01284ae <shrink_cache+8e/2d0>
00000000 <_EIP>:
Code;  c01284ae <shrink_cache+8e/2d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01284b0 <shrink_cache+90/2d0>
   2:   8b 41 fc                  mov    0xfffffffc(%ecx),%eax
Code;  c01284b2 <shrink_cache+92/2d0>
   5:   a9 80 00 00 00            test   $0x80,%eax
Code;  c01284b8 <shrink_cache+98/2d0>
   a:   74 02                     je     e <_EIP+0xe> c01284bc <shrink_cache+9c/2d0>
Code;  c01284ba <shrink_cache+9a/2d0>
   c:   0f 0b                     ud2a   
Code;  c01284bc <shrink_cache+9c/2d0>
   e:   8b 01                     mov    (%ecx),%eax
Code;  c01284be <shrink_cache+9e/2d0>
  10:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c01284c0 <shrink_cache+a0/2d0>
  13:   31 00                     xor    %eax,(%eax)

--=_6TrnltStXW4iwm--
