Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262101AbSJEHnZ>; Sat, 5 Oct 2002 03:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbSJEHnZ>; Sat, 5 Oct 2002 03:43:25 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:1223 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262101AbSJEHnX> convert rfc822-to-8bit; Sat, 5 Oct 2002 03:43:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.20-pre8-aa2 oops report.
Date: Sat, 5 Oct 2002 17:55:01 +1000
User-Agent: KMail/1.4.3
References: <200210051247.14368.harisri@bigpond.com> <200210051309.45092.harisri@bigpond.com>
In-Reply-To: <200210051309.45092.harisri@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210051755.01256.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 October 2002 13:09, Srihari Vijayaraghavan wrote:
> On Saturday 05 October 2002 12:47, Srihari Vijayaraghavan wrote:
> > [1.] One line summary of the problem:
> > 	2.4.20-pre8aa2 Kernel oopsed couple of times.

I was able to produce couple of more oops.

ksymoops 2.4.5 on i686 2.4.20-pre8aa2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre8aa2/ (default)
     -m /boot/System.map-2.4.20-pre8aa2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

ac97_codec: AC97 Audio codec, id: v9(SigmaTel STAC9721/23)
Unable to handle kernel paging request at virtual address c5db0034
c0114517
*pde = 05c001e3
Oops: 0000 2.4.20-pre8aa2 #3 Thu Oct 3 21:07:54 EST 2002
CPU:    0
EIP:    0010:[<c0114517>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013086
eax: 00000000   ebx: c665b324   ecx: c5db0000   edx: c665b324
esi: c665b31c   edi: c01e6ae2   ebp: 00003246   esp: c73b1d90
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1012, stackpage=c73b1000)
Stack: c73b0000 00000002 c66fc000 c73b0000 c0113e82 c01e6ae2 c73b1dfc c73b1f6c 
       c3e27f8e c73b0000 00000000 c17e17c0 c016e94f c3e0cf80 d90e1390 0001ff9d 
       c02102ef 00000000 dffcb5f4 da33f340 dffcb580 c3e0cf80 c016f2d4 d90e1390 
Call Trace:    [<c0113e82>] [<c01e6ae2>] [<c016e94f>] [<c016f2d4>] 
[<c016811f>]
  [<c0113c60>] [<c0108ff0>] [<c01e6ae2>] [<c0127d19>] [<c012860f>] 
[<c0113e0a>]
  [<c0128e88>] [<c013b2cc>] [<c0129e9f>] [<c012a1d2>] [<c012a254>] 
[<c0113c60>]
  [<c0108ff0>]
Code: 8b 51 34 85 d2 74 3f f7 41 14 41 00 00 00 74 36 8b 71 38 89 


>>EIP; c0114517 <search_exception_table+17/80>   <=====

>>ebx; c665b324 <[emu10k1].data.end+88bb25/8a4881>
>>ecx; c5db0000 <[soundcore].bss.end+39889d/3a891d>
>>edx; c665b324 <[emu10k1].data.end+88bb25/8a4881>
>>esi; c665b31c <[emu10k1].data.end+88bb1d/8a4881>
>>edi; c01e6ae2 <fast_clear_page+12/50>
>>ebp; 00003246 Before first symbol
>>esp; c73b1d90 <END_OF_CODE+d39f39/????>

Trace; c0113e82 <do_page_fault+222/5a0>
Trace; c01e6ae2 <fast_clear_page+12/50>
Trace; c016e94f <do_get_write_access+27f/500>
Trace; c016f2d4 <journal_dirty_metadata+174/200>
Trace; c016811f <ext3_do_update_inode+16f/3e0>
Trace; c0113c60 <do_page_fault+0/5a0>
Trace; c0108ff0 <error_code+34/3c>
Trace; c01e6ae2 <fast_clear_page+12/50>
Trace; c0127d19 <do_wp_page+1b9/1f0>
Trace; c012860f <handle_mm_fault+11f/160>
Trace; c0113e0a <do_page_fault+1aa/5a0>
Trace; c0128e88 <zap_pmd_range+78/80>
Trace; c013b2cc <fput+cc/120>
Trace; c0129e9f <unmap_fixup+12f/140>
Trace; c012a1d2 <do_munmap+292/2d0>
Trace; c012a254 <sys_munmap+44/80>
Trace; c0113c60 <do_page_fault+0/5a0>
Trace; c0108ff0 <error_code+34/3c>

Code;  c0114517 <search_exception_table+17/80>
00000000 <_EIP>:
Code;  c0114517 <search_exception_table+17/80>   <=====
   0:   8b 51 34                  mov    0x34(%ecx),%edx   <=====
Code;  c011451a <search_exception_table+1a/80>
   3:   85 d2                     test   %edx,%edx
Code;  c011451c <search_exception_table+1c/80>
   5:   74 3f                     je     46 <_EIP+0x46>
Code;  c011451e <search_exception_table+1e/80>
   7:   f7 41 14 41 00 00 00      testl  $0x41,0x14(%ecx)
Code;  c0114525 <search_exception_table+25/80>
   e:   74 36                     je     46 <_EIP+0x46>
Code;  c0114527 <search_exception_table+27/80>
  10:   8b 71 38                  mov    0x38(%ecx),%esi
Code;  c011452a <search_exception_table+2a/80>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

ksymoops 2.4.5 on i686 2.4.20-pre8aa2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre8aa2/ (default)
     -m /boot/System.map-2.4.20-pre8aa2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

ac97_codec: AC97 Audio codec, id: v9(SigmaTel STAC9721/23)
Unable to handle kernel paging request at virtual address c2d68358
c014e0f9
*pde = 0823c163
Oops: 0003 2.4.20-pre8aa2 #3 Thu Oct 3 21:07:54 EST 2002
CPU:    0
EIP:    0010:[<c014e0f9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210282
eax: c70b7f58   ebx: c70b7f40   ecx: c2d68358   edx: c78bae58
esi: c70b7fac   edi: c687801f   ebp: 4f55e46f   esp: c2545ee0
ds: 0018   es: 0018   ss: 0018
Process pam_timestamp_c (pid: 2001, stackpage=c2545000)
Stack: 00200217 c021097c 0001828e c0120b37 c70b7f40 dff200c0 c6878013 0000000c 
       c6878013 c687801f 00000000 c2545f98 c014486b c70b7ec0 c2545f40 c6878013 
       c0144e94 c70b7ec0 c2545f40 00000000 00000008 00000000 c73f0d00 00000000 
Call Trace:    [<c0120b37>] [<c014486b>] [<c0144e94>] [<c0145377>] 
[<c0145609>]
  [<c014204f>] [<c0108eff>]
Code: 89 11 89 40 04 89 43 18 eb cc 89 f0 89 3c 24 83 c0 3c 89 44 


>>EIP; c014e0f9 <d_lookup+d9/110>   <=====

>>eax; c70b7f58 <END_OF_CODE+9cc101/????>
>>ebx; c70b7f40 <END_OF_CODE+9cc0e9/????>
>>ecx; c2d68358 <[serial].bss.end+76be75/182bb9d>
>>edx; c78bae58 <END_OF_CODE+11cf001/????>
>>esi; c70b7fac <END_OF_CODE+9cc155/????>
>>edi; c687801f <END_OF_CODE+18c1c8/????>
>>ebp; 4f55e46f Before first symbol
>>esp; c2545ee0 <[floppy].bss.end+2184a5/24e645>

Trace; c0120b37 <schedule_timeout+67/b0>
Trace; c014486b <cached_lookup+1b/70>
Trace; c0144e94 <link_path_walk+3c4/6f0>
Trace; c0145377 <path_lookup+37/40>
Trace; c0145609 <__user_walk+49/60>
Trace; c014204f <sys_lstat64+1f/80>
Trace; c0108eff <system_call+33/38>

Code;  c014e0f9 <d_lookup+d9/110>
00000000 <_EIP>:
Code;  c014e0f9 <d_lookup+d9/110>   <=====
   0:   89 11                     mov    %edx,(%ecx)   <=====
Code;  c014e0fb <d_lookup+db/110>
   2:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c014e0fe <d_lookup+de/110>
   5:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  c014e101 <d_lookup+e1/110>
   8:   eb cc                     jmp    ffffffd6 <_EIP+0xffffffd6>
Code;  c014e103 <d_lookup+e3/110>
   a:   89 f0                     mov    %esi,%eax
Code;  c014e105 <d_lookup+e5/110>
   c:   89 3c 24                  mov    %edi,(%esp,1)
Code;  c014e108 <d_lookup+e8/110>
   f:   83 c0 3c                  add    $0x3c,%eax
Code;  c014e10b <d_lookup+eb/110>
  12:   89 44 00 00               mov    %eax,0x0(%eax,%eax,1)


1 warning issued.  Results may not be reliable.

Steps to reproduce:
1. Login to XFree86/KDE or GNOME
2. Start some open-source heavy-weight applications (I use Mozilla, Open 
Office Writer and Calc and Impress)
3. Exit all those applications 
4. # mke2fs -j /dev/md0 (or) mke2fs -j /dev/hdc5
5. # mount /dev/md0 /md0
6. # cd /md0
7. # time dd if=/dev/zero of=zero bs=1024 count=1048576 (I have choosen 1 GB 
file because I have 512 MB RAM in the system)
8. # dmesg (to verify if there is an oops)
9. Repeat step 2 and verify if there is an oops
10. Else repeat steps 1 to 9 couple of times

Intrestingly both mainline (2.4.20-pre8) and Red Hat 8 kernel (2.4.18-14) do 
not exhibit this regression (on few attempts).

Please feel free to suggest any ideas to pinpoint the issue if you can. I will 
test the system with ReiserFS and Debian Woody (gcc 2.95.4) later today or 
tomorrow.
-- 
Hari
harisri@bigpond.com

