Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVI0TJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVI0TJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 15:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVI0TJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 15:09:42 -0400
Received: from main.davidkarlsen.com ([217.13.8.30]:63698 "EHLO
	smtp.davidkarlsen.com") by vger.kernel.org with ESMTP
	id S965048AbVI0TJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 15:09:41 -0400
Message-ID: <433998E1.7080609@davidkarlsen.com>
Date: Tue, 27 Sep 2005 21:09:21 +0200
From: "David J. M. Karlsen" <david@davidkarlsen.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS report
Content-Type: multipart/mixed;
 boundary="------------020907000109000904040600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020907000109000904040600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I get this OOPS every time I go to runlevel S or 6 from 2:

INIT: Going single user
INIT: Sending processes the TERM signal
INUnable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000001
tsk->{mm,active_mm}->pgd = fffff800303a6000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000000080009600 TPC: 0000000000571084 TNPC: 0000000000571088 Y: 
0000000
0    Not tainted
TPC: <tty_wakeup+0x4/0x80>
g0: 0000000000001018 g1: 000000000045572c g2: 0000000000000001 g3: 
0000000000000
000
g4: 00000000006d6fc0 g5: fffff80000000000 g6: 00000000006d2fc0 g7: 
0000000000000
003
o0: 0000000000000000 o1: 0000000000000aab o2: 0000000000000001 o3: 
fffffffffffff
ef0
o4: fffff80037f07d20 o5: fffff800007b3e78 sp: 00000000006d6051 ret_pc: 
000000000
0455588
RPC: <__tasklet_schedule+0x28/0xa0>
l0: 00000000007dc0c0 l1: 000000000000000f l2: 00000000006d8000 l3: 
00000000ef9fd
588
l4: 00000000ef9fd538 l5: 0000000000000001 l6: 000000000000000a l7: 
00000000007dc
000
i0: 0000000000000000 i1: fffff80037f02a68 i2: 0000000000000001 i3: 
fffff80037f09
af0
i4: fffff80037f02a48 i5: fffff80037f02a40 i6: 00000000006d6111 i7: 
0000000000455
72c
I7: <tasklet_action+0x8c/0x120>
Caller[000000000045572c]: tasklet_action+0x8c/0x120
Caller[00000000004552d0]: __do_softirq+0xf0/0x120
Caller[0000000000455354]: do_softirq+0x54/0x80
Caller[0000000000455494]: irq_exit+0x54/0x80
Caller[0000000000408994]: tl0_irq11+0x34/0x40
Caller[00000000004149dc]: cpu_idle+0x3c/0xe0
Caller[000000000078884c]: start_kernel+0x22c/0x240
Caller[00000000004046c4]: tlb_fixup_done+0x5c/0x64
Caller[0000000000000000]: _start+0xffffffffffbfc000/0x12
Instruction DUMP: 01000000  01000000  9de3bf40 <c25e2120> b2102001  
b4102001  b6
102000  83307005  82086001
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 60 seconds..





uname -a
Linux sunshine 2.6.13 #1 SMP Sun Sep 4 23:37:10 CEST 2005 sparc64 GNU/Linux

cat /proc/cpuinfo
cpu             : TI UltraSparc I   (SpitFire)
fpu             : UltraSparc I integrated FPU
promlib         : Version 3 Revision 1
prom            : 3.1.1
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
Cpu0Bogo        : 284.67
Cpu0ClkTck      : 00000000088601c0
MMU Type        : Spitfire
State:
CPU0:           online

/proc/config.gz attached.

Is it well nown?

-- 
David J. M. Karlsen - +47 90 68 22 43
http://www.davidkarlsen.com
http://mp3.davidkarlsen.com


--------------020907000109000904040600
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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

--------------020907000109000904040600--

