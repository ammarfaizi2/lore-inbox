Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVLIL55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVLIL55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVLIL55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:57:57 -0500
Received: from host-87-74-42-126.bulldogdsl.com ([87.74.42.126]:34509 "EHLO
	shell.skyblue.eu.org") by vger.kernel.org with ESMTP
	id S932071AbVLIL54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:57:56 -0500
X-Antivirus-SKYBLUE-Mail-From: brent@skyblue.eu.org via shell
X-Antivirus-SKYBLUE: 1.25-st-qms (Clear:RC:1(82.211.73.82):. Processed in 0.045664 secs Process 20630)
From: "Brent" <brent@skyblue.eu.org>
To: <linux-kernel@vger.kernel.org>
Subject: High load since upgrade
Date: Fri, 9 Dec 2005 11:57:37 -0000
Message-ID: <000001c5fcb7$c006e820$030c0b0a@mforma.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcX8t782dvjk1ENOSJiy6uGB1UmRaA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Hope this is the right list I'm posting to but here goes.

I recently upgraded 3 servers to the stock 2.6.14.3 kernels from an older
2.4.28 kernel, all identical running debian stable and all up to date with
no outstandng updates needed to the OS.
As from these 3 graphs (all servers almost identical hardware), PIII 900, 1G
RAM, you can quite clearly see when the upgrades where made and sending the
load avg up way above the previous averages.
http://pics.skyblue.eu.org/graphs/

All these servers are only running; shorewall, squid and ntop as their
primary functions.

Before I go pasting my .config etc etc I wanted to know first off what
anyone would really like so I don't paste too much to create a really large
post. Also if it's a known issue?

But here is a quick vmstat and as can see the 'in' is rather larger than
normal I would think?
Top is not reporting anything usefull really.

/usr/src/linux-2.6.14.3# vmstat -n 1 
procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
wa
 0  0      0     26    231    364    0    0     0    13   13     4  1  2 97
0
 0  0      0     26    231    364    0    0     0     0  272    42  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  265    35  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  276    46  0  0 100
0
 0  0      0     26    231    364    0    0     0    36  290    70  0  0 100
0
 0  0      0     26    231    364    0    0     0    48  276    64  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  291    69  0  0 100
0
 0  0      0     26    231    364    0    0     0    12  266    37  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  315   120  0  0 100
0
 0  0      0     26    231    364    0    0     0     4  322   116  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  313    99  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  301    92  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  279    49  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  298    77  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  315    93  0  0 100
0
 0  0      0     26    231    364    0    0     0    36  300    74  0  0 100
0
 0  0      0     26    231    364    0    0     0     0  283    45  0  0 100
0

A list of the hardware is from lspci is:

0000:00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
0000:00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
0000:00:00.2 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
0000:00:00.3 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
0000:00:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
0000:00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
0000:00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27)
0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev
04)
0000:01:04.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev
05)
0000:02:00.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev
05)
0000:02:01.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel
Ultra3 SCSI Processor (rev 06)
0000:03:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 20)
0000:04:05.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
0000:04:05.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
0000:04:06.0 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet
Controller (rev 03)
0000:04:06.1 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet
Controller (rev 03)





