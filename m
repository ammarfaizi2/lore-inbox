Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVCJUAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVCJUAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVCJUAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:00:09 -0500
Received: from imag.imag.fr ([129.88.30.1]:45546 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262968AbVCJTcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:32:07 -0500
Date: Thu, 10 Mar 2005 20:31:19 +0100 (MET)
From: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
X-X-Sender: colbuse@ensisun
To: linux-kernel@vger.kernel.org
Subject: [CRASH] kernel 2.4.27 on sparc64 SMP (Ultrasparc I)
Message-ID: <Pine.GSO.4.40.0503102021500.27373-100000@ensisun>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 10 Mar 2005 20:31:53 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

We had yesterday a crash of our Linux sparc server.

Here is the machine's uname -a :
Linux ensilinx6 2.4.27 #2 SMP dim nov 14 18:58:56 CET 2004 sparc64
GNU/Linux


Here is the content of the screen I found today :

0000000000000 i1: 0000000000000000 i2: 0000000000000001 i3:
0000000000767b20
i4: fffff80003eeffd8 i5: 0000000000000001 i6: fffff80003eef741 i7:
000000000042ea5c
CPU[4]: local_irq_count[0] irqs_running[0]
TSTATE: 0000009980009601 TPC: 0000000000418424
TNPC: 0000000000418428 Y: ffffb8c8 Not tainted
g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000708900 g3:
000000000070B700
g4: fffff80000000000 g5: 0000000000000004 g6: fffff80001348000 g7:
0000000000000000
o0: 0000000000000000 o1: 0000000000000032 o2: fffff80052b17e58 o3:
0000000000000004
o4: fffff80052b17d80 o5: 0000000000000001 SP: fffff8000134b681 ret_pc:
0000000000418460
l0: 0000000000708700 l1: 0000000000767a38 l2: 0000000000000004 l3:
000000000065a800
l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000000f l7:
fffff8000134bfd0
i0: 0000000000000000 i1: 0000000000000000 i2: 0000000000000001 i3:
0000000000767b20
i4: fffff8000134bfd8 i5: 0000000000000001 i6: fffff8000134b741 i7:
000000000042ea5c




And here is the message I found in /var/log/messages (note that it differs
from the screen's content ) :

Mar  9 05:49:34 ensilinx6 kernel: __alloc_pages: 1-order allocation failed
(gfp=
0x20/0)
Mar  9 05:49:34 ensilinx6 kernel:               \|/ ____ \|/
Mar  9 05:49:34 ensilinx6 kernel:               "@'/ .. \`@"
Mar  9 05:49:34 ensilinx6 kernel:               /_| \__/ |_\
Mar  9 05:49:34 ensilinx6 kernel:                  \__U_/
Mar  9 05:49:35 ensilinx6 kernel: swapper(0): Kernel bad sw trap 5
Mar  9 05:49:35 ensilinx6 kernel: CPU[0]: local_irq_count[0]
irqs_running[0]
Mar  9 05:49:35 ensilinx6 kernel: TSTATE: 0000004480009600 TPC:
000000000046a350
 TNPC: 000000000046a354 Y: 00000000    Not tainted
Mar  9 05:49:35 ensilinx6 kernel: g0: 0000000000713800 g1:
000000000065f758 g2:
0000000000000001 g3: 000000000008b924
Mar  9 05:49:35 ensilinx6 kernel: g4: fffff80000000000 g5:
fffff80003ef4000 g6:
0000000000414000 g7: 0000000000000000
Mar  9 05:49:35 ensilinx6 kernel: o0: 0000000000000039 o1:
0000000000715c00 o2:
0000000000000020 o3: 0000000000000000
Mar  9 05:49:35 ensilinx6 kernel: o4: 0000000000000000 o5:
0000000000715e29 sp:
0000000000416a31 ret_pc: 000000000046a348
Mar  9 05:49:35 ensilinx6 kernel: l0: 0000000000661d80 l1:
0000000000000001 l2:
0000000000000000 l3: 0000000000000002
Mar  9 05:49:35 ensilinx6 kernel: l4: 0000000000000000 l5:
0000000000000020 l6:
0000000000661848 l7: fffff8000135c600
Mar  9 05:49:35 ensilinx6 kernel: i0: 0000000000000000 i1:
0000000000000001 i2:
0000000000661d70 i3: fffff80052b0d400
Mar  9 05:49:36 ensilinx6 kernel: i4: 0000000000000000 i5:
00000000005b5160 i6:
0000000000416b01 i7: 000000000046a398
Mar  9 05:49:36 ensilinx6 kernel: Caller[000000000046a398]
Mar  9 05:49:36 ensilinx6 kernel: Caller[0000000000466388]
Mar  9 05:49:36 ensilinx6 kernel: Caller[0000000000466ad4]
Mar  9 05:49:36 ensilinx6 kernel: Caller[000000000059bb50]
Mar  9 05:49:36 ensilinx6 kernel: Caller[0000000002035600]
Mar  9 05:49:36 ensilinx6 kernel: Caller[0000000002034280]
Mar  9 05:49:36 ensilinx6 kernel: Caller[00000000005a9ec0]
Mar  9 05:49:36 ensilinx6 kernel: Caller[00000000005aa37c]
Mar  9 05:49:36 ensilinx6 kernel: Caller[00000000005a0bc8]
Mar  9 05:49:36 ensilinx6 kernel: Caller[00000000005a0d64]
Mar  9 05:49:36 ensilinx6 kernel: Caller[00000000005a0f40]
Mar  9 05:49:36 ensilinx6 kernel: Caller[000000000044f628]
Mar  9 05:49:36 ensilinx6 kernel: Caller[000000000040ef40]
Mar  9 05:49:36 ensilinx6 kernel: Caller[0000000000418460]
Mar  9 05:49:36 ensilinx6 kernel: Caller[000000000069677c]
Mar  9 05:49:36 ensilinx6 kernel: Caller[0000000000404678]
Mar  9 05:49:36 ensilinx6 kernel: Caller[0000000000000000]
Mar  9 05:49:36 ensilinx6 kernel: Instruction DUMP: 92100011  7fff8126
94100015
 <91d02005> 106ffff7  ab356000  7fff7129  94102001  106fff73


No idea what can have happened. There was nobody on the
server at this time.

Has anybody any idea about this crash?


--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - Departement Telecoms


