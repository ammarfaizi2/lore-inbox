Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311683AbSCTH1o>; Wed, 20 Mar 2002 02:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311688AbSCTH1f>; Wed, 20 Mar 2002 02:27:35 -0500
Received: from web10102.mail.yahoo.com ([216.136.130.52]:19575 "HELO
	web10102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311683AbSCTH1X>; Wed, 20 Mar 2002 02:27:23 -0500
Message-ID: <20020320072719.72412.qmail@web10102.mail.yahoo.com>
Date: Tue, 19 Mar 2002 23:27:19 -0800 (PST)
From: Ivan Gurdiev <ivangurdiev@yahoo.com>
Subject: Via-Rhine stalls - transmit errors
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I was unsure about the maintainer of the via-rhine
driver so I'm mailing the bug report to the kernel
list. Please cc to ivangurdiev@yahoo.com.

Problem:
My ethernet card

/proc/pci:
    Ethernet controller: VIA Technologies, Inc.
VT86C100A [Rhine 10/100] (rev 6).
      IRQ 11.

is stalling during a large scp transfer.
The card freezes for a long time, before continuing
the transfer. I receive transmit timeout messages
and "something wicked happened".
Connection is negotiated to 100BaseTx-FD.


System Information:
AMD Athlon XP 1600+, Matsonic MS8127C+ board,
VIA Apollo Kt133A/VT82C686B, 
Ethernet Controller - listed above,
Kernel 2.4.19-pre3, using the via-rhine driver.


System on the opposite end:
Sony Vaio Laptop - Pentium III Coppermine,
ethernet card: Netgear FA410TX Pcmcia
Kernel: 2.4.19-pre3 using pcnet_cs driver

Appended are sections of the log of an scp transfer
using via-rhine debug lvl 7 - /var/log/messages.

----------------

Mar 19 23:08:53 cobra kernel: eth0: Setting
full-duplex based on MII #1 link partner capability of
41e1.

....


Mar 19 23:12:15 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to 40.
Mar 19 23:12:15 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:12:15 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to 60.
Mar 19 23:12:15 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:12:16 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to 80.
Mar 19 23:12:16 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:12:21 cobra kernel: NETDEV WATCHDOG: eth0:
transmit timed out
Mar 19 23:12:21 cobra kernel: eth0: Transmit timed
out, status 0000, PHY status 
782d, resetting...
Mar 19 23:12:58 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to 40.
Mar 19 23:12:58 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:13:02 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to 60.
Mar 19 23:13:02 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:13:04 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to 80.
Mar 19 23:13:04 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:14:09 cobra kernel: NETDEV WATCHDOG: eth0:
transmit timed out
Mar 19 23:14:09 cobra kernel: eth0: Transmit timed
out, status 0000, PHY status 
782d, resetting...

....

Mar 19 23:15:09 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:15:09 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to a0.
Mar 19 23:15:09 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:15:12 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to c0.
Mar 19 23:15:12 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:15:13 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to e0.
Mar 19 23:15:13 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 19 23:15:13 cobra kernel: s 0002.
Mar 19 23:15:13 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol
d setting to e0.

_______________________________________
What could be the problem?
Thank you for your help in advance.







__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
