Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266499AbRGGPoa>; Sat, 7 Jul 2001 11:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266500AbRGGPoV>; Sat, 7 Jul 2001 11:44:21 -0400
Received: from logger.gamma.ru ([194.186.254.23]:52743 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S266499AbRGGPoL>;
	Sat, 7 Jul 2001 11:44:11 -0400
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: 2.4.6 + MediaGX = kernel panic
Date: 7 Jul 2001 19:23:51 +0400
Organization: Average
Message-ID: <9i79i7$v2i$1@pccross.average.org>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Casio Fiva 102 which is a mini notebook based on Cyrix MediaGX
(clone) chipset.  2.4.5 runs like a charm, but 2.4.6, immediately
after starting, displays this:

zone(0): 4096 pages.
zone(1): 11648 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=304 sb=0x220,5,1,5
Initializing CPU#0
Working around Cyrix MediaGX virtual DMA bugs
Console: colour VGA+ 80x25
kernel BUG at softirq.c:206!

== The rest of the output is passed through ksymoops:

ksymoops 2.3.3 on i586 2.4.5.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (default)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113f0e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001d   ebx: c0253b20   ecx: 00000001   edx: c01fce68
esi: c0253b20   edi: 00000001   ebp: 00000000   esp: c020befc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c020b000)
Stack: c01d1caa c01d1d26 000000ce 00000009 c023d5c0 c023d5c0 c020bf40 c0113d1f
       c023d5c0 00000000 c023b900 00000000 c010807d c0201e60 c020bf9f 000002d4
       c01fca40 000002d4 c0106d80 c0201e60 00000000 000002d4 c020bf9f 000002d4
Call trace: [<c0113d1f>] [<c010807d>] [<c0106d80>] [<c011092f>] [<c0105000>]
Code: 0f 0b 83 c4 0c 8b 43 08 85 c0 75 18 fb 8b 43 10 50 8b 43 0c

>>EIP; c0113f0e <tasklet_hi_action+6a/b4>   <=====
Trace; c0113d1f <do_softirq+3f/68>
Trace; c010807d <do_IRQ+9d/b0>
Trace; c0106d80 <ret_from_intr+0/7>
Trace; c011092f <register_console+22b/234>
Trace; c0105000 <_stext+0/0>
Code;  c0113f0e <tasklet_hi_action+6a/b4>
0000000000000000 <_EIP>:
Code;  c0113f0e <tasklet_hi_action+6a/b4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0113f10 <tasklet_hi_action+6c/b4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0113f13 <tasklet_hi_action+6f/b4>
   5:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c0113f16 <tasklet_hi_action+72/b4>
   8:   85 c0                     test   %eax,%eax
Code;  c0113f18 <tasklet_hi_action+74/b4>
   a:   75 18                     jne    24 <_EIP+0x24> c0113f32 <tasklet_hi_action+8e/b4>
Code;  c0113f1a <tasklet_hi_action+76/b4>
   c:   fb                        sti    
Code;  c0113f1b <tasklet_hi_action+77/b4>
   d:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c0113f1e <tasklet_hi_action+7a/b4>
  10:   50                        push   %eax
Code;  c0113f1f <tasklet_hi_action+7b/b4>
  11:   8b 43 0c                  mov    0xc(%ebx),%eax

Kernel panic: Aiee, killing interrupt handler!

Tell me if I can provide more information

Eugene
