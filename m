Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263182AbTCLOAc>; Wed, 12 Mar 2003 09:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263183AbTCLOAb>; Wed, 12 Mar 2003 09:00:31 -0500
Received: from [199.33.245.55] ([199.33.245.55]:2965 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S263182AbTCLOAa>; Wed, 12 Mar 2003 09:00:30 -0500
Date: Wed, 12 Mar 2003 09:11:02 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: problem w/ auto negotiate & ns83820 & netgear fsm726s switch
Message-ID: <Pine.LNX.4.53.0303120908470.21265@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  I am having a dickens of a time with auto negotiation
	between a netgear fsm726s & a TrendNet TEG-PCISX+ .  Fyi ,  Which
	I bought just for this card .

	The switch reports negotiating ...
	Port Name        Link On/Off State      Rate/Duplex Flow Ctrl
	26GB Not Defined Up   On     Forwarding (10   Full) (Disabled)

	ns83820 reports ,  eth0: link now 1000F mbps, full duplex and up.

	The thruput to a 10/100 device is dismal at best .  Which
	lead me to the idea that something was wrong with negotiation .
	See (*) below .

	I have attempted to set the switch port speed/duplex/flow manually
	then I am unable to ping thru the ns83820 card .

	I am quite aware that this could well be a difficulty in the
	switch still .  So I am looking for pointers on where to look ?
 	I already tried the netgear suport site ;-} .  That is why I am
	running the lastest code for the switch (1.0.4) .

		Tia ,  JimL

# uname -a
Linux filesrv1 2.4.21-pre3 #1 SMP Sat Mar 8 13:44:59 EST 2003 i686 unknown

# dmesg | grep eth0
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
eth0: ns83820.c: 0x22c: f022100b, subsystem: 100b:f022
eth0: detected 64 bit PCI data bus.
eth0: enabling optical transceiver
eth0: ns83820 v0.20: DP83820 v1.3: 00:40:f4:66:df:ed io=0xfeafe000 irq=20 f=sg
...
eth0: link now 1000F mbps, full duplex and up.
eth0: no IPv6 routers present

cut-n-paste from serial console of ...
                        FSM726S Managed Stackable Switch
 Unit   1                 Set-up > Port Configuration

Port    Name             Link   On/Off   State        Rate/Duplex   Flow Ctrl
...
 2      Not Defined      Up       On     Forwarding   (100  Full)   (Enabled )
...
26GB    Not Defined      Up       On     Forwarding   (10   Full)   (Disabled)


(*)
# tftp filesrv1
tftp> mode binary
tftp> get getme
Received 495321088 bytes in 334.0 seconds
tftp> quit

# bc
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
scale=10
495321088/334
1482997.2694610778	< Bytes/sec
last*8
11863978.1556886224	< ~ bits/sec
quit
#

-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
