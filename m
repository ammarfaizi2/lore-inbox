Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263978AbRFMNDV>; Wed, 13 Jun 2001 09:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbRFMNDM>; Wed, 13 Jun 2001 09:03:12 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:36847 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S263978AbRFMNDE>; Wed, 13 Jun 2001 09:03:04 -0400
Date: Wed, 13 Jun 2001 12:07:49 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OPPS] 2.4.6-pre2
Message-ID: <Pine.LNX.4.30.0106131206550.1925-100000@beast.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

this happens every time during boot on 2.4.6-pre2


ksymoops 2.3.7 on i586 2.4.6-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.4.6-pre1/ (default)
     -m P200-2.4.6-pre2/System.map (specified)

No modules in ksyms, skipping objects
CPU:    0
EIP:    0010:[<c01182d9>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001d   ebx: c02c3b80   ecx: 00000001   edx: c025d5a8
esi: c02c3b80   edi: 00000000   ebp: 00000001   esp: c0271f2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0271000)
Stack: c02158a2 c021595e 000000ce 00000009 c02a85c0 c02a6900 c025caa0 c01180db
       c02a85c0 c0271f70 00000000 c010828c c0266b20 c0271fb3 0000038f c0271fb4
       c0106d00 c0266b20 00000000 0000038f c0271fb3 0000038f c0271fb4 c02bc600
Call Trace: [<c02158a2>] [<c021595e>] [<c02a85c0>] [<c02a6900>] [<c025caa0>] [<c01180db>] [<c02a85c0>]
       [<c0271f70>] [<c010828c>] [<c0266b20>] [<c0271fb3>] [<c0271fb4>] [<c0106d00>] [<c0266b20>] [<c0271fb3>]
       [<c0271fb4>] [<c02bc600>] [<c0260018>] [<c01149ed>] [<c0271fb4>] [<ff000000>] [<2072756f>] [<2b414756>]
       [<78303820>] [<69727943>] [<c0105000>] [<c027faaa>] [<c0266b20>] [<c02727df>] [<c02a8fc0>] [<c020bccd>]
       [<c02c3160>] [<c0271ff4>] [<c020bde0>] [<c02a8fc0>] [<69727943>] [<c0100197>]
Code: 0f 0b 83 c4 0c 8b 43 08 85 c0 75 12 fb 8b 53 10 52 ff 53 0c

>>EIP; c01182d9 <tasklet_hi_action+69/b0>   <=====
Trace; c02158a2 <call_spurious_interrupt+78aa/8248>
Trace; c021595e <call_spurious_interrupt+7966/8248>
Trace; c02a85c0 <softirq_vec+0/100>
Trace; c02a6900 <irq_desc+0/1c00>
Trace; c025caa0 <irq0+0/18>
Trace; c01180db <do_softirq+4b/70>
Trace; c02a85c0 <softirq_vec+0/100>
Trace; c0271f70 <init_task_union+1f70/2000>
Trace; c010828c <do_IRQ+9c/b0>
Trace; c0266b20 <sercons+0/40>
Trace; c0271fb3 <init_task_union+1fb3/2000>
Trace; c0271fb4 <init_task_union+1fb4/2000>
Trace; c0106d00 <ret_from_intr+0/20>
Trace; c0266b20 <sercons+0/40>
Trace; c0271fb3 <init_task_union+1fb3/2000>
Trace; c0271fb4 <init_task_union+1fb4/2000>
Trace; c02bc600 <serial_termios_locked+e0/100>
Trace; c0260018 <ext2_aops+18/20>
Trace; c01149ed <register_console+22d/240>
Trace; c0271fb4 <init_task_union+1fb4/2000>
Trace; ff000000 <END_OF_CODE+3ed28e94/????>
Trace; 2072756f Before first symbol
Trace; 2b414756 Before first symbol
Trace; 78303820 Before first symbol
Trace; 69727943 Before first symbol
Trace; c0105000 <prepare_namespace+0/10>
Trace; c027faaa <serial_console_init+a/10>
Trace; c0266b20 <sercons+0/40>
Trace; c02727df <start_kernel+4f/120>
Trace; c02a8fc0 <command_line+0/100>
Trace; c020bccd <_etext+651/1ae4>
Trace; c02c3160 <saved_command_line+0/100>
Trace; c0271ff4 <init_task_union+1ff4/2000>
Trace; c020bde0 <_etext+764/1ae4>
Trace; c02a8fc0 <command_line+0/100>
Trace; 69727943 Before first symbol
Trace; c0100197 <L6+0/2>
Code;  c01182d9 <tasklet_hi_action+69/b0>
00000000 <_EIP>:
Code;  c01182d9 <tasklet_hi_action+69/b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01182db <tasklet_hi_action+6b/b0>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c01182de <tasklet_hi_action+6e/b0>
   5:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c01182e1 <tasklet_hi_action+71/b0>
   8:   85 c0                     test   %eax,%eax
Code;  c01182e3 <tasklet_hi_action+73/b0>
   a:   75 12                     jne    1e <_EIP+0x1e> c01182f7 <tasklet_hi_action+87/b0>
Code;  c01182e5 <tasklet_hi_action+75/b0>
   c:   fb                        sti
Code;  c01182e6 <tasklet_hi_action+76/b0>
   d:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c01182e9 <tasklet_hi_action+79/b0>
  10:   52                        push   %edx
Code;  c01182ea <tasklet_hi_action+7a/b0>
  11:   ff 53 0c                  call   *0xc(%ebx)

Kernel panic: Aiee, killing interrupt handler!

1115 warnings issued.  Results may not be reliable.

-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
 12:00pm  up 25 min,  2 users,  load average: 0.00, 0.00, 0.00

