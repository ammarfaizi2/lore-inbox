Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135203AbRDLPTR>; Thu, 12 Apr 2001 11:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135204AbRDLPTI>; Thu, 12 Apr 2001 11:19:08 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:59922 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S135203AbRDLPTD>; Thu, 12 Apr 2001 11:19:03 -0400
Date: Thu, 12 Apr 2001 16:18:58 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: linux-kernel@vger.kernel.org
Subject: National Semiconductor DP83815
Message-ID: <Pine.LNX.4.21.0104121616560.4416-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been attempting to use Donald Becker's DP83815 driver (version
1.0.7) under the 2.2.18 kernel.

Firstly, I found that when the driver was compiled into the kernel instead
of being compiled as a module, it was redetecting the same cards
repeatedly and reregistering them.  This meant that the machine ended up
thinking it had 8 network cards.  I have produced a patch that fixes this
problem and mailed it to Donald Becker.

Secondly, there seems to be a problem with the autonegotiation (I'm not
entirely sure if this is a problem with the driver or a flaw in the
hardware).  If I plug the machine into a autonegotiating 100 Mb switch,
about 30% of the time, the driver doesn't seem to initialise the network
card corectly.  Under these circumstances, the card appears to be
initialised correctly, and can receive data.  However, despite the fact
that a tcpdump shows transmitted data, those packets never seem to make it
out onto the network.  The other 70% of the time, it seems to work
fine.  If the card doesn't come up correctly, it seems that it can always
be fixed by doing "ifconfig eth0 down ; ifconfig eth0 up".  Has anyone got
any ideas?

(The hardware I am using are Cobalt Qube 3 servers.  However, this problem
seems to affect the NetGear FA311 card too).

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


