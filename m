Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSKYMSt>; Mon, 25 Nov 2002 07:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSKYMSt>; Mon, 25 Nov 2002 07:18:49 -0500
Received: from web14102.mail.yahoo.com ([216.136.172.132]:1344 "HELO
	web14102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262924AbSKYMSr>; Mon, 25 Nov 2002 07:18:47 -0500
Message-ID: <20021125122602.47257.qmail@web14102.mail.yahoo.com>
Date: Mon, 25 Nov 2002 04:26:02 -0800 (PST)
From: Helmut Apfelholz <helmutapfel@yahoo.com>
Subject: 2.40.20-rc2 oops
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've seen following oops today on my server UP server.
The kernel has modules disabled. This is UP PIII, 1Gb,
3ware 8 port card.

Please advice.

TIA
Helmut

> ksymoops 2.4.4 on i686 2.4.20-rc2.  Options used
>      -v vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.20-rc2/ (default)
>      -m System.map (specified)
> 
> No modules in ksyms, skipping objects
> Nov 25 10:50:59 x5 kernel: Unable to handle kernel
> paging request at virtual address 09771a94
> Nov 25 10:50:59 x5 kernel: c012d3f2
> Nov 25 10:50:59 x5 kernel: *pde = 00000000
> Nov 25 10:50:59 x5 kernel: Oops: 0000
> Nov 25 10:50:59 x5 kernel: CPU:    0
> Nov 25 10:50:59 x5 kernel: EIP:    0010:[<c012d3f2>]
>    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Nov 25 10:50:59 x5 kernel: EFLAGS: 00010206
> Nov 25 10:50:59 x5 kernel: eax: 09771a88   ebx:
> 00000000   ecx: 00000000   edx: c027b768
> Nov 25 10:50:59 x5 kernel: esi: d98312e0   edi:
> 00001000   ebp: 00001000   esp: c2e79f90
> Nov 25 10:50:59 x5 kernel: ds: 0018   es: 0018   ss:
> 0018
> Nov 25 10:50:59 x5 kernel: Process pop3d (pid: 2908,
> stackpage=c2e79000)
> Nov 25 10:50:59 x5 kernel: Stack: fffffffd c011508b
> 00000046 c2e79fc4 0000000a c0273a40 dfa882e0
> c010831c 
> Nov 25 10:50:59 x5 kernel:        c2e78000 00001000
> 0806e6a0 bfffc3c8 c0106d93 00000001 0806e6a0
> 00001000 
> Nov 25 10:50:59 x5 kernel:        00001000 0806e6a0
> bfffc3c8 00000004 c010002b 0000002b 00000004
> 420dace4 
> Nov 25 10:50:59 x5 kernel: Call Trace:   
> [<c011508b>] [<c010831c>] [<c0106d93>]
> Nov 25 10:50:59 x5 kernel: Code: 8b 58 0c 8b 43 08
> f6 80 f0 00 00 00 02 74 2a 85 db 74 12 8b 
> 
> >>EIP; c012d3f2 <sys_write+a2/f0>   <=====
> Trace; c011508b <do_softirq+4b/90>
> Trace; c010831c <do_IRQ+9c/b0>
> Trace; c0106d93 <system_call+33/38>
> Code;  c012d3f2 <sys_write+a2/f0>
> 00000000 <_EIP>:
> Code;  c012d3f2 <sys_write+a2/f0>   <=====
>    0:   8b 58 0c                  mov   
> 0xc(%eax),%ebx   <=====
> Code;  c012d3f5 <sys_write+a5/f0>
>    3:   8b 43 08                  mov   
> 0x8(%ebx),%eax
> Code;  c012d3f8 <sys_write+a8/f0>
>    6:   f6 80 f0 00 00 00 02      testb 
> $0x2,0xf0(%eax)
> Code;  c012d3ff <sys_write+af/f0>
>    d:   74 2a                     je     39
> <_EIP+0x39> c012d42b <sys_write+db/f0>
> Code;  c012d401 <sys_write+b1/f0>
>    f:   85 db                     test   %ebx,%ebx
> Code;  c012d403 <sys_write+b3/f0>
>   11:   74 12                     je     25
> <_EIP+0x25> c012d417 <sys_write+c7/f0>
> Code;  c012d405 <sys_write+b5/f0>
>   13:   8b 00                     mov    (%eax),%eax
> 
> Nov 25 10:50:59 x5 kernel:  <1>Unable to handle
> kernel paging request at virtual address 09771ae4
> Nov 25 10:50:59 x5 kernel: c012ce8a
> Nov 25 10:50:59 x5 kernel: *pde = 00000000
> Nov 25 10:50:59 x5 kernel: Oops: 0000
> Nov 25 10:50:59 x5 kernel: CPU:    0
> Nov 25 10:50:59 x5 kernel: EIP:    0010:[<c012ce8a>]
>    Not tainted
> Nov 25 10:50:59 x5 kernel: EFLAGS: 00010206
> Nov 25 10:50:59 x5 kernel: eax: 09771ac0   ebx:
> d98312e0   ecx: 00000032   edx: d98312e0
> Nov 25 10:50:59 x5 kernel: esi: 00000000   edi:
> d96c6880   ebp: 00000000   esp: c2e79e34
> Nov 25 10:50:59 x5 kernel: ds: 0018   es: 0018   ss:
> 0018
> Nov 25 10:50:59 x5 kernel: Process pop3d (pid: 2908,
> stackpage=c2e79000)
> Nov 25 10:50:59 x5 kernel: Stack: 000007ff d96c6880
> 00000001 c011385c d98312e0 d96c6880 00000000
> d97aaca0 
> Nov 25 10:50:59 x5 kernel:        c2e78000 0000000b
> c0113e48 d96c6880 00000000 0000001f df00df64
> c2e79f5c 
> Nov 25 10:50:59 x5 kernel:        c01fe0ae 09771a94
> c02086b8 c0200018 c01f0018 ffffff00 c0107339
> 00000010 
> Nov 25 10:50:59 x5 kernel: Call Trace:   
> [<c011385c>] [<c0113e48>] [<c01f0018>] [<c0107339>]
> [<c010f6f7>]
> Nov 25 10:50:59 x5 kernel:   [<c01e8205>]
> [<c01b46dc>] [<c0120f4f>] [<c01b48f7>] [<c010f380>]
> [<c0106e84>]
> Nov 25 10:50:59 x5 kernel:   [<c012d3f2>]
> [<c011508b>] [<c010831c>] [<c0106d93>]
> Nov 25 10:50:59 x5 kernel: Code: 8b 50 24 85 d2 74
> 07 53 ff 50 24 59 89 c6 57 53 e8 41 3c 01 
> 
> >>EIP; c012ce8a <filp_close+2a/60>   <=====
> Trace; c011385c <put_files_struct+4c/d0>
> Trace; c0113e48 <do_exit+a8/210>
> Trace; c01f0018 <unix_release_sock+38/1d0>
> Trace; c0107339 <die+59/70>
> Trace; c010f6f7 <do_page_fault+377/4ab>
> Trace; c01e8205 <inet_sendmsg+35/40>
> Trace; c01b46dc <sock_sendmsg+6c/90>
> Trace; c0120f4f <do_generic_file_read+22f/430>
> Trace; c01b48f7 <sock_write+a7/c0>
> Trace; c010f380 <do_page_fault+0/4ab>
> Trace; c0106e84 <error_code+34/3c>
> Trace; c012d3f2 <sys_write+a2/f0>
> Trace; c011508b <do_softirq+4b/90>
> Trace; c010831c <do_IRQ+9c/b0>
> Trace; c0106d93 <system_call+33/38>
> Code;  c012ce8a <filp_close+2a/60>
> 00000000 <_EIP>:
> Code;  c012ce8a <filp_close+2a/60>   <=====
>    0:   8b 50 24                  mov   
> 0x24(%eax),%edx   <=====
> Code;  c012ce8d <filp_close+2d/60>
>    3:   85 d2                     test   %edx,%edx
> Code;  c012ce8f <filp_close+2f/60>
>    5:   74 07                     je     e
> <_EIP+0xe> c012ce98 <filp_close+38/60>
> Code;  c012ce91 <filp_close+31/60>
>    7:   53                        push   %ebx
> Code;  c012ce92 <filp_close+32/60>
>    8:   ff 50 24                  call   *0x24(%eax)
> Code;  c012ce95 <filp_close+35/60>
>    b:   59                        pop    %ecx
> Code;  c012ce96 <filp_close+36/60>
>    c:   89 c6                     mov    %eax,%esi
> Code;  c012ce98 <filp_close+38/60>
>    e:   57                        push   %edi
> Code;  c012ce99 <filp_close+39/60>
>    f:   53                        push   %ebx
> Code;  c012ce9a <filp_close+3a/60>
>   10:   e8 41 3c 01 00            call   13c56
> <_EIP+0x13c56> c0140ae0 <dnotify_flush+0/60>
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus – Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
