Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbTISU1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTISU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:27:37 -0400
Received: from uni04mr.unity.ncsu.edu ([152.1.1.167]:60586 "EHLO
	uni04mr.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S261703AbTISU1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:27:35 -0400
Message-ID: <00fe01c37eec$d28be130$8c330e98@nanegrc>
From: "Lisong Xu" <lxu2@unity.ncsu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: Intel PRO/1000 NIC
Date: Fri, 19 Sep 2003 16:30:10 -0400
Organization: NC State University
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just in case you have a similar problem.

The possible reason is that the on-board Inter 1000 chip of Dell PowerEdge
1600SC is Intel 82540EM, which is running PCI 32/33 or PCI 32/66.

Lisong

----- Original Message ----- 
From: Lisong Xu
To: netdev@oss.sgi.com ; linux-kernel@vger.kernel.org
Sent: Monday, September 15, 2003 10:35 AM
Subject: Intel PRO/1000 NIC


Hello,

I am sending UDP data from one PC to another PC directly through a cross
cable. The NIC of sender is Intel® PRO/1000 MT Server Adapter, and the NIC
of receiver is on-board Intel PRO/1000 (Dell PowerEdge 1600SC).

After tuning the kernel and driver parameters, the sender can send data at
1Gbps. But the receiver can only receive data at 620Mbps. (see the following
ifconfig messages, 30 seconds test)

*********** Sender *******************
eth1      Link encap:Ethernet  HWaddr 00:07:E9:17:84:36
          inet addr:192.168.1.100  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:9000  Metric:1
          RX packets:111 errors:0 dropped:0 overruns:0 frame:0
          TX packets:418072 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:30000
          RX bytes:26193 (25.5 Kb)  TX bytes:3759596626 (3585.4 Mb)
          Interrupt:24 Base address:0xccc0 Memory:fcd00000-fcd20000
**************Receiver***********************
eth0      Link encap:Ethernet  HWaddr 00:C0:9F:1E:3A:46
          inet addr:192.168.1.101  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:9000  Metric:1
          RX packets:261355 errors:156688 dropped:156688 overruns:156688
frame:0   <---- Look here!!!!!
          TX packets:97 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:30000
          RX bytes:2350019728 (2241.1 Mb)  TX bytes:22821 (22.2 Kb)
          Interrupt:11 Base address:0xecc0 Memory:fe100000-fe120000
***************************************************

My questions is why so many packets are "errors, dropped, overruns". I have
adjusted the "TxDescriptors, RxDescriptors, RxIntDelay,
RxAbsIntDelay, TxIntDelay, TxAbsIntDelay" for different values, but always
got similar result.

Maybe here is not the right email list to send, but I am really frustrated
with this problems, and hope to get some suggestions from the experts
here.Any suggestion is really appreciated!

Lisong

