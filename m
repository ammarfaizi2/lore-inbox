Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSGJT7d>; Wed, 10 Jul 2002 15:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSGJT7c>; Wed, 10 Jul 2002 15:59:32 -0400
Received: from ua150d35hel.dial.kolumbus.fi ([62.248.233.150]:46189 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S317592AbSGJT7a>; Wed, 10 Jul 2002 15:59:30 -0400
Message-ID: <3D2C92C0.658B954@kolumbus.fi>
Date: Wed, 10 Jul 2002 23:02:08 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [CRASH] in tulip driver?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Any ideas what is causing the following crash?


	- Jussi Laako

--- 8< ---

ksymoops 2.4.4 on i686 2.4.19-pre7-jl4-ll.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre7-jl4-ll/ (default)
     -m /boot/System.map-2.4.19-pre7-jl4-ll (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at sched.c:579!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01169ac>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000018   ebx: 0000000a   ecx: 00000082   edx: dc80df64
esi: d74458c0   edi: 0000001a   ebp: c021f804   esp: c021f7e0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c021f000)
Stack: c01eda4a 00000042 c021e000 00000000 0000000a c021e000 0000000a
c0272900 
       0000001a 00000080 c01765a5 c021e000 0000000a 6e6d6c6b 7271706f
76757473 
       7a797877 00000000 33323130 00000000 30353132 c021f831 20006867
00000000 
Call Trace: [<c01765a5>] [<c01df740>] [<e0bd0077>] [<e0bd008f>] [<c0176648>] 
   [<c0177336>] [<c01c9dc0>] [<c01addd4>] [<c01a78fe>] [<c01b7760>]
[<c01b77e3>] 
   [<c01ad51a>] [<c01ad54c>] [<c01b7700>] [<c01b6434>] [<c01c48e7>]
[<c01a46cb>] 
   [<c01df740>] [<e0bd0077>] [<c01c3a13>] [<c01df8e2>] [<c01ca07c>]
[<c01ca38d>] 
   [<c01ca73d>] [<c01ad24b>] [<c01b4013>] [<c01b3f60>] [<c01ad51a>]
[<c01b3f60>] 
   [<c01ad54c>] [<c01b4090>] [<c01b3bf7>] [<c01b3f60>] [<c01b4090>]
[<c01b4090>] 
   [<c01b41f8>] [<c01b4090>] [<c01ad51a>] [<c01b4090>] [<c01ad54c>]
[<c0109cbc>] 
   [<c01b3f2c>] [<c01b4090>] [<e0a641c1>] [<c01a7e58>] [<c0109b19>]
[<c011d29b>] 
   [<c0109cbc>] [<c0106c60>] [<c0106c60>] [<c010bc68>] [<c0106c60>]
[<c0106c60>] 
   [<c0106c83>] [<c0106d02>] [<c0105000>] 
Code: 0f 0b 43 02 42 da 1e c0 5b fa 8b 55 f0 83 7a 28 02 75 40 8b 

>>EIP; c01169ac <schedule+4c/300>   <=====
Trace; c01765a5 <extract_entropy+375/3f0>
Trace; c01df740 <vsnprintf+290/3e0>
Trace; e0bd0077 <[envy24].rodata.end+1258/3c21>
Trace; e0bd008f <[envy24].rodata.end+1270/3c21>
Trace; c0176648 <get_random_bytes+28/40>
Trace; c0177336 <secure_tcp_sequence_number+46/c0>
Trace; c01c9dc0 <tcp_v4_conn_request+400/480>
Trace; c01addd4 <qdisc_restart+14/d0>
Trace; c01a78fe <dev_queue_xmit+fe/260>
Trace; c01b7760 <ip_finish_output2+0/d0>
Trace; c01b77e3 <ip_finish_output2+83/d0>
Trace; c01ad51a <nf_hook_slow+aa/130>
Trace; c01ad54c <nf_hook_slow+dc/130>
Trace; c01b7700 <ip_finish_output+b0/100>
Trace; c01b6434 <ip_output+114/120>
Trace; c01c48e7 <tcp_transmit_skb+507/5c0>
Trace; c01a46cb <kfree_skbmem+b/60>
Trace; c01df740 <vsnprintf+290/3e0>
Trace; e0bd0077 <[envy24].rodata.end+1258/3c21>
Trace; c01c3a13 <tcp_rcv_state_process+73/937>
Trace; c01df8e2 <sprintf+12/20>
Trace; c01ca07c <tcp_v4_hnd_req+3c/190>
Trace; c01ca38d <tcp_v4_do_rcv+bd/100>
Trace; c01ca73d <tcp_v4_rcv+36d/590>
Trace; c01ad24b <nf_iterate+2b/80>
Trace; c01b4013 <ip_local_deliver_finish+b3/130>
Trace; c01b3f60 <ip_local_deliver_finish+0/130>
Trace; c01ad51a <nf_hook_slow+aa/130>
Trace; c01b3f60 <ip_local_deliver_finish+0/130>
Trace; c01ad54c <nf_hook_slow+dc/130>
Trace; c01b4090 <ip_rcv_finish+0/1a0>
Trace; c01b3bf7 <ip_local_deliver+167/180>
Trace; c01b3f60 <ip_local_deliver_finish+0/130>
Trace; c01b4090 <ip_rcv_finish+0/1a0>
Trace; c01b4090 <ip_rcv_finish+0/1a0>
Trace; c01b41f8 <ip_rcv_finish+168/1a0>
Trace; c01b4090 <ip_rcv_finish+0/1a0>
Trace; c01ad51a <nf_hook_slow+aa/130>
Trace; c01b4090 <ip_rcv_finish+0/1a0>
Trace; c01ad54c <nf_hook_slow+dc/130>
Trace; c0109cbc <do_IRQ+9c/b0>
Trace; c01b3f2c <ip_rcv+31c/350>
Trace; c01b4090 <ip_rcv_finish+0/1a0>
Trace; e0a641c1 <[tulip]tulip_interrupt+691/6f0>
Trace; c01a7e58 <net_rx_action+138/210>
Trace; c0109b19 <handle_IRQ_event+39/60>
Trace; c011d29b <do_softirq+4b/90>
Trace; c0109cbc <do_IRQ+9c/b0>
Trace; c0106c60 <default_idle+0/30>
Trace; c0106c60 <default_idle+0/30>
Trace; c010bc68 <call_do_IRQ+5/d>
Trace; c0106c60 <default_idle+0/30>
Trace; c0106c60 <default_idle+0/30>
Trace; c0106c83 <default_idle+23/30>
Trace; c0106d02 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  c01169ac <schedule+4c/300>
00000000 <_EIP>:
Code;  c01169ac <schedule+4c/300>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01169ae <schedule+4e/300>
   2:   43                        inc    %ebx
Code;  c01169af <schedule+4f/300>
   3:   02 42 da                  add    0xffffffda(%edx),%al
Code;  c01169b2 <schedule+52/300>
   6:   1e                        push   %ds
Code;  c01169b3 <schedule+53/300>
   7:   c0 5b fa 8b               rcrb   $0x8b,0xfffffffa(%ebx)
Code;  c01169b7 <schedule+57/300>
   b:   55                        push   %ebp
Code;  c01169b8 <schedule+58/300>
   c:   f0 83 7a 28 02            lock cmpl $0x2,0x28(%edx)
Code;  c01169bd <schedule+5d/300>
  11:   75 40                     jne    53 <_EIP+0x53> c01169ff
<schedule+9f/300>
Code;  c01169bf <schedule+5f/300>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--- 8< ---

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

