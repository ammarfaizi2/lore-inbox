Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132485AbRDQAzF>; Mon, 16 Apr 2001 20:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRDQAyw>; Mon, 16 Apr 2001 20:54:52 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:18952 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S132484AbRDQAyo>; Mon, 16 Apr 2001 20:54:44 -0400
Date: Mon, 16 Apr 2001 17:54:41 -0700 (PDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Is printing broke on sparc ?
Message-ID: <Pine.LNX.4.32.0104161752010.18324-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All , On Linux-Sparc I can send data to the /dev/par0 &
	/dev/lp0 but the data appears to be garbled .

	Sending the below printcap to either of the above ports ...
<begin printcap>
# /etc/printcap
#
# Please don't edit this file directly unless you know what you are doing!
# Be warned that the control-panel printtool requires a very strict format!
# Look at the printcap(5) man page for more info.
#
# This file can be edited with the printtool in the control-panel.

##PRINTTOOL3## LOCAL POSTSCRIPT 300x300 letter {} PostScript Default {}
lp:\
	:sd=/var/spool/lpd/lp:\
	:mx#0:\
	:sh:\
	:lp=/dev/lp0:\
	:if=/var/spool/lpd/lp/filter:
<end printcap>

	.. ie:  cat /etc/printcap > /dev/lp0    (or /dev/par0)
	gets me :

/c#eodiecnyotai rhernili s to rpaemn
                                    s eehpo o-.ROLPR0 roif{\=sl:x
                                                                 	/p:ao/lr
	which is where it rolls off the paper .
	printer is a DECLaser 2200  .  I have the PostScript option card
	for it , but when it is installed -notthing- gets output so I
	tried the above experiment without it installed .  With the option
	installed the display shows 'PS Waiting' Then shortly 'PS
	Processing' then 'PS Ready' .  This happens whether I cat .ps
	files or not .  I beleive that something is garbling the data
	being sent .

	I did have this running quite well off of a i386 running linux
	not to long ago .  So I have to be doing something wrong .

	ANy help appreciated .  Tia ,  JimL

	Options turned on in the .config

CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
CONFIG_PARPORT_SUNBPP=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

CONFIG_PRINTER=y

	# dmesg | grep -b1 par

1135-Starting kswapd v1.8
1156:parport0: sunbpp at 0x1ffec800000
1190:parport0: cpp_mux: aa55f00f52ad51(18)
1228:parport0: cpp_daisy: aa5500ff(18)
1262:parport0: assign_addrs: aa5500ff(18)
1299:parport0: cpp_mux: aa55f00f52ad51(98)
1337:parport0: cpp_daisy: aa5500ff(98)
1371:parport0: assign_addrs: aa5500ff(98)
1408-Console: switching to colour frame buffer device 128x54
--
1527-pty: 256 Unix98 ptys configured
1559:lp0: using parport0 (interrupt-driven).
1599-block: queued sectors max/low 203466kB/72394kB, 640 slots per queue



       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+


