Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVLVJKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVLVJKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 04:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVLVJKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 04:10:24 -0500
Received: from headoffice-fe1.getonit.net.au ([202.47.114.19]:48685 "EHLO
	tsvexchange.getonit.net.au") by vger.kernel.org with ESMTP
	id S965143AbVLVJKW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 04:10:22 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FW: Kernel oops v2.4.31 in e1000 network card driver.
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 22 Dec 2005 19:10:04 +1000
Message-ID: <C67FBCB411B4024382B11B96D68E49E407968C@server.local.GetOffice>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel oops v2.4.31 in e1000 network card driver.
Thread-Index: AcXwLCctHQNGj04wRESICHjFnwchmgWqjt0g
From: "Tim Warnock" <timoid@getonit.net.au>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further information to this:

Network card causing the problem is the intel quad port gigabit ethernet
pci card.
I have tested also on 2.4.27, 2.4.32 and the latest 2.6 series kernel.

Under load (10-15kpps) the network driver crashes. Under increased load
(20-30kpps) the driver will actually cause a full kernel panic and
reboot the box.

After replacing the card with a single port intel gigabit ethernet pci
card, the system has been rock stable.

According to intel, the quad port nic is based around the "Intel(r)
82546EB" controller, the single port nic is based around the "Intel(r)
82545" controller.

Are there any other known problems with Intel(r) 82546EB controller
support with the current e1000 driver?

I'm not on the list so can I please be CC'd?

Original email attached below: 

Thanks
Tim Warnock

ISP Technical Manager
GetOnIt! Nationwide Internet.
1300 88 00 97
timoid (at) getonit.net.au
------------- original message ------------------
From: Tim Warnock 
Sent: Wednesday, 23 November 2005 10:48 PM
To: 'linux-kernel@vger.kernel.org'
Subject: Kernel oops v2.4.31 in e1000 network card driver.

Any assistance to what this means?

Nov 23 21:09:40 garnet kernel: NETDEV WATCHDOG: eth2: transmit timed out
Nov 23 21:09:40 garnet kernel: Unable to handle kernel paging request at
virtual address 0003066e
Nov 23 21:09:40 garnet kernel:  printing eip:
Nov 23 21:09:40 garnet kernel: c025feb2
Nov 23 21:09:40 garnet kernel: *pde = 00000000
Nov 23 21:09:40 garnet kernel: Oops: 0000
Nov 23 21:09:40 garnet kernel: CPU:    0
Nov 23 21:09:40 garnet kernel: EIP:    0010:[skb_drop_fraglist+34/80]
Not tainted
Nov 23 21:09:40 garnet kernel: EFLAGS: 00010206
Nov 23 21:09:40 garnet kernel: eax: 00030600   ebx: 000305fa   ecx:
e905a880   edx: 000305fa
Nov 23 21:09:40 garnet kernel: esi: dd6b4680   edi: dd6b46e0   ebp:
00000bb8   esp: f7edfefc
Nov 23 21:09:40 garnet kernel: ds: 0018   es: 0018   ss: 0018
Nov 23 21:09:40 garnet kernel: Process keventd (pid: 2,
stackpage=f7edf000)
Nov 23 21:09:40 garnet kernel: Stack: c1c15900 f8a76bb8 c025ff79
dd6b4680 f8a76bb8 dd6b4680 c025ffc7 dd6b4680
Nov 23 21:09:40 garnet kernel:        d8515180 f8a76bb8 f7e4ca88
c026012e dd6b4680 c01e3cd8 f8a76000 c01e3e22
Nov 23 21:09:40 garnet kernel:        dd6b4680 00000096 f7e4c980
f7e4c980 f7e4c800 f7ede000 c01e2eac f7e4c980
Nov 23 21:09:40 garnet kernel: Call Trace:    [skb_release_data+105/160]
[kfree_skbmem+23/128] [__kfree_skb+254/352]
[e1000_clean_tx_ring+472/592] [e1000_clean_rx_ring+82/30
4]
Nov 23 21:09:40 garnet kernel:   [e1000_down+204/304]
[e1000_tx_timeout_task+22/48] [__run_task_queue+106/128]
[context_thread+478/496] [context_thread+0/496] [_stext+0/96]
Nov 23 21:09:40 garnet kernel:   [arch_kernel_thread+46/64]
[context_thread+0/496]
Nov 23 21:09:40 garnet kernel:
Nov 23 21:09:40 garnet kernel: Code: 8b 42 74 8b 1b 48 75 15 f0 83 44 24
00 00 89 14 24 e8 68 01

Kernel vanilla v2.4.31 debian stable.
Network cards are intel e1000's

Im not on the list so can I please be CC'd

Thanks
Tim Warnock

ISP Technical Manager
GetOnIt! Nationwide Internet.
1300 88 00 97
timoid (at) getonit.net.au
