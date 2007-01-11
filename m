Return-Path: <linux-kernel-owner+w=401wt.eu-S1750914AbXAKRAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXAKRAh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbXAKRAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:00:37 -0500
Received: from postfix2-g20.free.fr ([212.27.60.43]:34388 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbXAKRAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:00:36 -0500
Message-ID: <1168534773.45a66cf58d25e@imp4-g19.free.fr>
Date: Thu, 11 Jan 2007 17:59:33 +0100
From: castet.matthieu@free.fr
To: e1000-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: e1000 : link down issues
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 82.120.200.254
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got a 82566DM e1000 network controller [1] on my motherboard, and most of the
time the link go down when doing dhcp. [2]

ifconfig eth0 up -> link become up
dhclient eth0 -> some packet are transmited and received and the link become
down.



I sometimes got e1000_reset: Hardware Error.

This happen with vanilla 2.6.19 and e1000-7.3.20 drivers.

This is very anoying because I should do rmmod e1000; modprobe e1000; ifup e1000
in loop until the link stay up.
I try forcing speed, duplex and flow control, but nothing solve my issue.

The device is working fine on windows.

What should I do ?

Thanks.


Matthieu CASTET


[1]
00:19.0 0200: 8086:104a (rev 02)
        Subsystem: 103c:2800

[2]
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
None
e1000: eth0: e1000_watchdog: NIC Link is Down
e1000: 0000:00:19.0: e1000_validate_option: Flow Control Disabled
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:0f:fe:77:08:a1
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
None
e1000: eth0: e1000_watchdog: NIC Link is Down
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:0f:fe:77:08:a1
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
RX
e1000: eth0: e1000_watchdog: NIC Link is Down
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:0f:fe:77:08:a1
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
RX
e1000: eth0: e1000_watchdog: NIC Link is Down
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:0f:fe:77:08:a1
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
None
e1000: eth0: e1000_watchdog: NIC Link is Down
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
None
