Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbQJ2RZs>; Sun, 29 Oct 2000 12:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130361AbQJ2RZ2>; Sun, 29 Oct 2000 12:25:28 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:54421 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129605AbQJ2RZQ>; Sun, 29 Oct 2000 12:25:16 -0500
Message-ID: <39FC5D78.E872F18A@haque.net>
Date: Sun, 29 Oct 2000 12:25:13 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops in block_read_full_page() in test10-pre6
In-Reply-To: <Pine.LNX.4.21.0010291718570.1707-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I JUST got the same oops. But daylight savings happened 9 or so hours
ago here.

davej@suse.de wrote:
> 
> Wierd thing about this oops is that it happened just
> as I ticked over between the daylight savings adjustment,
> and the system clock changed itself.
> 
> Coincidence ? :)
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000010
> c012efaa
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c012efaa>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000000   ebx: 00000000   ecx: c11c3474   edx: c11c3448
> esi: c11c3448   edi: c5bf75fc   ebp: 00000000   esp: c201bee4
> ds: 0018   es: 0018   ss: 0018
> Process bash (pid: 13794, stackpage=c201b000)
> Stack: 00000000 c11c3448 c5bf75fc 00000000 0000001a 00000000 c02d3540
> 00000246
>        c0121c6e 00000000 c11c3448 c5bf75fc 00000000 c201bf1c 01234567
> c201a000
>        c11c3474 c11c3474 c014ae7e c11c3448 c014a7f8 c0122535 c468c860
> c11c3448
> Call Trace: [<c0121c6e>] [<c014ae7e>] [<c014a7f8>] [<c0122535>]
> [<c0122821>]
> [<c0122760>] [<c012cad5>]
>        [<c010a613>]
> Code: 8b 40 10 89 44 24 24 c7 44 24 18 00 00 00 00 8b 42 18 a8 01
> 
> >>EIP; c012efaa <block_read_full_page+e/1f4>   <=====
> Trace; c0121c6e <___wait_on_page+ca/d4>
> Trace; c014ae7e <ext2_readpage+e/14>
> Trace; c014a7f8 <ext2_get_block+0/480>
> Trace; c0122535 <do_generic_file_read+2ad/4d8>
> Trace; c0122821 <generic_file_read+59/74>
> Trace; c0122760 <file_read_actor+0/68>
> Trace; c012cad5 <sys_read+95/cc>
> Trace; c010a613 <system_call+33/40>
> Code;  c012efaa <block_read_full_page+e/1f4>
> 00000000 <_EIP>:
> Code;  c012efaa <block_read_full_page+e/1f4>   <=====
>    0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
> Code;  c012efad <block_read_full_page+11/1f4>
>    3:   89 44 24 24               mov    %eax,0x24(%esp,1)
> Code;  c012efb1 <block_read_full_page+15/1f4>
>    7:   c7 44 24 18 00 00 00      movl   $0x0,0x18(%esp,1)
> Code;  c012efb8 <block_read_full_page+1c/1f4>
>    e:   00
> Code;  c012efb9 <block_read_full_page+1d/1f4>
>    f:   8b 42 18                  mov    0x18(%edx),%eax
> Code;  c012efbc <block_read_full_page+20/1f4>
>   12:   a8 01                     test   $0x1,%al
> 
> --
> | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> | SuSE Labs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
