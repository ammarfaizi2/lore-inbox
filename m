Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261548AbREOV2I>; Tue, 15 May 2001 17:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbREOV16>; Tue, 15 May 2001 17:27:58 -0400
Received: from 29-ZARA-X34.libre.retevision.es ([62.82.233.29]:24847 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S261548AbREOV1t>;
	Tue, 15 May 2001 17:27:49 -0400
Message-ID: <3B0164AC.1030100@zaralinux.com>
Date: Tue, 15 May 2001 19:17:32 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac9 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Jorge Nerin <comandante@zaralinux.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unable to handle kernel paging request (2.4.4-ac6)
In-Reply-To: <3B006909.7070705@zaralinux.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.Jorge Nerin wrote:

> Hello, today I got an Oops in 2.4.4-ac6, X crashed and gdm restarted, 
> my system is a dual 2x200MMX, 96Mb, Voodoo 3 2000pci XFree 4.0.3, no drm.
>
In reply to myself I must add this series of Oopses and invalid operands 
to my mail, also on 2.4.4.-ac6.

The system was runing at the time I did the trace, so all symbols should 
be ok.

ksymoops 2.3.4 on i586 2.4.4-ac6.  Options used
    -V (default)
    -k /proc/ksyms (default)
    -l /proc/modules (default)
    -o /lib/modules/2.4.4-ac6/ (default)
    -m /boot/System.map-2.4.4-ac6 (specified)

cpu: 0, clocks: 668184, slice: 222728
cpu: 1, clocks: 668184, slice: 222728
8139too Fast Ethernet driver 0.9.17
Unable to handle kernel NULL pointer dereference at virtual address 00000157
c0144b69
Oops: 0000
CPU:    0
EIP:    0010:[<c0144b69>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c24b7f54   ebx: 00000143   ecx: c24b7f54   edx: c5997884
esi: c57df000   edi: c57df008   ebp: 00000000   esp: c24b7f28
ds: 0018   es: 0018   ss: 0018
Process enlightenment (pid: 1091, stackpage=c24b7000)
Stack: 00000000 00000000 00000005 c0144f2d c24b7f54 c24b7f54 00000304 
c24b6000
      00000000 00000005 00000000 00000000 c57df000 00000001 bfffe684 
c5997898
      00000005 c01452b9 00000005 c24b7f90 c24b7f8c bfffdd88 c0194780 
00000004
Call Trace: [<c0144f2d>] [<c01452b9>] [<c0194780>] [<c01444ba>] 
[<c0106e57>]
Code: 8b 43 14 8d 53 04 e8 2c f8 fc ff 8b 03 e8 c5 11 ff ff 39 fb

 >>EIP; c0144b69 <poll_freewait+19/50>   <=====
Trace; c0144f2d <do_select+22d/250>
Trace; c01452b9 <sys_select+339/490>
Trace; c0194780 <sock_ioctl+50/80>
Trace; c01444ba <sys_ioctl+28a/2a0>
Trace; c0106e57 <system_call+37/40>
Code;  c0144b69 <poll_freewait+19/50>
00000000 <_EIP>:
Code;  c0144b69 <poll_freewait+19/50>   <=====
  0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c0144b6c <poll_freewait+1c/50>
  3:   8d 53 04                  lea    0x4(%ebx),%edx
Code;  c0144b6f <poll_freewait+1f/50>
  6:   e8 2c f8 fc ff            call   fffcf837 <_EIP+0xfffcf837> 
c01143a0 <remove_wait_queue+0/20>
Code;  c0144b74 <poll_freewait+24/50>
  b:   8b 03                     mov    (%ebx),%eax
Code;  c0144b76 <poll_freewait+26/50>
  d:   e8 c5 11 ff ff            call   ffff11d7 <_EIP+0xffff11d7> 
c0135d40 <fput+0/e0>
Code;  c0144b7b <poll_freewait+2b/50>
  12:   39 fb                     cmp    %edi,%ebx


<1>Unable to handle kernel paging request at virtual address 2f323433
c01135e4
Oops: 0000
CPU:    1
EIP:    0010:[<c01135e4>]
EFLAGS: 00210002
eax: c184a208   ebx: 752f002f   ecx: 2f323433   edx: 00000001
esi: c23754a0   edi: c57df024   ebp: c28bdecc   esp: c28bdeac
ds: 0018   es: 0018   ss: 0018
Process gnome-session (pid: 1056, stackpage=c28bd000)
Stack: c184a20c 00000000 00200282 00000001 c184a208 c184a208 c23754a0 
c2375100
      c5f6f940 c0197003 c23754a0 00000001 c01d6ca4 c23754a0 00000001 
c2879ac0
      00000009 c3af5000 c2651260 00200296 c17ecacc c5ffaac0 c17ec9c0 
c1727f20
Call Trace: [<c0197003>] [<c01d6ca4>] [<c01d703f>] [<c01942d0>] 
[<c0194840>]
  [<c0135d77>] [<c0134c2e>] [<c011856d>] [<c0118d7d>] [<c0106e57>]
Code: 8b 01 85 45 ec 74 ec 31 c0 9c 5e fa f0 fe 0d 00 b4 26 c0 0f

 >>EIP; c01135e4 <__wake_up+44/d0>   <=====
Trace; c0197003 <sock_def_wakeup+33/40>
Trace; c01d6ca4 <unix_release_sock+154/280>
Trace; c01d703f <unix_release+1f/30>
Trace; c01942d0 <sock_release+10/60>
Trace; c0194840 <sock_close+30/40>
Trace; c0135d77 <fput+37/e0>
Trace; c0134c2e <filp_close+9e/b0>
Trace; c011856d <put_files_struct+4d/d0>
Trace; c0118d7d <do_exit+12d/290>
Trace; c0106e57 <system_call+37/40>
Code;  c01135e4 <__wake_up+44/d0>
00000000 <_EIP>:
Code;  c01135e4 <__wake_up+44/d0>   <=====
  0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01135e6 <__wake_up+46/d0>
  2:   85 45 ec                  test   %eax,0xffffffec(%ebp)
Code;  c01135e9 <__wake_up+49/d0>
  5:   74 ec                     je     fffffff3 <_EIP+0xfffffff3> 
c01135d7 <__wake_up+37/d0>
Code;  c01135eb <__wake_up+4b/d0>
  7:   31 c0                     xor    %eax,%eax
Code;  c01135ed <__wake_up+4d/d0>
  9:   9c                        pushf 
Code;  c01135ee <__wake_up+4e/d0>
  a:   5e                        pop    %esi
Code;  c01135ef <__wake_up+4f/d0>
  b:   fa                        cli   
Code;  c01135f0 <__wake_up+50/d0>
  c:   f0 fe 0d 00 b4 26 c0      lock decb 0xc026b400
Code;  c01135f7 <__wake_up+57/d0>
  13:   0f 00 00                  sldt   (%eax)


invalid operand: 0000
CPU:    1
EIP:    0010:[<c012f35b>]
EFLAGS: 00013282
eax: 00000020   ebx: c115ce2c   ecx: c021f400   edx: 00003b84
esi: 00005000   edi: c1000010   ebp: 00000000   esp: c3919e2c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 3730, stackpage=c3919000)
Stack: c01f0cba 000000cb 00004217 00003282 00000000 c02207f8 c02207f8 
c02209d0
      00000000 00000005 c012f49e 00000001 c02209cc 00000025 c301dc20 
c5dda8c0
      c37b9e7c c01248c1 c301dc20 c5dda8c0 00000001 c37b9e7c c0124970 
c5dda8c0
Call Trace: [<c012f49e>] [<c01248c1>] [<c0124970>] [<c0124a99>] 
[<c012784f>]
  [<c0112370>] [<c0112517>] [<c01259d4>] [<c018868b>] [<c011dc46>] 
[<c0125ce4>]
  [<c0124e1d>] [<c0112370>] [<c0106fb4>]
Code: 0f 0b 5f 5d 89 d8 eb 1b 47 83 c6 0c 83 ff 09 0f 86 a0 fd ff

 >>EIP; c012f35b <rmqueue+27b/2b0>   <=====
Trace; c012f49e <__alloc_pages+6e/260>
Trace; c01248c1 <do_anonymous_page+61/e0>
Trace; c0124970 <do_no_page+30/f0>
Trace; c0124a99 <handle_mm_fault+69/e0>
Trace; c012784f <file_read_actor+2f/60>
Trace; c0112370 <do_page_fault+0/4d0>
Trace; c0112517 <do_page_fault+1a7/4d0>
Trace; c01259d4 <do_munmap+64/270>
Trace; c018868b <cursor_timer_handler+b/30>
Trace; c011dc46 <timer_bh+246/2a0>
Trace; c0125ce4 <do_brk+b4/170>
Trace; c0124e1d <sys_brk+ad/e0>
Trace; c0112370 <do_page_fault+0/4d0>
Trace; c0106fb4 <error_code+34/40>
Code;  c012f35b <rmqueue+27b/2b0>
00000000 <_EIP>:
Code;  c012f35b <rmqueue+27b/2b0>   <=====
  0:   0f 0b                     ud2a      <=====
Code;  c012f35d <rmqueue+27d/2b0>
  2:   5f                        pop    %edi
Code;  c012f35e <rmqueue+27e/2b0>
  3:   5d                        pop    %ebp
Code;  c012f35f <rmqueue+27f/2b0>
  4:   89 d8                     mov    %ebx,%eax
Code;  c012f361 <rmqueue+281/2b0>
  6:   eb 1b                     jmp    23 <_EIP+0x23> c012f37e 
<rmqueue+29e/2b0>
Code;  c012f363 <rmqueue+283/2b0>
  8:   47                        inc    %edi
Code;  c012f364 <rmqueue+284/2b0>
  9:   83 c6 0c                  add    $0xc,%esi
Code;  c012f367 <rmqueue+287/2b0>
  c:   83 ff 09                  cmp    $0x9,%edi
Code;  c012f36a <rmqueue+28a/2b0>
  f:   0f 86 a0 fd ff 00         jbe    fffdb5 <_EIP+0xfffdb5> c112f110 
<_end+e6a720/855d670>

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f35b>]
EFLAGS: 00013286
eax: 00000020   ebx: c115b710   ecx: c021f400   edx: 00003ee7
esi: 00005000   edi: c1000010   ebp: 00000000   esp: c3919dd8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 3732, stackpage=c3919000)
Stack: c01f0cba 000000cb 000041c0 00003282 00000000 c02207f8 c02207f8 
c02209d0
      00000000 00000005 c012f49e 00000001 c02209cc 00000000 00000000 
00000000
      c134c064 c0132075 c2837ea8 c0634480 c0156b60 c0634480 00000002 
00000029
Call Trace: [<c012f49e>] [<c0132075>] [<c0156b60>] [<c013220f>] 
[<c01322cc>]
  [<c0124997>] [<c0124a99>] [<c012344d>] [<c0112370>] [<c0112517>] 
[<c01257dd>]
  [<c014866c>] [<c0125bca>] [<c0135db9>] [<c0134c2e>] [<c0112370>] 
[<c0106fb4>]
Code: 0f 0b 5f 5d 89 d8 eb 1b 47 83 c6 0c 83 ff 09 0f 86 a0 fd ff

 >>EIP; c012f35b <rmqueue+27b/2b0>   <=====
Trace; c012f49e <__alloc_pages+6e/260>
Trace; c0132075 <shmem_getpage_locked+2a5/340>
Trace; c0156b60 <ext2_getblk+40/120>
Trace; c013220f <shmem_getpage+ff/190>
Trace; c01322cc <shmem_nopage+2c/90>
Trace; c0124997 <do_no_page+57/f0>
Trace; c0124a99 <handle_mm_fault+69/e0>
Trace; c012344d <zap_page_range+46d/580>
Trace; c0112370 <do_page_fault+0/4d0>
Trace; c0112517 <do_page_fault+1a7/4d0>
Trace; c01257dd <unmap_fixup+6d/170>
Trace; c014866c <dput+1c/160>
Trace; c0125bca <do_munmap+25a/270>
Trace; c0135db9 <fput+79/e0>
Trace; c0134c2e <filp_close+9e/b0>
Trace; c0112370 <do_page_fault+0/4d0>
Trace; c0106fb4 <error_code+34/40>
Code;  c012f35b <rmqueue+27b/2b0>
00000000 <_EIP>:
Code;  c012f35b <rmqueue+27b/2b0>   <=====
  0:   0f 0b                     ud2a      <=====
Code;  c012f35d <rmqueue+27d/2b0>
  2:   5f                        pop    %edi
Code;  c012f35e <rmqueue+27e/2b0>
  3:   5d                        pop    %ebp
Code;  c012f35f <rmqueue+27f/2b0>
  4:   89 d8                     mov    %ebx,%eax
Code;  c012f361 <rmqueue+281/2b0>
  6:   eb 1b                     jmp    23 <_EIP+0x23> c012f37e 
<rmqueue+29e/2b0>
Code;  c012f363 <rmqueue+283/2b0>
  8:   47                        inc    %edi
Code;  c012f364 <rmqueue+284/2b0>
  9:   83 c6 0c                  add    $0xc,%esi
Code;  c012f367 <rmqueue+287/2b0>
  c:   83 ff 09                  cmp    $0x9,%edi
Code;  c012f36a <rmqueue+28a/2b0>
  f:   0f 86 a0 fd ff 00         jbe    fffdb5 <_EIP+0xfffdb5> c112f110 
<_end+e6a720/855d670>


invalid operand: 0000
CPU:    1
EIP:    0010:[<c012ede5>]
EFLAGS: 00010286
eax: 0000001f   ebx: c115b7dc   ecx: c021f400   edx: 00004270
esi: 00000000   edi: 00000000   ebp: 00000004   esp: c51a3e08
ds: 0018   es: 0018   ss: 0018
Process automount (pid: 528, stackpage=c51a3000)
Stack: c01f0cba 0000004b c115b9b8 c1044010 c0220820 00000212 00000005 
c115b7dc
      00000040 c02870d0 00000004 c01234fb 00000005 00000000 00005000 
0013b000
      c51a3e78 00000005 c5213500 00005000 00000005 00140000 c523a404 
00400000
Call Trace: [<c01234fb>] [<c014866c>] [<c01064ad>] [<c0125ee0>] 
[<c011e7bd>]
  [<c01147bc>] [<c0118d2a>] [<c011e42d>] [<c0106cec>] [<c013f168>] 
[<c010627c>]
  [<c0112370>] [<c0106eb4>]
Code: 0f 0b 5e 5d 89 da 8b 0d 98 70 2a c0 29 ca 89 d0 c1 e0 04 29

 >>EIP; c012ede5 <__free_pages_ok+35/330>   <=====
Trace; c01234fb <zap_page_range+51b/580>
Trace; c014866c <dput+1c/160>
Trace; c01064ad <setup_sigcontext+dd/130>
Trace; c0125ee0 <exit_mmap+c0/120>
Trace; c011e7bd <deliver_signal+1d/90>
Trace; c01147bc <mmput+3c/60>
Trace; c0118d2a <do_exit+da/290>
Trace; c011e42d <dequeue_signal+6d/c0>
Trace; c0106cec <do_signal+22c/2a0>
Trace; c013f168 <pipe_read+b8/240>
Trace; c010627c <sys_sigreturn+dc/110>
Trace; c0112370 <do_page_fault+0/4d0>
Trace; c0106eb4 <signal_return+14/20>
Code;  c012ede5 <__free_pages_ok+35/330>
00000000 <_EIP>:
Code;  c012ede5 <__free_pages_ok+35/330>   <=====
  0:   0f 0b                     ud2a      <=====
Code;  c012ede7 <__free_pages_ok+37/330>
  2:   5e                        pop    %esi
Code;  c012ede8 <__free_pages_ok+38/330>
  3:   5d                        pop    %ebp
Code;  c012ede9 <__free_pages_ok+39/330>
  4:   89 da                     mov    %ebx,%edx
Code;  c012edeb <__free_pages_ok+3b/330>
  6:   8b 0d 98 70 2a c0         mov    0xc02a7098,%ecx
Code;  c012edf1 <__free_pages_ok+41/330>
  c:   29 ca                     sub    %ecx,%edx
Code;  c012edf3 <__free_pages_ok+43/330>
  e:   89 d0                     mov    %edx,%eax
Code;  c012edf5 <__free_pages_ok+45/330>
  10:   c1 e0 04                  shl    $0x4,%eax
Code;  c012edf8 <__free_pages_ok+48/330>
  13:   29 00                     sub    %eax,(%eax)


-- 
Jorge Nerin
<comandante@zaralinux.com>



