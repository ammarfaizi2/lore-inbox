Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292367AbSB0Npg>; Wed, 27 Feb 2002 08:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292408AbSB0Np1>; Wed, 27 Feb 2002 08:45:27 -0500
Received: from krynn.axis.se ([193.13.178.10]:59304 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S292239AbSB0NpP>;
	Wed, 27 Feb 2002 08:45:15 -0500
Date: Wed, 27 Feb 2002 14:45:08 +0100 (CET)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: linux-kernel@vger.kernel.org
Subject: What is TCPRenoRecoveryFail ?
Message-ID: <Pine.LNX.3.96.1020227144128.18713E-100000@fafner.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a TCP connection that is sending bulk data from a Linux 2.4.17
machine to a client. At some point, one of the packets from the Linux
machine is lost, so the client asks for a retransmit by acking the last
received correct packet. Then the Linux machine just keeps filling the
clients open window, ignoring that and subsequent retransmit requests,
never retransmitting any data.

Around the time of the packet loss happened, the counter
TCPRenoRecoveryFail increased by one, but I'm not sufficiently into the
TCP code to figure out why that happens and if that is the reason why
Linux stop retransmitting anything.. any ideas ?

The client is a Windows machine, but the packets it sends does not seem
broken in any way. 

/BW

