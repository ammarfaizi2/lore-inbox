Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143363AbRATJs6>; Sat, 20 Jan 2001 04:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143399AbRATJst>; Sat, 20 Jan 2001 04:48:49 -0500
Received: from mail.touchofmadness.com ([208.248.233.6]:270 "EHLO
	touchofmadness.com") by vger.kernel.org with ESMTP
	id <S143363AbRATJsq>; Sat, 20 Jan 2001 04:48:46 -0500
Message-ID: <00e901c082c6$1bb276b0$0500a8c0@nyx>
From: "Aaron Tiensivu" <mojomofo@touchofmadness.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-ppp@vger.kernel.org>, <paulus@linuxcare.com>
Subject: [2.4.1-p8 More MPPP oops]
Date: Sat, 20 Jan 2001 04:48:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always the glutton for punishment, I did it again tonite. A different oops
now.
See my last message for prior info.

ksymoops 2.3.7 on i586 2.4.1-pre8.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre8/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c49c957d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c49c957d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: c20200b4   ebx: 00000000   ecx: c20200b4   edx: c0632460
esi: 000240cb   edi: c023b6ec   ebp: c1902dc0   esp: c2a65e5c
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 705, stackpage=c2a65000)
Stack: 000240ca c18a6c60 fffffffe c2020044 0000000c 00000000 c1902960
c1902960
       c20200b4 000240ca c49c9270 c2020000 c2020000 00000010 c28b8920
00000002
       c20200b4 c49c8b04 c2020000 c18a6c60 c28b8920 c18a6c60 c49c8a1b
c2020000
Call Trace: [<c49c9270>] [<c49c8b04>] [<c49c8a1b>] [<c49ccf86>] [<c49cc383>]
[<c01726e5>] [<c0172774>]
       [<c0181487>] [<c0181766>] [<c0109f3c>] [<c010a09e>] [<c0108e00>]
Code: 8b 13 8b 43 04 c7 03 00 00 00 00 c7 43 04 00 00 00 00 c7 43

>>EIP; c49c957d <[ppp_generic]ppp_mp_reconstruct+289/2d8>   <=====
Trace; c49c9270 <[ppp_generic]ppp_receive_mp_frame+1cc/20c>
Trace; c49c8b04 <[ppp_generic]ppp_receive_frame+30/7c>
Trace; c49c8a1b <[ppp_generic]ppp_input+12f/164>
Trace; c49ccf86 <[ppp_async]ppp_async_input+3ae/458>
Trace; c49cc383 <[ppp_async]ppp_asynctty_receive+27/58>
Trace; c01726e5 <flush_to_ldisc+dd/e4>
Trace; c0172774 <tty_flip_buffer_push+14/5c>
Trace; c0181487 <receive_chars+1f3/200>
Trace; c0181766 <rs_interrupt_single+42/88>
Trace; c0109f3c <handle_IRQ_event+30/5c>
Trace; c010a09e <do_IRQ+6e/b0>
Trace; c0108e00 <ret_from_intr+0/20>
Code;  c49c957d <[ppp_generic]ppp_mp_reconstruct+289/2d8>
00000000 <_EIP>:
Code;  c49c957d <[ppp_generic]ppp_mp_reconstruct+289/2d8>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c49c957f <[ppp_generic]ppp_mp_reconstruct+28b/2d8>
   2:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c49c9582 <[ppp_generic]ppp_mp_reconstruct+28e/2d8>
   5:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c49c9588 <[ppp_generic]ppp_mp_reconstruct+294/2d8>
   b:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c49c958f <[ppp_generic]ppp_mp_reconstruct+29b/2d8>
  12:   c7 43 00 00 00 00 00      movl   $0x0,0x0(%ebx)

Kernel panic: Aiee, killing interrupt handler!

Unable to handle kernel NULL pointer dereference at virtual address 00000068
c49c92d8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c49c92d8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: 000240dd   ebx: 000240dd   ecx: c20200b4   edx: 00000000
esi: c18c8ac0   edi: 00000000   ebp: c2020044   esp: c2a65bd4
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 705, stackpage=c2a65000)
Stack: 000240ca c18c8ac0 c49c922c c2020000 c18c8ac0 c2020000 0000025d
c293ed40
       00000005 c20200b4 c49c8b04 c2020000 c18c8ac0 c293ed40 c18c8ac0
c49c8a1b
       c2020000 c18c8ac0 c293ed40 c18c8ac0 0000025d 00000000 00000005
c49cc383
Call Trace: [<c49c922c>] [<c49c8b04>] [<c49c8a1b>] [<c49cc383>] [<c49ccf86>]
[<c49cc383>] [<c01726e5>]
       [<c0172774>] [<c0181487>] [<df000000>] [<c0181766>] [<c0109f3c>]
[<c010a09e>] [<c0108e00>] [<c0113900>
       [<c01162bf>] [<c010928c>] [<c0111165>] [<c0110e44>] [<c0172774>]
[<c0181487>] [<c0181563>] [<c0181796>
       [<c0109f3c>] [<c010a0d2>] [<c0108e84>] [<c49c957d>] [<c49c9270>]
[<c49c8b04>] [<c49c8a1b>] [<c49ccf86>
       [<c49cc383>] [<c01726e5>] [<c0172774>] [<c0181487>] [<c0181766>]
[<c0109f3c>] [<c010a09e>] [<c0108e00>
Code: 2b 42 68 79 f3 8b 42 04 89 56 00 89 46 04 89 72 04 89 30 89

>>EIP; c49c92d8 <[ppp_generic]ppp_mp_insert+28/44>   <=====
Trace; c49c922c <[ppp_generic]ppp_receive_mp_frame+188/20c>
Trace; c49c8b04 <[ppp_generic]ppp_receive_frame+30/7c>
Trace; c49c8a1b <[ppp_generic]ppp_input+12f/164>
Trace; c49cc383 <[ppp_async]ppp_asynctty_receive+27/58>
Trace; c49ccf86 <[ppp_async]ppp_async_input+3ae/458>
Trace; c49cc383 <[ppp_async]ppp_asynctty_receive+27/58>
Trace; c01726e5 <flush_to_ldisc+dd/e4>
Trace; c0172774 <tty_flip_buffer_push+14/5c>
Trace; c0181487 <receive_chars+1f3/200>
Trace; df000000 <END_OF_CODE+1a5d75e5/????>
Trace; c0181766 <rs_interrupt_single+42/88>
Trace; c0109f3c <handle_IRQ_event+30/5c>
Trace; c010a09e <do_IRQ+6e/b0>
Trace; c0108e00 <ret_from_intr+0/20>
Trace; c0113900 <panic+c0/d0>
Trace; c01162bf <do_exit+27/230>
Trace; c010928c <do_divide_error+0/ac>
Trace; c0111165 <do_page_fault+321/40c>
Trace; c0110e44 <do_page_fault+0/40c>
Trace; c0172774 <tty_flip_buffer_push+14/5c>
Trace; c0181487 <receive_chars+1f3/200>
Trace; c0181563 <transmit_chars+cf/d8>
Trace; c0181796 <rs_interrupt_single+72/88>
Trace; c0109f3c <handle_IRQ_event+30/5c>
Trace; c010a0d2 <do_IRQ+a2/b0>
Trace; c0108e84 <error_code+34/40>
Trace; c49c957d <[ppp_generic]ppp_mp_reconstruct+289/2d8>
Trace; c49c9270 <[ppp_generic]ppp_receive_mp_frame+1cc/20c>
Trace; c49c8b04 <[ppp_generic]ppp_receive_frame+30/7c>
Trace; c49c8a1b <[ppp_generic]ppp_input+12f/164>
Trace; c49ccf86 <[ppp_async]ppp_async_input+3ae/458>
Trace; c49cc383 <[ppp_async]ppp_asynctty_receive+27/58>
Trace; c01726e5 <flush_to_ldisc+dd/e4>
Trace; c0172774 <tty_flip_buffer_push+14/5c>
Trace; c0181487 <receive_chars+1f3/200>
Trace; c0181766 <rs_interrupt_single+42/88>
Trace; c0109f3c <handle_IRQ_event+30/5c>
Trace; c010a09e <do_IRQ+6e/b0>
Trace; c0108e00 <ret_from_intr+0/20>
Code;  c49c92d8 <[ppp_generic]ppp_mp_insert+28/44>
00000000 <_EIP>:
Code;  c49c92d8 <[ppp_generic]ppp_mp_insert+28/44>   <=====
   0:   2b 42 68                  sub    0x68(%edx),%eax   <=====
Code;  c49c92db <[ppp_generic]ppp_mp_insert+2b/44>
   3:   79 f3                     jns    fffffff8 <_EIP+0xfffffff8> c49c92d0
<[ppp_generic]ppp_mp_insert+20/4>
Code;  c49c92dd <[ppp_generic]ppp_mp_insert+2d/44>
   5:   8b 42 04                  mov    0x4(%edx),%eax
Code;  c49c92e0 <[ppp_generic]ppp_mp_insert+30/44>
   8:   89 56 00                  mov    %edx,0x0(%esi)
Code;  c49c92e3 <[ppp_generic]ppp_mp_insert+33/44>
   b:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c49c92e6 <[ppp_generic]ppp_mp_insert+36/44>
   e:   89 72 04                  mov    %esi,0x4(%edx)
Code;  c49c92e9 <[ppp_generic]ppp_mp_insert+39/44>
  11:   89 30                     mov    %esi,(%eax)
Code;  c49c92eb <[ppp_generic]ppp_mp_insert+3b/44>
  13:   89 00                     mov    %eax,(%eax)

Kernel panic: Aiee, killing interrupt handler!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
