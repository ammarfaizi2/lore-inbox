Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271438AbTGQLzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271440AbTGQLzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:55:14 -0400
Received: from 152.46-136-217.adsl.skynet.be ([217.136.46.152]:30215 "EHLO
	obelix.village-gaulois") by vger.kernel.org with ESMTP
	id S271438AbTGQLzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:55:04 -0400
Subject: a crash of the 2.4.20 when I do emerge dia
From: Arnaud Ligot <spyroux@freegates.be>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1058443775.1350.15.camel@portable>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jul 2003 14:09:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I manage to crash the kernel 2.4.20 of my gento three times. 
I have probably an error in my gentoo installation but the kernel
couldn't crash as it do.
This is theway to crash my wrk:
in a gnome-terminal, I do emerge dia.
in the configure script he write an error, (it cannot verify a header
file).
The load  to 3.5 and more so I do Ctrl-C. It write it recieve the signal
but don't stop. I try to kill the ./configure script or the python
emerge script with kill -KILL pid but that didn't work. I switch my wrk
to console with C-M-F1, and CRASH ;-) The local display freeze If i try
to log on, the kernel continue to route normaly the packet and I can log
on with ssh but ...

arnaud@gentoo arnaud $ uptime
 15:10:28 up  2:11,  0 users,  load average: 9.99, 8.42, 4.53

arnaud@gentoo arnaud $ w
 15:10:38 up  2:11,  0 users,  load average: 9,99, 8,47, 4,59
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT

and the dmesg write this : 
kernel BUG at namei.c:1088!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c018f0ce>]    Not tainted
EFLAGS: 00010297
eax: 00000000   ebx: ffffffff   ecx: c44a3e58   edx: 00000000
esi: c44a3d18   edi: c44a3df8   ebp: c44a3dd8   esp: c44a3c78
ds: 0018   es: 0018   ss: 0018
Process gcc (pid: 2485, stackpage=c44a3000)
Stack: 00000000 00000000 00000004 c44a3d14 c44a3cb4 0000000f c44a3ef0
81a40a70 
       00000000 00000000 c2f4cac0 c44a3cd4 c02deec7 00000001 00000039
0000c2e1 
       c7f89c00 00001001 ffffffff 00000000 c01a0a70 c44a3d48 00000000
00000001 
Call Trace:    [<c01a0a70>] [<c01280a7>] [<c0136820>] [<c018d4e2>]
[<c0140671>]
  [<c01408ee>] [<c0141139>] [<c01409ae>] [<c0108ce3>]

Code: 0f 0b 40 04 43 e9 2d c0 8b 84 24 e0 01 00 00 8b 94 c4 e4 01 

I cannot log out normaly my ssh session...

contact me for more information...
Arnaud

-- 
Arnaud Ligot <spyroux@freegates.be>

