Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRAVWiQ>; Mon, 22 Jan 2001 17:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130167AbRAVWiH>; Mon, 22 Jan 2001 17:38:07 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:39163 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129806AbRAVWhw>; Mon, 22 Jan 2001 17:37:52 -0500
Message-ID: <3A6CB620.469A15A9@Home.net>
Date: Mon, 22 Jan 2001 17:37:20 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jorge Nerin <comandante@zaralinux.com>
CC: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
In-Reply-To: <3A6C5058.C5AA7681@zaralinux.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a kernel bug, This is a bug in the XFree86 TrueType rendering
extention. This has been discussed on the Xpert XFree86 mailing list. There
is a fix in the works (depends on the TrueType fonts your using).

Unless otherwise, Im using 2.4.1-pre9 with no such faults (XFree86 CVS
X11R6.5.1 merge sources) not 4.0.2 stable.

Shawn.

Jorge Nerin wrote:


> Hello, this is perfectly reproductable, fresh RH7.0 kernel 2.4.1-pre9
> compiled with kgcc, and the same bug in pre1, pre4 & pre9. I only need
> to run xfontsel and the xfs dies, every time, prefectly reproductable.
>
> Using XFree86-xfs-4.0.1-1, and this XFree packages:
> XFree86-4.0.1-1
> XFree86-tools-4.0.1-1
> XFree86-xdm-4.0.1-1
> XFree86-libs-4.0.1-1
> XFree86-xfs-4.0.1-1
> XFree86-75dpi-fonts-4.0.1-1
> XFree86-SVGA-3.3.6-33
> XFree86-twm-4.0.1-1
> XFree86-VGA16-3.3.6-33
> XFree86-Xnest-4.0.1-1
> XFree86-devel-4.0.1-1
> XFree86-V4L-4.0.1-1
>
> Pentium 2x200mmx 96mb ram, voodoo 3 200pci, more info as requested, and
> also some patches are welcome.
>
> ksymoops 2.3.4 on i586 2.4.1-pre9.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.1-pre9/ (default)
>      -m /usr/src/linux/System.map (default)
>
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
>
> activating NMI Watchdog ... done.
> cpu: 0, clocks: 668150, slice: 222716
> cpu: 1, clocks: 668150, slice: 222716
> 8139too Fast Ethernet driver 0.9.13 loaded
> invalid operand: 0000
> CPU:    1
> EIP:    0010:[<c012c056>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010292
> eax: 0000001b   ebx: c27cc680   ecx: 00000008   edx: c5802ca0
> esi: 00000003   edi: c4310000   ebp: c4310000   esp: c4311de4
> ds: 0018   es: 0018   ss: 0018
> Process xfs (pid: 909, stackpage=c4311000)
> Stack: c01e97a5 c01e9825 00000606 c27cc680 00000003 c4310000 c4310000
> c0111d3b
>        c5fe3f0c 000001a8 c0196cfa 0003fff4 00000003 00000000 c5c96c20
> c4310000
>        00000ff0 00000206 c01963fe 0003fff0 00000003 c2f8a164 0003ffec
> c01d1550
> Call Trace: [<c0111d3b>] [<c0196cfa>] [<c01963fe>] [<c01d1550>]
> [<c01d167e>] [<c01d1550>] [<c0193fad>]
>        [<c01d1550>] [<c0194260>] [<c01942e2>] [<c0134763>] [<c01348c9>]
> [<c0108fc7>]
> Code: 0f 0b 83 c4 0c 90 8d 74 26 00 31 c0 5b 5e 5f 5d 83 c4 0c c3
>
> >>EIP; c012c056 <kmalloc+112/128>   <=====
> Trace; c0111d3b <smp_call_function_interrupt+1f/34>
> Trace; c0196cfa <alloc_skb+102/1a0>
> Trace; c01963fe <sock_alloc_send_skb+72/12c>
> Trace; c01d1550 <unix_stream_sendmsg+0/310>
> Trace; c01d167e <unix_stream_sendmsg+12e/310>
> Trace; c01d1550 <unix_stream_sendmsg+0/310>
> Trace; c0193fad <sock_sendmsg+81/a4>
> Trace; c01d1550 <unix_stream_sendmsg+0/310>
> Trace; c0194260 <sock_readv_writev+8c/98>
> Trace; c01942e2 <sock_writev+36/40>
> Trace; c0134763 <do_readv_writev+183/254>
> Trace; c01348c9 <sys_writev+41/54>
> Trace; c0108fc7 <system_call+37/40>
> Code;  c012c056 <kmalloc+112/128>
> 00000000 <_EIP>:
> Code;  c012c056 <kmalloc+112/128>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c012c058 <kmalloc+114/128>
>    2:   83 c4 0c                  add    $0xc,%esp
> Code;  c012c05b <kmalloc+117/128>
>    5:   90                        nop
> Code;  c012c05c <kmalloc+118/128>
>    6:   8d 74 26 00               lea    0x0(%esi,1),%esi
> Code;  c012c060 <kmalloc+11c/128>
>    a:   31 c0                     xor    %eax,%eax
> Code;  c012c062 <kmalloc+11e/128>
>    c:   5b                        pop    %ebx
> Code;  c012c063 <kmalloc+11f/128>
>    d:   5e                        pop    %esi
> Code;  c012c064 <kmalloc+120/128>
>    e:   5f                        pop    %edi
> Code;  c012c065 <kmalloc+121/128>
>    f:   5d                        pop    %ebp
> Code;  c012c066 <kmalloc+122/128>
>   10:   83 c4 0c                  add    $0xc,%esp
> Code;  c012c069 <kmalloc+125/128>
>   13:   c3                        ret
>
> 1 warning issued.  Results may not be reliable.
>
> kernel BUG at slab.c:1542!
> invalid operand: 0000
> CPU:    1
> EIP:    0010:[kmalloc+274/296]
> EFLAGS: 00010292
> eax: 0000001b   ebx: c27cc680   ecx: 00000008   edx: c5802ca0
> esi: 00000003   edi: c4310000   ebp: c4310000   esp: c4311de4
> ds: 0018   es: 0018   ss: 0018
> Process xfs (pid: 909, stackpage=c4311000)
> Stack: c01e97a5 c01e9825 00000606 c27cc680 00000003 c4310000 c4310000
> c0111d3b
>        c5fe3f0c 000001a8 c0196cfa 0003fff4 00000003 00000000 c5c96c20
> c4310000
>        00000ff0 00000206 c01963fe 0003fff0 00000003 c2f8a164 0003ffec
> c01d1550
> Call Trace: [smp_call_function_interrupt+31/52] [alloc_skb+258/416]
> [sock_alloc_send_skb+114/300] [unix_stream_sendmsg+0/784]
> [unix_stream_sendmsg+302/784] [unix_stream_sendmsg+0/784]
> [sock_sendmsg+129/164]
>        [unix_stream_sendmsg+0/784] [sock_readv_writev+140/152]
> [sock_writev+54/64] [do_readv_writev+387/596] [sys_writev+65/84]
> [system_call+55/64]
>
> Code: 0f 0b 83 c4 0c 90 8d 74 26 00 31 c0 5b 5e 5f 5d 83 c4 0c c3
>
> --
> Jorge Nerin
> <comandante@zaralinux.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
