Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRCWWuG>; Fri, 23 Mar 2001 17:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131503AbRCWWty>; Fri, 23 Mar 2001 17:49:54 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:38844 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131497AbRCWWsx>; Fri, 23 Mar 2001 17:48:53 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [Panic] Linux-2.4.2ac22
Date: Fri, 23 Mar 2001 17:48:11 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01032317481101.00870@oscar>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got this with ac22...

ksymoops 2.3.7 on i586 2.4.2-ac22.  Options used
     -V (default)
     -k /var/log/ksymoops/20010323122909.ksyms (specified)
     -l /var/log/ksymoops/20010323122909.modules (specified)
     -o /lib/modules/2.4.2-ac22/ (default)
     -m /boot/System.map-2.4.2-ac22 (default)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 0000022e
c01b2b53
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b2b53>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: d2636f00   ebx: 0000022e   ecx: 00000000   edx: 0000022e
esi: d2cba0a0   edi: d2636ca0   ebp: 00000060   esp: cdee1df8
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 10662, stackpage=cdee1000)
Stack: fffffe00 c01b2bfb d2cba0a0 fffffe00 d2cba0a0 c01b310a d2cba0a0 d2cba0a0
       d3eae800 d22e02a0 d3eae800 c01b589a d2cba0a0 00000002 c56a1940 d2cba0a0
       c01b8973 d2cba0a0 d2cba0a0 00000000 00000004 c01c268c c01c2705 d2cba0a0
Call Trace: [<c01b2bfb>] [<c01b310a>] [<c01b589a>] [<c01b8973>] [<c01c268c>] [<
       [<c01bff2c>] [<c01c2672>] [<c01c268c>] [<c01bff7a>] [<c01ba937>] [<c01bf
       [<c01bf34f>] [<c01bf200>] [<c01ba937>] [<c01bf075>] [<c01bf200>] [<c01b5
       [<c0108e80>]
Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09

>>EIP; c01b2b53 <skb_drop_fraglist+17/3c>   <=====

Trace; c01b2bfb <skb_release_data+5f/70>
Trace; c01b310a <skb_linearize+7e/e0>
Trace; c01b589a <dev_queue_xmit+26/1e0>
Trace; c01b8973 <neigh_resolve_output+103/174>
Trace; c01c268c <ip_finish_output2+0/b4>
Trace; c01bff2c <ip_forward_finish+0/54>
Trace; c01c2672 <ip_finish_output+de/e4>
Trace; c01c268c <ip_finish_output2+0/b4>
Trace; c01bff7a <ip_forward_finish+4e/54>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bf34f <ip_rcv_finish+14f/180>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bf075 <ip_rcv+309/340>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c0108e80 <ret_from_intr+0/20>
Code;  c01b2b53 <skb_drop_fraglist+17/3c>
00000000 <_EIP>:
Code;  c01b2b53 <skb_drop_fraglist+17/3c>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c01b2b55 <skb_drop_fraglist+19/3c>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c01b2b58 <skb_drop_fraglist+1c/3c>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c01b2b5b <skb_drop_fraglist+1f/3c>
   8:   74 0a                     je     14 <_EIP+0x14> c01b2b67 <skb_drop_fraglist+2b/3c>
Code;  c01b2b5d <skb_drop_fraglist+21/3c>
   a:   ff 4a 70                  decl   0x70(%edx)
Code;  c01b2b60 <skb_drop_fraglist+24/3c>
   d:   0f 94 c0                  sete   %al
Code;  c01b2b63 <skb_drop_fraglist+27/3c>
  10:   84 c0                     test   %al,%al
Code;  c01b2b65 <skb_drop_fraglist+29/3c>
  12:   74 09                     je     1d <_EIP+0x1d> c01b2b70 <skb_drop_fraglist+34/3c>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.
