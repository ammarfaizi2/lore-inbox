Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313731AbSEEWGW>; Sun, 5 May 2002 18:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSEEWGV>; Sun, 5 May 2002 18:06:21 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:20818 "EHLO
	tsmtp7.mail.isp") by vger.kernel.org with ESMTP id <S313731AbSEEWGT>;
	Sun, 5 May 2002 18:06:19 -0400
Date: Mon, 6 May 2002 00:09:11 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.5.13
Message-Id: <20020506000911.58e8d857.DiegoCG@teleline.es>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This oops happens when I try to init the box (Cyrix 6x86MX 233 mhz)
IDE Chipset: Sis 5513

....
reiserfs: checking transaction log (ide1(22,6)) for (ide1(22,6))
hdc: ide_set_handler: handler not null; old=c01a542c, new=c01a5cc4, from c01a5759
bug: kernel timer added twice at c01a6672
hdc: ide_set_handler: handler not null; old=c01a542c, new=c01a5cc4, from c01a5759
bug: kernel timer added twice at c01a6672
hdc: ide_set_handler: handler not null; old=c01a542c, new=c01a5cc4, from c01a5759
bug: kernel timer added twice at c01a6672
hdc: ide_set_handler: handler not null; old=c01a542c, new=c01a5cc4, from c01a5759
bug: kernel timer added twice at c01a6672
hdc: ide_set_handler: handler not null; old=c01a542c, new=c01a5cc4, from c01a5759
bug: kernel timer added twice at c01a6672
hdc: ide_timer_expiry: hwgroup was not busy?
hc: lost interrupt
Unable to handle kernel NULL pointer dereference at virtual address 00000030
printing eip:
c01a5461
*pde=00000000
oops=0000
CPU: 0
EIP: 0010:[<c01a5461>] Not tainted
EFLAGS: 00010046
eax:c02a65f8 ebx:c0248000 ecx:00000010 edx:c01a0150
esi:c02a65f8 edi:00000000 ebp:c104ec60 esp:c0249ed0
ds:0018 es:0018 ss:0018
Process swapper (pid =0, threadinfo=c0248000 task=c0233880)
Stack: c0248000 c02a65f8 c02a6508 c104ec60 00000014 ffffec4d c0115a01 00000010
       c104ec60 c01a7dc0 c02a65f8 00000000 c021938e c02a65fc c104ec60 c01a7c3c
       c0248000 c0284ca0 00000296 c01a542c c011ce8a c104ec60 c0248000 00000000
Call trace: [<c0115a01>] [<c01a7dc0>] [<c01a7c3c>] [<c01a542c>] [<c011ce8a>]
	[<c011cf23>] [<c0119d2a>] [<c0119c56>] [<c0119a62>] [<c0108561>] [<c1050000>]
	[<c01070b2>] [<c01052c0>] [<c0105000>] [<c01052e6>] [<c0105356>] [<c0105055>]
Code: 83 7f 30 00 75 3b f6 c2 09 74 14 31 c0 88 d0 50 68 46 88 21
<0> Kernel Panic: Aieee, killing interrupt handler!
In interrupt handler - not syncing



ksymoops of message:
ksymoops 2.4.5 on i686 2.4.19-pre7-ac1.  Options used
     -V (default)
     -k /dev/null (specified)
     -l /dev/null (specified)
     -o /dev/null (specified)
     -m /boot/System.map-2.5.13 (specified)

Error (regular_file): read_ksyms /dev/null is not a regular file, ignored
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000030
c01a5461
CPU: 0
EIP: 0010:[<c01a5461>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
Stack: c0248000 c02a65f8 c02a6508 c104ec60 00000014 ffffec4d c0115a01 00000010
       c104ec60 c01a7dc0 c02a65f8 00000000 c021938e c02a65fc c104ec60 c01a7c3c
       c0248000 c0284ca0 00000296 c01a542c c011ce8a c104ec60 c0248000 00000000
Call trace: [<c0115a01>] [<c01a7dc0>] [<c01a7c3c>] [<c01a542c>] [<c011ce8a>]
        [<c011cf23>] [<c0119d2a>] [<c0119c56>] [<c0119a62>] [<c0108561>] 
[<c1050000>]
        [<c01070b2>] [<c01052c0>] [<c0105000>] [<c01052e6>] [<c0105356>] 
[<c0105055>]
Code: 83 7f 30 00 75 3b f6 c2 09 74 14 31 c0 88 d0 50 68 46 88 21


>>EIP; c01a5461 <task_mulout_intr+35/1f4>   <=====

Trace; c0115a01 <printk+129/154>
Trace; c01a7dc0 <ide_timer_expiry+184/230>
Trace; c01a7c3c <ide_timer_expiry+0/230>
Trace; c01a542c <task_mulout_intr+0/1f4>
Trace; c011ce8a <timer_bh+276/2d0>
Trace; c011cf23 <do_timer+3f/70>
Trace; c0119d2a <bh_action+26/78>
Trace; c0119c56 <tasklet_hi_action+4a/70>
Trace; c0119a62 <do_softirq+62/c8>
Trace; c0108561 <do_IRQ+e9/f8>
Trace; c1050000 <END_OF_CODE+d9f75c/????>
Trace; c01070b2 <common_interrupt+22/30>
Trace; c01052c0 <default_idle+0/2c>
Trace; c0105000 <_stext+0/0>
Trace; c01052e6 <default_idle+26/2c>
Trace; c0105356 <cpu_idle+26/38>
Trace; c0105055 <rest_init+55/58>

Code;  c01a5461 <task_mulout_intr+35/1f4>
00000000 <_EIP>:
Code;  c01a5461 <task_mulout_intr+35/1f4>   <=====
   0:   83 7f 30 00               cmpl   $0x0,0x30(%edi)   <=====
Code;  c01a5465 <task_mulout_intr+39/1f4>
   4:   75 3b                     jne    41 <_EIP+0x41> c01a54a2 <task_mulout_intr+76/1f4>
Code;  c01a5467 <task_mulout_intr+3b/1f4>
   6:   f6 c2 09                  test   $0x9,%dl
Code;  c01a546a <task_mulout_intr+3e/1f4>
   9:   74 14                     je     1f <_EIP+0x1f> c01a5480 <task_mulout_intr+54/1f4>
Code;  c01a546c <task_mulout_intr+40/1f4>
   b:   31 c0                     xor    %eax,%eax
Code;  c01a546e <task_mulout_intr+42/1f4>
   d:   88 d0                     mov    %dl,%al
Code;  c01a5470 <task_mulout_intr+44/1f4>
   f:   50                        push   %eax
Code;  c01a5471 <task_mulout_intr+45/1f4>
  10:   68 46 88 21 00            push   $0x218846

<0> Kernel Panic: Aieee, killing interrupt handler!

1 error issued.  Results may not be reliable.
