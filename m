Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbQKNP6S>; Tue, 14 Nov 2000 10:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbQKNP6I>; Tue, 14 Nov 2000 10:58:08 -0500
Received: from 24.68.3.210.on.wave.home.com ([24.68.3.210]:56049 "EHLO
	phlegmish.com") by vger.kernel.org with ESMTP id <S129251AbQKNP6F>;
	Tue, 14 Nov 2000 10:58:05 -0500
From: David Won <phlegm@home.com>
Date: Tue, 14 Nov 2000 10:23:26 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
To: "Arnaud S . Launay" <asl@launay.org>
In-Reply-To: <00111214191100.01043@phlegmish.com> <00111307592400.01166@phlegmish.com> <20001113162205.A30602@profile4u.com>
In-Reply-To: <20001113162205.A30602@profile4u.com>
Subject: Re: Newby help. Tons and tons of Oops
MIME-Version: 1.0
Message-Id: <00111410232600.01553@phlegmish.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran memtest through 15 cycles without finding anything.
I guess that's good.  ;)  I pasted a bunch more Oops below to see if it helps 
any.
Dave

On Monday 13 November 2000 10:22, Arnaud S . Launay wrote:
> Le Mon, Nov 13, 2000 at 07:59:24AM -0500, David Won a écrit:
> > I'm running 2.4.0test11pre3. but the kernel shipped with Redhat 7 doesn't
> > work either. When I was running 2.2.15 and RedHat 6.2 before upgrading it
> > worked great. Never had an oops ever.
> > I ran a memory checker under dos as well and it didn't find anything. Any
> > tips?
>
> Could you please check:
> 1/ if memtest really worked, as I had problems with 2.4 (in fact, it wasn't
> launched, I had to downgrade to 2.3 for having a test) (have you seen a
> scrolling bar of '#' ?) (anyway, i'm sending 2.3 binary privatly)
> 2/ your hardware internal temperature (put your hand into the box)
> 3/ if every cable is correctly plugged in
>
> It looks to me like an hardware failure, not a software one.
>
> 	Arnaud.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/






Nov 14 02:53:44 phlegmish kernel: invalid operand: 0000
Nov 14 02:53:44 phlegmish kernel: CPU:    0
Nov 14 02:53:44 phlegmish kernel: EIP:    0010:[<c012ad99>]
Nov 14 02:53:44 phlegmish kernel: EFLAGS: 00010286
Nov 14 02:53:44 phlegmish kernel: eax: 0000001f   ebx: c11d1e4c   ecx: 
00000000   edx: ffffffffNov 14 02:53:44 phlegmish kernel: esi: c11d1e74   
edi: c0250b38   ebp: 00000000   esp: c1237f7cNov 14 02:53:44 phlegmish 
kernel: ds: 0018   es: 0018   ss: 0018
Nov 14 02:53:44 phlegmish kernel: Process kflushd (pid: 4, stackpage=c1237000)
Nov 14 02:53:44 phlegmish kernel: Stack: c020a345 c020a513 00000054 c11d1e4c 
c11d1e74 c0250b38 00000000 c0250b38 
Nov 14 02:53:44 phlegmish kernel:        00000000 c7c1fc20 00000003 c0129e2f 
c012b6f7 c012a009 00000000 c1236000 
Nov 14 02:53:44 phlegmish kernel:        00000000 0008e000 00000013 00000000 
00000000 00000c28 00000000 c013277f 
Nov 14 02:53:44 phlegmish kernel: Call Trace: [<c020a345>] [<c020a513>] 
[<c0129e2f>] [<c012b6f7>] [<c012a009>] [<c013277f>] [<c0108aef>] 
Nov 14 02:53:44 phlegmish kernel: Code: 0f 0b 83 c4 0c 89 f6 89 d8 2b 05 58 
21 2b c0 69 c0 f1 f0 f0 

>>EIP; c012ad99 <__free_pages_ok+49/338>   <=====
Trace; c020a345 <tvecs+1cdd/11498>
Trace; c020a513 <tvecs+1eab/11498>
Trace; c0129e2f <page_launder+28b/728>
Trace; c012b6f7 <__free_pages+13/14>
Trace; c012a009 <page_launder+465/728>
Trace; c013277f <bdflush+8f/114>
Trace; c0108aef <kernel_thread+23/30>
Code;  c012ad99 <__free_pages_ok+49/338>
00000000 <_EIP>:
Code;  c012ad99 <__free_pages_ok+49/338>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012ad9b <__free_pages_ok+4b/338>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012ad9e <__free_pages_ok+4e/338>
   5:   89 f6                     mov    %esi,%esi
Code;  c012ada0 <__free_pages_ok+50/338>
   7:   89 d8                     mov    %ebx,%eax
Code;  c012ada2 <__free_pages_ok+52/338>
   9:   2b 05 58 21 2b c0         sub    0xc02b2158,%eax
Code;  c012ada8 <__free_pages_ok+58/338>
   f:   69 c0 f1 f0 f0 00         imul   $0xf0f0f1,%eax,%eax

Nov 14 02:53:58 phlegmish kernel: invalid operand: 0000
Nov 14 02:53:58 phlegmish kernel: CPU:    0
Nov 14 02:53:58 phlegmish kernel: EIP:    0010:[<c0129b4d>]
Nov 14 02:53:58 phlegmish kernel: EFLAGS: 00013292
Nov 14 02:53:58 phlegmish kernel: eax: 0000001c   ebx: c11d1e68   ecx: 
00000000   edx: 00000002Nov 14 02:53:58 phlegmish kernel: esi: c11d1e4c   
edi: c583eb7c   ebp: c0250b18   esp: c4c75df8Nov 14 02:53:58 phlegmish 
kernel: ds: 0018   es: 0018   ss: 0018
Nov 14 02:53:58 phlegmish kernel: Process X (pid: 715, stackpage=c4c75000)
Nov 14 02:53:58 phlegmish kernel: Stack: c0209da5 c0209f64 00000215 c0250b18 
c0250cf0 00000002 00000000 c583eb7c 
Nov 14 02:53:58 phlegmish kernel:        c0250b38 00000211 c012b362 c0250b18 
00000000 c0250cf8 c0250cec c4f4c6a0 
Nov 14 02:53:58 phlegmish kernel:        000000e6 c012b4d4 c0250cec 00000000 
00000002 00000001 00000000 c4f4c6a0 
Nov 14 02:53:58 phlegmish kernel: Call Trace: [<c0209da5>] [<c0209f64>] 
[<c012b362>] [<c012b4d4>] [<c015fa1d>] [<c015fc32>] [<c012153d>] 
Nov 14 02:53:58 phlegmish kernel:        [<c0121690>] [<c0112004>] 
[<c011214f>] [<c0112004>] [<c8820134>] [<c881e262>] [<c011c208>] [<c011c10e>] 
Nov 14 02:53:58 phlegmish kernel:        [<c010b738>] [<c010a554>] 
Nov 14 02:53:58 phlegmish kernel: Code: 0f 0b 83 c4 0c 31 c0 0f b3 46 18 8d 
5e 28 8d 46 2c 39 46 2c 

>>EIP; c0129b4d <reclaim_page+355/3ac>   <=====
Trace; c0209da5 <tvecs+173d/11498>
Trace; c0209f64 <tvecs+18fc/11498>
Trace; c012b362 <__alloc_pages_limit+82/b8>
Trace; c012b4d4 <__alloc_pages+13c/2f8>
Trace; c015fa1d <shm_nopage_core+59/1dc>
Trace; c015fc32 <shm_nopage+92/a4>
Trace; c012153d <do_no_page+59/c4>
Trace; c0121690 <handle_mm_fault+e8/164>
Trace; c0112004 <do_page_fault+0/40c>
Trace; c011214f <do_page_fault+14b/40c>
Trace; c0112004 <do_page_fault+0/40c>
Trace; c8820134 <[emu10k1]emu10k1_waveout_fillsilence+a4/b0>
Trace; c881e262 <[emu10k1]emu10k1_waveout_bh+62/70>
Trace; c011c208 <tasklet_hi_action+3c/60>
Trace; c011c10e <do_softirq+4e/74>
Trace; c010b738 <do_IRQ+9c/ac>
Trace; c010a554 <error_code+34/3c>
Code;  c0129b4d <reclaim_page+355/3ac>
00000000 <_EIP>:
Code;  c0129b4d <reclaim_page+355/3ac>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129b4f <reclaim_page+357/3ac>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0129b52 <reclaim_page+35a/3ac>
   5:   31 c0                     xor    %eax,%eax
Code;  c0129b54 <reclaim_page+35c/3ac>
   7:   0f b3 46 18               btr    %eax,0x18(%esi)
Code;  c0129b58 <reclaim_page+360/3ac>
   b:   8d 5e 28                  lea    0x28(%esi),%ebx
Code;  c0129b5b <reclaim_page+363/3ac>
   e:   8d 46 2c                  lea    0x2c(%esi),%eax
Code;  c0129b5e <reclaim_page+366/3ac>
  11:   39 46 2c                  cmp    %eax,0x2c(%esi)

Nov 14 03:17:38 phlegmish kernel: Unable to handle kernel paging request at 
virtual address ff7f1014
Nov 14 03:17:38 phlegmish kernel: c012e896
Nov 14 03:17:38 phlegmish kernel: *pde = 00000000
Nov 14 03:17:38 phlegmish kernel: Oops: 0000
Nov 14 03:17:38 phlegmish kernel: CPU:    0
Nov 14 03:17:38 phlegmish kernel: EIP:    0010:[<c012e896>]
Nov 14 03:17:38 phlegmish kernel: EFLAGS: 00210286
Nov 14 03:17:38 phlegmish kernel: eax: ff7f1000   ebx: ff7f1000   ecx: 
ff7f1000   edx: 00000400Nov 14 03:17:38 phlegmish kernel: esi: 00000000   
edi: c28a5dc0   ebp: 00000001   esp: c191df80Nov 14 03:17:38 phlegmish 
kernel: ds: 0018   es: 0018   ss: 0018
Nov 14 03:17:38 phlegmish kernel: Process netscape (pid: 820, 
stackpage=c191d000)
Nov 14 03:17:38 phlegmish kernel: Stack: 00000007 00000000 c011aa1a ff7f1000 
c28a5dc0 c09c7dc0 c191c000 00000000 
Nov 14 03:17:38 phlegmish kernel:        bffff8a0 c011b01a c28a5dc0 c191c000 
401488ec 00000000 c011b162 00000000 
Nov 14 03:17:38 phlegmish kernel:        c010a437 00000000 ffffffff 40149740 
401488ec 00000000 bffff8a0 00000001 
Nov 14 03:17:38 phlegmish kernel: Call Trace: [<c011aa1a>] [<ff7f1000>] 
[<c011b01a>] [<c011b162>] [<c010a437>] 
Nov 14 03:17:38 phlegmish kernel: Code: 8b 43 14 85 c0 75 13 68 a2 b4 20 c0 
e8 35 9f fe ff 31 c0 83 

>>EIP; c012e896 <filp_close+6/64>   <=====
Trace; c011aa1a <put_files_struct+42/b0>
Trace; ff7f1000 <END_OF_CODE+36f8724c/???
Trace; c011b01a <do_exit+c2/1fc>
Trace; c011b162 <sys_exit+e/10>
Trace; c010a437 <system_call+33/38>
Code;  c012e896 <filp_close+6/64>
00000000 <_EIP>:
Code;  c012e896 <filp_close+6/64>   <=====
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c012e899 <filp_close+9/64>
   3:   85 c0                     test   %eax,%eax
Code;  c012e89b <filp_close+b/64>
   5:   75 13                     jne    1a <_EIP+0x1a> c012e8b0 
<filp_close+20/64>
Code;  c012e89d <filp_close+d/64>
   7:   68 a2 b4 20 c0            push   $0xc020b4a2
Code;  c012e8a2 <filp_close+12/64>
   c:   e8 35 9f fe ff            call   fffe9f46 <_EIP+0xfffe9f46> c01187dc 
<printk+0/19c>
Code;  c012e8a7 <filp_close+17/64>
  11:   31 c0                     xor    %eax,%eax
Code;  c012e8a9 <filp_close+19/64>
  13:   83 00 00                  addl   $0x0,(%eax)

Nov 14 04:02:35 phlegmish kernel: Unable to handle kernel paging request at 
virtual address 0001fff4
Nov 14 04:02:35 phlegmish kernel: c01390eb
Nov 14 04:02:35 phlegmish kernel: *pde = 00000000
Nov 14 04:02:35 phlegmish kernel: Oops: 0000
Nov 14 04:02:35 phlegmish kernel: CPU:    0
Nov 14 04:02:35 phlegmish kernel: EIP:    0010:[<c01390eb>]
Nov 14 04:02:35 phlegmish kernel: EFLAGS: 00010213
Nov 14 04:02:35 phlegmish kernel: eax: c74deae0   ebx: 0001ffec   ecx: 
00000000   edx: 00020000Nov 14 04:02:35 phlegmish kernel: esi: c7d2700a   
edi: c5125f64   ebp: c5125fa8   esp: c5125f44Nov 14 04:02:35 phlegmish 
kernel: ds: 0018   es: 0018   ss: 0018
Nov 14 04:02:35 phlegmish kernel: Process updatedb (pid: 1042, 
stackpage=c5125000)
Nov 14 04:02:35 phlegmish kernel: Stack: c73a6000 00000000 c5125fa4 bffffb60 
c5124000 c01386db c5124000 00000008 
Nov 14 04:02:36 phlegmish kernel:        c7d2700a c73a6000 00000004 00075e25 
c01396a0 c73a6000 c5125fa4 c5124000 
Nov 14 04:02:36 phlegmish kernel:        c5125fa4 ffffffff c01366e6 08053664 
00000008 c5125fa4 c5124000 08052298 
Nov 14 04:02:36 phlegmish kernel: Call Trace: [<c01386db>] [<c01396a0>] 
[<c01366e6>] [<c010a437>] 
Nov 14 04:02:36 phlegmish kernel: Code: 39 42 f4 75 68 85 db 74 03 ff 42 1c 
89 5d 00 8b 52 f4 85 d2 

>>EIP; c01390eb <path_walk+5f7/80c>   <=====
Trace; c01386db <getname+5b/a0>
Trace; c01396a0 <__user_walk+3c/58>
Trace; c01366e6 <sys_lstat64+16/70>
Trace; c010a437 <system_call+33/38>
Code;  c01390eb <path_walk+5f7/80c>
00000000 <_EIP>:
Code;  c01390eb <path_walk+5f7/80c>   <=====
   0:   39 42 f4                  cmp    %eax,0xfffffff4(%edx)   <=====
Code;  c01390ee <path_walk+5fa/80c>
   3:   75 68                     jne    6d <_EIP+0x6d> c0139158 
<path_walk+664/80c>
Code;  c01390f0 <path_walk+5fc/80c>
   5:   85 db                     test   %ebx,%ebx
Code;  c01390f2 <path_walk+5fe/80c>
   7:   74 03                     je     c <_EIP+0xc> c01390f7 
<path_walk+603/80c>
Code;  c01390f4 <path_walk+600/80c>
   9:   ff 42 1c                  incl   0x1c(%edx)
Code;  c01390f7 <path_walk+603/80c>
   c:   89 5d 00                  mov    %ebx,0x0(%ebp)
Code;  c01390fa <path_walk+606/80c>
   f:   8b 52 f4                  mov    0xfffffff4(%edx),%edx
Code;  c01390fd <path_walk+609/80c>
  12:   85 d2                     test   %edx,%edx


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
