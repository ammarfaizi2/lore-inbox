Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136713AbREHAlQ>; Mon, 7 May 2001 20:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136716AbREHAlF>; Mon, 7 May 2001 20:41:05 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:28080 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S136713AbREHAkw>; Mon, 7 May 2001 20:40:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: oops with 2.4.5-pre1
Date: Mon, 7 May 2001 20:40:52 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01050720405200.01265@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

After 4 days of uptime I got the following oops.  Nothing special was happening
at the time.  

Ideas?

Ed Tomlinson <tomlins@cam.org>

ksymoops 2.4.1 on i586 2.4.5-pre1.  Options used
     -V (default)
     -k 20010507195318.ksyms (specified)
     -l 20010507195318.modules (specified)
     -o /lib/modules/2.4.5-pre1/ (default)
     -m /boot/System.map-2.4.5-pre1 (default)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 00008528
c01b4612
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b4612>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: d1dc8d20   ebx: 00008528   ecx: 00000000   edx: 00008528
esi: c0d76ea0   edi: d1dc85c0   ebp: 00000060   esp: c023bddc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c023b000)
Stack: fffff900 c01b46bb c0d76ea0 fffff900 c0d76ea0 c01b4c63 c0d76ea0 c0d76ea0 
       d3eac800 d19eb0a0 d3eac800 ffffffe6 c01b7ad6 c0d76ea0 00000002 c62af280 
       c0d76ea0 c01bac03 c0d76ea0 c0d76ea0 00000000 00000004 c01c4b5c c01c4lcl 
Call Trace: [<c01b46bb>] [<c01b4c63>] [<c01b7ad6>] [<c01bac03>] [<c01c4b5c>] [<c01c4bd5>] [<c01bccaf>] 
       [<c01c234c>] [<c01c4b42>] [<c01c4b5c>] [<c01c239a>] [<c01bccaf>] [<c01c22f8> 4[<c01c234c]1 [<c01c1618>] 
       [<c01c176b>] [<c01c1618>] [<c01bccaf>] [<c01c1475>] [<c01c1618>] [<c01b806b>] [<c0115490>] [<c0107ed2>] 
       [<c01051f0>] [<c0106bf0>] [<c01051f0>] [<c0105213>] [<c0105277>] [<c0105000>] [<c0100197>] 
Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09 

>>EIP; c01b4612 <skb_drop_fraglist+1a/40>   <=====
Trace; c01b46bb <skb_release_data+5f/70>
Trace; c01b4c63 <skb_linearize+cb/12c>
Trace; c01b7ad6 <dev_queue_xmit+26/1e4>
Trace; c01bac03 <neigh_resolve_output+113/184>
Trace; c01c4b5c <ip_finish_output2+0/b4>
Trace; c01c4bd5 <ip_finish_output2+79/b4>
Trace; c01bccaf <nf_hook_slow+e7/130>
Trace; c01c234c <ip_forward_finish+0/54>
Trace; c01c4b42 <ip_finish_output+e2/e8>
Trace; c01c4b5c <ip_finish_output2+0/b4>
Trace; c01c239a <ip_forward_finish+4e/54>
Trace; c01bccaf <nf_hook_slow+e7/130>
Trace; c01c22f8 <ip_forward+188/1dc>
Trace; c01c176b <ip_rcv_finish+153/188>
Trace; c01c1618 <ip_rcv_finish+0/188>
Trace; c01bccaf <nf_hook_slow+e7/130>
Trace; c01c1475 <ip_rcv+305/33c>
Trace; c01c1618 <ip_rcv_finish+0/188>
Trace; c01b806b <net_rx_action+13b/218>
Trace; c0115490 <do_softirq+40/64>
Trace; c0107ed2 <do_IRQ+a2/b0>
Trace; c01051f0 <default_idle+0/28>
Trace; c0106bf0 <ret_from_intr+0/20>
Trace; c01051f0 <default_idle+0/28>
Trace; c0105213 <default_idle+23/28>
Trace; c0105277 <cpu_idle+3f/54>
Trace; c0105000 <do_linuxrc+0/dc>
Trace; c0100197 <L6+0/2>
Code;  c01b4612 <skb_drop_fraglist+1a/40>
00000000 <_EIP>:
Code;  c01b4612 <skb_drop_fraglist+1a/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c01b4614 <skb_drop_fraglist+1c/40>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c01b4617 <skb_drop_fraglist+1f/40>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c01b461a <skb_drop_fraglist+22/40>
   8:   74 0a                     je     14 <_EIP+0x14> c01b4626 <skb_drop_fraglist+2e/40>
Code;  c01b461c <skb_drop_fraglist+24/40>
   a:   ff 4a 70                  decl   0x70(%edx)
Code;  c01b461f <skb_drop_fraglist+27/40>
   d:   0f 94 c0                  sete   %al
Code;  c01b4622 <skb_drop_fraglist+2a/40>
  10:   84 c0                     test   %al,%al
Code;  c01b4624 <skb_drop_fraglist+2c/40>
  12:   74 09                     je     1d <_EIP+0x1d> c01b462f <skb_drop_fraglist+37/40>

Kernel panic: Aiee, killing interrupt handler!
kernel BUG at sched.c:709!
invalid operand: 0000
