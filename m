Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbTBJLoH>; Mon, 10 Feb 2003 06:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267681AbTBJLoH>; Mon, 10 Feb 2003 06:44:07 -0500
Received: from mail.gmx.net ([213.165.65.60]:45122 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267672AbTBJLoD>;
	Mon, 10 Feb 2003 06:44:03 -0500
Date: Mon, 10 Feb 2003 12:53:42 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Cisco Aironet 340 oops with 2.4.20
Message-Id: <20030210125342.4462c25b.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

I hope you are the right person for this problem. I've found your E-Mail address in the code..

I use the kernel pcmcia driver for the aironet-card. Every time when I copy some larger files over the net with samba, scp or nfs, I get a kernel-oops. After that my keyboard hangs and I have to reboot. Alt-SysRq-XY still works. Today I saw (In xosview) that the keyboard still generates Interrupts.
With Kernel 2.4.19 there are no such problems..

Thank you.

Kind regards

Marc

ksymoops -m /boot/System.map oops3.txt
ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

Feb  3 11:24:55 vaio kernel: Warning: kfree_skb passed an skb still on a list (from c0121fca).
Feb  3 11:24:55 vaio kernel: kernel BUG at skbuff.c:315!
Feb  3 11:24:55 vaio kernel: invalid operand: 0000
Feb  3 11:24:55 vaio kernel: CPU:    0
Feb  3 11:24:55 vaio kernel: EIP:    0010:[__kfree_skb+324/352]    Not tainted
Feb  3 11:24:55 vaio kernel: EIP:    0010:[<c026cd54>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Feb  3 11:24:55 vaio kernel: EFLAGS: 00010286
Feb  3 11:24:55 vaio kernel: eax: 00000045   ebx: cb41fbe0   ecx: cba0e000   edx: cba0ff7c
Feb  3 11:24:55 vaio kernel: esi: c1339f84   edi: 00000000   ebp: c1338000   esp: c1339f6c
Feb  3 11:24:55 vaio kernel: ds: 0018   es: 0018   ss: 0018
Feb  3 11:24:55 vaio kernel: Process keventd (pid: 2, stackpage=c1339000)
Feb  3 11:24:55 vaio kernel: Stack: c0314840 c0121fca 00000000 c1339f84 c0121fca cb41fbe0 cb5142e4 cb5142e4
Feb  3 11:24:55 vaio kernel:        00000000 00000000 c012ac83 c032abd0 c1339fb0 00000000 c1338560 c1338570
Feb  3 11:24:55 vaio kernel:        c1338000 00000001 00000000 cffe5f90 00010000 00000000 00000700 c012ab50
Feb  3 11:24:55 vaio kernel: Call Trace:    [__run_task_queue+90/112] [__run_task_queue+90/112] [context_thread+307/448] [context_thread+0/448] [rest_init+0/64]
Feb  3 11:24:55 vaio kernel: Call Trace:    [<c0121fca>] [<c0121fca>] [<c012ac83>] [<c012ab50>] [<c0105000>]
Feb  3 11:24:55 vaio kernel:   [<c010749e>] [<c012ab50>]
Feb  3 11:24:55 vaio kernel: Code: 0f 0b 3b 01 cf 2d 31 c0 8b 5c 24 14 e9 be fe ff ff 90 8d 76


>>EIP; c026cd54 <__kfree_skb+144/160>   <=====

>>ebx; cb41fbe0 <_end+b073014/10826494>
>>ecx; cba0e000 <_end+b661434/10826494>
>>edx; cba0ff7c <_end+b6633b0/10826494>
>>esi; c1339f84 <_end+f8d3b8/10826494>
>>ebp; c1338000 <_end+f8b434/10826494>
>>esp; c1339f6c <_end+f8d3a0/10826494>

Trace; c0121fca <__run_task_queue+5a/70>
Trace; c0121fca <__run_task_queue+5a/70>
Trace; c012ac83 <context_thread+133/1c0>
Trace; c012ab50 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c010749e <kernel_thread+2e/40>
Trace; c012ab50 <context_thread+0/1c0>

Code;  c026cd54 <__kfree_skb+144/160>
00000000 <_EIP>:
Code;  c026cd54 <__kfree_skb+144/160>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c026cd56 <__kfree_skb+146/160>
   2:   3b 01                     cmp    (%ecx),%eax
Code;  c026cd58 <__kfree_skb+148/160>
   4:   cf                        iret
Code;  c026cd59 <__kfree_skb+149/160>
   5:   2d 31 c0 8b 5c            sub    $0x5c8bc031,%eax
Code;  c026cd5e <__kfree_skb+14e/160>
   a:   24 14                     and    $0x14,%al
Code;  c026cd60 <__kfree_skb+150/160>
   c:   e9 be fe ff ff            jmp    fffffecf <_EIP+0xfffffecf>
Code;  c026cd65 <__kfree_skb+155/160>
  11:   90                        nop
Code;  c026cd66 <__kfree_skb+156/160>
  12:   8d 76 00                  lea    0x0(%esi),%esi
