Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129204AbQJZSnH>; Thu, 26 Oct 2000 14:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQJZSm5>; Thu, 26 Oct 2000 14:42:57 -0400
Received: from proxy2.ba.best.com ([206.184.139.14]:35852 "EHLO
	proxy2.ba.best.com") by vger.kernel.org with ESMTP
	id <S129204AbQJZSmx>; Thu, 26 Oct 2000 14:42:53 -0400
Message-ID: <39F8799D.784832FA@best.com>
Date: Thu, 26 Oct 2000 11:36:13 -0700
From: Robert Lynch <rmlynch@best.com>
Reply-To: rmlynch@best.com
Organization: Carpe per diem
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops while running test10-pre5
In-Reply-To: <Pine.LNX.3.96.1001026134947.18810C-100000@kanga.kvack.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel@kvack.org wrote:
> 
> On Thu, 26 Oct 2000, Robert Lynch wrote:
> 
> > Oct 19 13:00:23 ives kernel: EIP:    0010:[try_to_swap_out+252/796]
> 
> Those Oopsen look like they're from test10-pre4 (fixed in pre5).  Also,
> please include the lines beginning with "kernel BUG at...".
> 
>                 -ben

OOPS! That's entirely correct, I previously reported this older oops 
also.  When reporting the newer one, I inadvertantly copied the wrong
oops file. BOTH of the oops I mentioned are reported below my .sig.

Sorry, Bob L.
-- 
Robert Lynch-Berkeley CA USA-rmlynch@best.com
--
test10-pre4 oops (OLD; for the record, sent as requested)
---
Oct 19 13:00:23 ives kernel: kernel BUG at vmscan.c:102!
Oct 19 13:00:23 ives kernel: invalid operand: 0000
Oct 19 13:00:23 ives kernel: CPU:    0
Oct 19 13:00:23 ives kernel: EIP:   
0010:[try_to_swap_out+252/796]
Oct 19 13:00:23 ives kernel: EFLAGS: 00010286
Oct 19 13:00:23 ives kernel: eax: 0000001c   ebx: 00000200   ecx:
00000000   edx: 00000000
Oct 19 13:00:23 ives kernel: esi: c11c8590   edi: 00000001   ebp:
06b60045   esp: c1273ebc
Oct 19 13:00:23 ives kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 13:00:23 ives kernel: Process kswapd (pid: 3,
stackpage=c1273000)
Oct 19 13:00:23 ives kernel: Stack: c01d07ea c01d09a9 00000066
40279000 c7e3dda0 4027a000 40278000 c01836e7 
Oct 19 13:00:23 ives kernel:        c012968e c7e3dda0 c6b9bd60
40278000 c6cad9e0 00000004 40278000 c6b9bd60 
Oct 19 13:00:23 ives kernel:        c7e3dda0 00000004 c6cad9e0
40678000 c6ca3400 4027a000 4027a000 c6ca3400 
Oct 19 13:00:23 ives kernel: Call Trace: [tvecs+6622/60500]
[tvecs+7069/60500] [ide_end_request+111/120]
[swap_out_vma+322/440] [swap_out_mm+56/100] [swap_out+283/368]
[refill_inactive+213/376] 
Oct 19 13:00:23 ives kernel:        [do_try_to_free_pages+98/128]
[tvecs+7429/60500] [kswapd+139/348] [empty_bad_page+0/4096]
[kernel_thread+35/48] 
Oct 19 13:00:23 ives kernel: Code: 0f 0b 83 c4 0c f7 c5 02 00 00
00 74 17 6a 68 68 a9 09 1d c0 
Oct 19 13:00:35 ives kernel: kernel BUG at vmscan.c:102!
Oct 19 13:00:35 ives kernel: invalid operand: 0000
Oct 19 13:00:35 ives kernel: CPU:    0
Oct 19 13:00:35 ives kernel: EIP:   
0010:[try_to_swap_out+252/796]
Oct 19 13:00:35 ives kernel: EFLAGS: 00013282
Oct 19 13:00:35 ives kernel: eax: 0000001c   ebx: 00000500   ecx:
c6c813c0   edx: 00000001
Oct 19 13:00:35 ives kernel: esi: c118bc90   edi: 00000001   ebp:
05d20045   esp: c6afbc20
Oct 19 13:00:35 ives kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 13:00:35 ives kernel: Process squid (pid: 829,
stackpage=c6afb000)
Oct 19 13:00:35 ives kernel: Stack: c01d07ea c01d09a9 00000066
40199000 c6c81be0 4019d000 40197000 00000000 
Oct 19 13:00:35 ives kernel:        c012968e c6c81be0 c521cb60
40198000 c4a13660 00000003 40197000 c521cb60 
Oct 19 13:00:35 ives kernel:        c6c81be0 00000003 c4a13660
40597000 c4977400 4019d000 4019d000 c4977400 
Oct 19 13:00:35 ives kernel: Call Trace: [tvecs+6622/60500]
[tvecs+7069/60500] [swap_out_vma+322/440] [swap_out_mm+56/100]
[swap_out+283/368] [refill_inactive+213/376]
[do_try_to_free_pages+98/128] 
Oct 19 13:00:35 ives kernel:        [try_to_free_pages+34/44]
[__alloc_pages+566/712] [grow_buffers+59/284]
[refill_freelist+10/44] [getblk+274/292] [ext2_getblk+92/192]
[__wait_on_buffer+178/192] [ext2_find_entry+176/960] 
Oct 19 13:00:35 ives kernel:        [iget4+198/212]
[ext2_lookup+48/136] [real_lookup+79/192] [path_walk+1459/2060]
[open_namei+147/1484] [filp_open+59/92] [sys_open+56/180]
[system_call+51/56] 
Oct 19 13:00:35 ives kernel:        [stext+43/314] 
Oct 19 13:00:35 ives kernel: Code: 0f 0b 83 c4 0c f7 c5 02 00 00
00 74 17 6a 68 68 a9 09 1d c0 
------
ksymoops 2.3.4 on i686 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (specified)
     -m /usr/src/linux/System.map (default)

Error (regular_file): read_system_map stat
/usr/src/linux/System.map failed
Oct 19 13:00:23 ives kernel: invalid operand: 0000
Oct 19 13:00:23 ives kernel: CPU:    0
Oct 19 13:00:23 ives kernel: EIP:   
0010:[try_to_swap_out+252/796]
Oct 19 13:00:23 ives kernel: EFLAGS: 00010286
Oct 19 13:00:23 ives kernel: eax: 0000001c   ebx: 00000200   ecx:
00000000   edx: 00000000
Oct 19 13:00:23 ives kernel: esi: c11c8590   edi: 00000001   ebp:
06b60045   esp: c1273ebc
Oct 19 13:00:23 ives kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 13:00:23 ives kernel: Process kswapd (pid: 3,
stackpage=c1273000)
Oct 19 13:00:23 ives kernel: Stack: c01d07ea c01d09a9 00000066
40279000 c7e3dda0 4027a000 40278000 c01836e7 
Oct 19 13:00:23 ives kernel:        c012968e c7e3dda0 c6b9bd60
40278000 c6cad9e0 00000004 40278000 c6b9bd60 
Oct 19 13:00:23 ives kernel:        c7e3dda0 00000004 c6cad9e0
40678000 c6ca3400 4027a000 4027a000 c6ca3400 
Oct 19 13:00:23 ives kernel: Call Trace: [tvecs+6622/60500]
[tvecs+7069/60500] [ide_end_request+111/120]
[swap_out_vma+322/440] [swap_out_mm+56/100] [swap_out+283/368]
[refill_inactive+213/376] 
Oct 19 13:00:23 ives kernel: Code: 0f 0b 83 c4 0c f7 c5 02 00 00
00 74 17 6a 68 68 a9 09 1d c0 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   f7 c5 02 00 00 00         test   $0x2,%ebp
Code;  0000000b Before first symbol
   b:   74 17                     je     24 <_EIP+0x24> 00000024
Before first symbol
Code;  0000000d Before first symbol
   d:   6a 68                     push   $0x68
Code;  0000000f Before first symbol
   f:   68 a9 09 1d c0            push   $0xc01d09a9

Oct 19 13:00:35 ives kernel: invalid operand: 0000
Oct 19 13:00:35 ives kernel: CPU:    0
Oct 19 13:00:35 ives kernel: EIP:   
0010:[try_to_swap_out+252/796]
Oct 19 13:00:35 ives kernel: EFLAGS: 00013282
Oct 19 13:00:35 ives kernel: eax: 0000001c   ebx: 00000500   ecx:
c6c813c0   edx: 00000001
Oct 19 13:00:35 ives kernel: esi: c118bc90   edi: 00000001   ebp:
05d20045   esp: c6afbc20
Oct 19 13:00:35 ives kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 13:00:35 ives kernel: Process squid (pid: 829,
stackpage=c6afb000)
Oct 19 13:00:35 ives kernel: Stack: c01d07ea c01d09a9 00000066
40199000 c6c81be0 4019d000 40197000 00000000 
Oct 19 13:00:35 ives kernel:        c012968e c6c81be0 c521cb60
40198000 c4a13660 00000003 40197000 c521cb60 
Oct 19 13:00:35 ives kernel:        c6c81be0 00000003 c4a13660
40597000 c4977400 4019d000 4019d000 c4977400 
Oct 19 13:00:35 ives kernel: Call Trace: [tvecs+6622/60500]
[tvecs+7069/60500] [swap_out_vma+322/440] [swap_out_mm+56/100]
[swap_out+283/368] [refill_inactive+213/376]
[do_try_to_free_pages+98/128] 
Oct 19 13:00:35 ives kernel: Code: 0f 0b 83 c4 0c f7 c5 02 00 00
00 74 17 6a 68 68 a9 09 1d c0 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   f7 c5 02 00 00 00         test   $0x2,%ebp
Code;  0000000b Before first symbol
   b:   74 17                     je     24 <_EIP+0x24> 00000024
Before first symbol
Code;  0000000d Before first symbol
   d:   6a 68                     push   $0x68
Code;  0000000f Before first symbol
   f:   68 a9 09 1d c0            push   $0xc01d09a9


1 error issued.  Results may not be reliable.
--------------------
test10-pre5 oops:
--
ksymoops 2.3.4 on i686 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /boot/System.map (specified)

Oct 25 15:37:38 ives kernel: Oops: 0000
Oct 25 15:37:38 ives kernel: CPU:    0
Oct 25 15:37:38 ives kernel: EIP:   
0010:[block_read_full_page+18/612]
Oct 25 15:37:38 ives kernel: EFLAGS: 00010286
Oct 25 15:37:38 ives kernel: eax: 00000000   ebx: c1205468   ecx:
c73dcb40   edx: c1205494
Oct 25 15:37:38 ives kernel: esi: c1205468   edi: 00000001   ebp:
c5bed71c   esp: c7cd3ec8
Oct 25 15:37:38 ives kernel: ds: 0018   es: 0018   ss: 0018
Oct 25 15:37:38 ives kernel: Process bash (pid: 1482,
stackpage=c7cd3000)
Oct 25 15:37:38 ives kernel: Stack: 00000000 c1205468 00000001
c5bed71c 00000000 c0210000 00000000 00000000 
Oct 25 15:37:38 ives kernel:        c7cd2000 fffffc18 00000000
c5d62000 c0242540 00000246 c0123851 00000000 
Oct 25 15:37:38 ives kernel:        c1205468 00000001 c5bed71c
080f4b54 c1205490 01234567 c7cd2000 c1205494 
Oct 25 15:37:38 ives kernel: Call Trace:
[___wait_on_page+213/224] [ext2_readpage+15/20]
[ext2_get_block+0/1300] [do_generic_file_read+766/1312]
[generic_file_read+99/128] [file_read_actor+0/84]
[sys_read+142/196] 
Oct 25 15:37:38 ives kernel: Code: 8b 48 10 89 4c 24 40 c7 44 24
34 00 00 00 00 8b 5b 18 f6 c3 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 48 10                  mov    0x10(%eax),%ecx
Code;  00000003 Before first symbol
   3:   89 4c 24 40               mov    %ecx,0x40(%esp,1)
Code;  00000007 Before first symbol
   7:   c7 44 24 34 00 00 00      movl   $0x0,0x34(%esp,1)
Code;  0000000e Before first symbol
   e:   00 
Code;  0000000f Before first symbol
   f:   8b 5b 18                  mov    0x18(%ebx),%ebx
Code;  00000012 Before first symbol
  12:   f6 c3 00                  test   $0x0,%bl
--------- END of file/two oops ---------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
