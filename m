Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTJMPQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTJMPQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:16:36 -0400
Received: from mailbox.riga.lv ([195.2.96.9]:29445 "EHLO ded.delfi.lv")
	by vger.kernel.org with ESMTP id S261779AbTJMPQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:16:16 -0400
From: "Janis Putrams" <janis.putrams@delfi.lv>
To: <linux-kernel@vger.kernel.org>
Subject: paging request at virtual address 8a000018, pde = 00000000
Date: Mon, 13 Oct 2003 18:12:35 +0300
Message-ID: <PDENKKCEFBFIMGJFDIBHCEAHCCAA.janis.putrams@delfi.lv>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Got regular kernel crashes on high load nfs client/db server/www. Had
crashes with kernels 2.4.18 as well as 2.4.20. Replaced RAM- no help.
Managed to capture through serial console. If someone could give direction
it would be great.
Thanks
Janis Putrams

cpu:2x Intel(R) XEON(TM) CPU 2.20GHz
os:Red Hat Linux 7.3 2.96-113
gcc:gcc version 2.96 20000731
kernel-ver:linux-2.4.20-20.7(have happened also with 2.4.18)

Unable to handle kernel paging request at virtual address 8a000018
c0106da7
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0106da7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 8a000028   ebx: de110000   ecx: de110000   edx: 8a000000
esi: 00000002   edi: 8a000018   ebp: de111f30   esp: de111f28
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 17454, stackpage=de111000)
Stack: de110654 de111fc4 00000002 00000000 00000000 00000000 00000000
c529f03b
       de110000 00000000 e6c08780 f8a6aa33 e6c08780 00000000 de111f90
00000000
       c0148c10 ec986f80 c0148b34 e6c08780 00000000 00000000 00000000
c013d32a
Call Trace:   [<f8a6aa33>]  (0xde111f54))
[<c0148c10>]  (0xde111f68))
[<c0148b34>]  (0xde111f70))
[<c013d32a>]  (0xde111f84))
[<c010708c>]  (0xde111fc0))
Code: 8b 40 f0 83 f8 01 75 31 83 fe 11 0f 85 08 ff ff ff 90 8d b4

>>EIP; c0106da7 <do_signal+127/27b>   <=====
Trace; f8a6aa33 <[nfs]nfs_permission+13/119>
Trace; c0148c10 <path_release+10/30>
Trace; c0148b34 <permission+44/80>
Trace; c013d32a <sys_access+ea/120>
Trace; c010708c <signal_return+14/18>
Code;  c0106da7 <do_signal+127/27b>
00000000 <_EIP>:
Code;  c0106da7 <do_signal+127/27b>   <=====
   0:   8b 40 f0                  mov    0xfffffff0(%eax),%eax   <=====
Code;  c0106daa <do_signal+12a/27b>
   3:   83 f8 01                  cmp    $0x1,%eax
Code;  c0106dad <do_signal+12d/27b>
   6:   75 31                     jne    39 <_EIP+0x39> c0106de0
<do_signal+160/27b>
Code;  c0106daf <do_signal+12f/27b>
   8:   83 fe 11                  cmp    $0x11,%esi
Code;  c0106db2 <do_signal+132/27b>
   b:   0f 85 08 ff ff ff         jne    ffffff19 <_EIP+0xffffff19> c0106cc0
<do_signal+40/27b>
Code;  c0106db8 <do_signal+138/27b>
  11:   90                        nop
Code;  c0106db9 <do_signal+139/27b>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi

 <1>Unable to handle kernel paging request at virtual address 8a000000
c011e875
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c011e875>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: de110000   ecx: 00000000   edx: 8a000000
esi: c54dc140   edi: de110000   ebp: de110000   esp: de111dac
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 17454, stackpage=de111000)
Stack: c54e0ce4 c01192d3 de110000 00000004 00000001 de111df8 00000001
c0110006
       00000000 00000001 f6278000 f6279f44 00000046 de111ef4 00000000
c02182d9
       de111ef4 c021182d de111df8 de111ef4 00000096 00000000 00000000
c02182d9
Call Trace:   [<c01192d3>]  (0xde111db0))
[<c0110006>]  (0xde111dc8))
[<c0110018>]  (0xde111e18))
[<c010768f>]  (0xde111e20))
[<c0106da7>]  (0xde111e2c))
[<c0111678>]  (0xde111e38))
[<c01239ea>]  (0xde111e8c))
[<c01243f5>]  (0xde111e9c))
[<c01244b1>]  (0xde111ea4))
[<c020a590>]  (0xde111ec8))
[<c01112d0>]  (0xde111ee0))
[<c0107144>]  (0xde111ee8))
[<c0106da7>]  (0xde111f1c))
[<f8a6aa33>]  (0xde111f54))
[<c0148c10>]  (0xde111f68))
[<c0148b34>]  (0xde111f70))
[<c013d32a>]  (0xde111f84))
[<c010708c>]  (0xde111fc0))
Code: f0 ff 0a 0f 94 c0 84 c0 74 0e 52 a1 d0 49 2d c0 50 e8 f5 06

>>EIP; c011e875 <exit_sighand+25/60>   <=====
Trace; c01192d3 <do_exit+253/2d0>
Trace; c0110006 <smp_apic_timer_interrupt+f6/120>
Trace; c0110018 <smp_apic_timer_interrupt+108/120>
Trace; c010768f <die+7f/90>
Trace; c0106da7 <do_signal+127/27b>
Trace; c0111678 <do_page_fault+3a8/4db>
Trace; c01239ea <__free_pte+4a/50>
Trace; c01243f5 <zap_page_range+385/4d0>
Trace; c01244b1 <zap_page_range+441/4d0>
Trace; c020a590 <rb_insert_color+70/f0>
Trace; c01112d0 <do_page_fault+0/4db>
Trace; c0107144 <error_code+34/3c>
Trace; c0106da7 <do_signal+127/27b>
Trace; f8a6aa33 <[nfs]nfs_permission+13/119>
Trace; c0148c10 <path_release+10/30>
Trace; c0148b34 <permission+44/80>
Trace; c013d32a <sys_access+ea/120>
Trace; c010708c <signal_return+14/18>
Code;  c011e875 <exit_sighand+25/60>
00000000 <_EIP>:
Code;  c011e875 <exit_sighand+25/60>   <=====
   0:   f0 ff 0a                  lock decl (%edx)   <=====
Code;  c011e878 <exit_sighand+28/60>
   3:   0f 94 c0                  sete   %al
Code;  c011e87b <exit_sighand+2b/60>
   6:   84 c0                     test   %al,%al
Code;  c011e87d <exit_sighand+2d/60>
   8:   74 0e                     je     18 <_EIP+0x18> c011e88d
<exit_sighand+3d/60>
Code;  c011e87f <exit_sighand+2f/60>
   a:   52                        push   %edx
Code;  c011e880 <exit_sighand+30/60>
   b:   a1 d0 49 2d c0            mov    0xc02d49d0,%eax
Code;  c011e885 <exit_sighand+35/60>
  10:   50                        push   %eax
Code;  c011e886 <exit_sighand+36/60>
  11:   e8 f5 06 00 00            call   70b <_EIP+0x70b> c011ef80
<deliver_signal+50/90>


