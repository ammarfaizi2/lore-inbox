Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278098AbRJWURV>; Tue, 23 Oct 2001 16:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278216AbRJWURM>; Tue, 23 Oct 2001 16:17:12 -0400
Received: from home.nohrsc.nws.gov ([192.46.108.2]:18306 "HELO nohrsc.nws.gov")
	by vger.kernel.org with SMTP id <S278098AbRJWURD>;
	Tue, 23 Oct 2001 16:17:03 -0400
Date: Tue, 23 Oct 2001 15:07:44 -0500 (CDT)
From: kelley eicher <keicher@nws.gov>
X-X-Sender: <keicher@home.nohrsc.nws.gov>
To: <linux-kernel@vger.kernel.org>
Subject: Oops+Aiee on 2.4.12
Message-ID: <Pine.LNX.4.33.0110231502560.10077-100000@home.nohrsc.nws.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


while using 2.4.12 on a dual intel pentium III machine with the intel
440gx chipset and an adaptec 7896 scsi controller today, i ran into an
Oops+Aiee.

does anyone know whether or not this is hardware failure or a linux
kernel bug?

here's the ksymoops interpretation of the Oops:

Unable to handle kernel paging request at virtual address c9f37620
Unable to handle kernel paging request at virtual address b0237cdc
Oops: 0000
CPU:    1
EIP:    0010:[<c0112889>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000013   ebx: f0237000   ecx: c027ae48   edx: 00002da4
esi: d6477b40   edi: f2048000   ebp: 00000337   esp: f2049e1c
ds: 0018   es: 0018   ss: 0018
Process idl (pid: 24687, stackpage=f2049000)
Stack: f2048000 0000000b c011254c f7e7b244 0060f2e5 d51c882c f2048000
ef717ac0
       00000000 00030001 a06c2ec0 00001158 d4a584a0 c01f56d4 ef717ac0
f6568960
       f2048000 f6568960 00000000 f2049f2c f7e7b000 e21e802e f8a33cc5
f6568960
Call Trace: [<c011254c>] [<c01f56d4>] [<f8a33cc5>] [<c01f49d0>]
[<f8a33381>]
   [<c01f49d0>] [<f8a35284>] [<c01f4836>] [<c0106e60>] [<c01e5848>]
[<f8a28b5c>]
   [<f8a28fc4>] [<f8a288da>] [<c0108411>] [<c01085f6>] [<c010a6f8>]
Code: 8b 9c ab 00 00 00 c0 53 68 6d dc 23 c0 e8 75 39 00 00 83 c4

>>EIP; c0112888 <do_page_fault+33c/4b4>   <=====
Trace; c011254c <do_page_fault+0/4b4>
Trace; c01f56d4 <ip_defrag+dc/178>
Trace; f8a33cc4 <[ip_conntrack]ip_ct_gather_frags+50/13c>
Trace; c01f49d0 <ip_rcv_finish+0/1e0>
Trace; f8a33380 <[ip_conntrack]ip_conntrack_in+38/284>
Trace; c01f49d0 <ip_rcv_finish+0/1e0>
Trace; f8a35284 <[ip_conntrack]ip_conntrack_in_ops+0/18>
Trace; c01f4836 <ip_rcv+366/3b0>
Trace; c0106e60 <error_code+34/3c>
Trace; c01e5848 <alloc_skb+130/1b4>
Trace; f8a28b5c <[eepro100]speedo_refill_rx_buf+3c/1d4>
Trace; f8a28fc4 <[eepro100]speedo_rx+298/2fc>
Trace; f8a288da <[eepro100]speedo_interrupt+aa/2f0>
Trace; c0108410 <handle_IRQ_event+4c/78>
Trace; c01085f6 <do_IRQ+a6/ec>
Trace; c010a6f8 <call_do_IRQ+6/e>
Code;  c0112888 <do_page_fault+33c/4b4>
00000000 <_EIP>:
Code;  c0112888 <do_page_fault+33c/4b4>   <=====
   0:   8b 9c ab 00 00 00 c0      movl   0xc0000000(%ebx,%ebp,4),%ebx
<=====
Code;  c011288e <do_page_fault+342/4b4>
   7:   53                        pushl  %ebx
Code;  c0112890 <do_page_fault+344/4b4>
   8:   68 6d dc 23 c0            pushl  $0xc023dc6d
Code;  c0112894 <do_page_fault+348/4b4>
   d:   e8 75 39 00 00            call   3987 <_EIP+0x3987> c011620e
<emit_log_char+66/68>
Code;  c011289a <do_page_fault+34e/4b4>
  12:   83 c4 00                  addl   $0x0,%esp

 <0>Kernel panic: Aiee, killing interrupt handler!




thanx,
-kelley

