Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135811AbRDYFzy>; Wed, 25 Apr 2001 01:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135813AbRDYFzo>; Wed, 25 Apr 2001 01:55:44 -0400
Received: from falconweb.com ([207.227.90.66]:50045 "EHLO ns.falconweb.com")
	by vger.kernel.org with ESMTP id <S135811AbRDYFzc>;
	Wed, 25 Apr 2001 01:55:32 -0400
From: "Andrew B. Cramer" <andrew.cramer@cramer-ts.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2001 00:55:40 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: routing & ipchains
Reply-to: andrew.cramer@cramer-ts.com
Message-ID: <3AE6208C.8379.146C84FE@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings All,
	After upgrading from kernel 2.0.38 w/ slackware-3.4 to
kernel 2.2.16 w/ slackware-7.1 I have developed the following
routing problems.

Hardware -
	eth0 - 10meg on net 192.168.0.0 i/f 192.168.0.1 subnet 
255.255.255.128
	eth1 - 100meg on net 192.168.0.128 i/f 192.168.0.130 subnet 
255.255.255.128

>From either network I can use ipchains and surf/telnet/ftp/... on 
each network to the ppp0 dialup connection. I cannot ping or 
anything from eth0 to eth1 or back.

---------Route with ppp0 up----------------
Destination     Gateway         Genmask         Flags Metric Ref    
Use Iface
205.243.155.100 0.0.0.0         255.255.255.255 UH    0      0        0 
ppp0
192.168.0.0     0.0.0.0         255.255.255.128 U     0      0        0 
eth1
192.168.0.128   0.0.0.0         255.255.255.128 U     0      0        0 
eth0
192.168.0.0     192.168.0.1     255.255.255.0   UG    0      0        0 
eth1
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         205.243.155.100 0.0.0.0         UG    0      0        0 
ppp0
0.0.0.0         192.168.0.1     0.0.0.0         UG    0      0        0 eth1
0.0.0.0         192.168.0.130   0.0.0.0         UG    0      0        0 eth0
-------------------End of Route Table------------------

TIA - if other files are needed, I can forward.

Best - Andy

Andrew B. Cramer - <andrew.cramer@cramer-ts.com>
Cramer Technical Services - <www.cramer-ts.com>
Linux Resource Exchange - <www.linuxrx.com>
