Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbRGZB5g>; Wed, 25 Jul 2001 21:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbRGZB50>; Wed, 25 Jul 2001 21:57:26 -0400
Received: from dc-mxdb02.cluster0.hsacorp.net ([209.225.8.76]:34190 "EHLO
	dc-mxdb02.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S267509AbRGZB5S>; Wed, 25 Jul 2001 21:57:18 -0400
From: "Gerald Walden" <thepond@charter.net>
Subject: debug of a kernel panic leading nowhere...
Message-Id: <20010726015721Z267509-720+6404@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Date: Wed, 25 Jul 2001 21:57:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

 
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.4.6
Date: Wed, 25 Jul 2001 22:01:47 -0400
Message-ID: <web-832779@dc-mxdb02.cluster1.charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

	
Greetings:

During the rmmod of a fairly simple driver, I get a kernel
panic which crashes the system.  I believe I have taken all
the proper steps to attempt to debug the problem to no
avail.

Any suggestions as to how to move further, or how to frame
this question in a more appropriate manner for this list (or
perhaps there is a more appropriate list that I should be
sending this to) would greatly be appreciated.

Please cc me on any reply

Kindest Regards

Jerry

ksymoops 2.4.0 on i486 2.4.2-ac25.  Options used
     -v /root/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /root (specified)
     -m /root/System.map (specified)

before <1>Unable to handle kernel paging request at virtual
address 5a5a5a5e
c482424a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c482424a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a83
eax: 5a5a5a5a   ebx: c111aebc   ecx: 00000000   edx:
5a5a5a5a
esi: c34fa53c   edi: 00000001   ebp: c4823d9c   esp:
c2b41de0
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 741, stackpage=c2b41000)
Stack: c3d9adc0 c3d9ade8 00000000 c482777b 00000000 00000001
c2b41dfc ffffffff 
       00000000 00000000 00000000 c482779d 00000000 ffffffff
00000000 00000000 
       00000000 c482190f 00000000 00000000 00000000 c4854c20
c02d7a50 00000000 
Call Trace: [<c482777b>] [<c482779d>] [<c482190f>]
[<c4854c20>] [<c4823dd4>] [<c4854c20>] [<c01196b4>] 
       [<c4854c20>] [<c0116917>] [<c0116857>] [<c011675e>]
[<c0108124>] [<c0106e9c>] [<ffff0018>] [<c01920a1>] 
       [<c0190010>] [<c0112717>] [<c011277b>] [<c0112839>]
[<c0112a65>] [<c0112a03>] [<c4821000>] [<c4821000>] 
       [<c4825168>] [<c48325a3>] [<c4832580>] [<c01146bb>]
[<c4821000>] [<c0113827>] [<c4821000>] [<c0106df3>] 
Code: 8b 48 04 8b 10 89 4a 04 89 11 89 58 1c 8d 48 08 ff 40
08 0f 

>>EIP; c482424a <__module_parm_watchdog+4fd2/????>   <=====
Trace; c482777b <END_OF_CODE+8503/????>
Trace; c482779d <END_OF_CODE+8525/????>
Trace; c482190f <__module_parm_watchdog+2697/????>
Trace; c4854c20 <END_OF_CODE+359a8/????>
Trace; c4823dd4 <__module_parm_watchdog+4b5c/????>
Trace; c4854c20 <END_OF_CODE+359a8/????>
Trace; c01196b4 <timer_bh+244/284>
Trace; c4854c20 <END_OF_CODE+359a8/????>
Trace; c0116917 <bh_action+1b/68>
Trace; c0116857 <tasklet_hi_action+3b/60>
Trace; c011675e <do_softirq+4e/74>
Trace; c0108124 <do_IRQ+9c/ac>
Trace; c0106e9c <ret_from_intr+0/20>
Trace; ffff0018 <END_OF_CODE+3b7d0da0/????>
Trace; c01920a1 <serial_console_write+fd/3a4>
Trace; c0190010 <rs_read_proc+404/484>
Trace; c0112717 <__call_console_drivers+3b/4c>
Trace; c011277b <_call_console_drivers+53/58>
Trace; c0112839 <call_console_drivers+b9/ec>
Trace; c0112a65 <release_console_sem+15/74>
Trace; c0112a03 <printk+127/134>
Trace; c4821000 <__module_parm_watchdog+1d88/????>
Trace; c4821000 <__module_parm_watchdog+1d88/????>
Trace; c4825168 <__module_parm_watchdog+5ef0/????>
Trace; c48325a3 <END_OF_CODE+1332b/????>
Trace; c4832580 <END_OF_CODE+13308/????>
Trace; c01146bb <free_module+1b/a0>
Trace; c4821000 <__module_parm_watchdog+1d88/????>
Trace; c0113827 <sys_delete_module+f3/1b0>
Trace; c4821000 <__module_parm_watchdog+1d88/????>
Trace; c0106df3 <system_call+33/38>
Code;  c482424a <__module_parm_watchdog+4fd2/????>
00000000 <_EIP>:
Code;  c482424a <__module_parm_watchdog+4fd2/????>   <=====
   0:   8b 48 04                  mov    0x4(%eax),%ecx
<=====
Code;  c482424d <__module_parm_watchdog+4fd5/????>
   3:   8b 10                     mov    (%eax),%edx
Code;  c482424f <__module_parm_watchdog+4fd7/????>
   5:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  c4824252 <__module_parm_watchdog+4fda/????>
   8:   89 11                     mov    %edx,(%ecx)
Code;  c4824254 <__module_parm_watchdog+4fdc/????>
   a:   89 58 1c                  mov    %ebx,0x1c(%eax)
Code;  c4824257 <__module_parm_watchdog+4fdf/????>
   d:   8d 48 08                  lea    0x8(%eax),%ecx
Code;  c482425a <__module_parm_watchdog+4fe2/????>
  10:   ff 40 08                  incl   0x8(%eax)
Code;  c482425d <__module_parm_watchdog+4fe5/????>
  13:   0f 00 00                  sldt   (%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!
