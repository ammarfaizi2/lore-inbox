Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131595AbQLVGiL>; Fri, 22 Dec 2000 01:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbQLVGiC>; Fri, 22 Dec 2000 01:38:02 -0500
Received: from mack.rt66.com ([198.59.162.1]:21718 "EHLO Rt66.com")
	by vger.kernel.org with ESMTP id <S131506AbQLVGhv>;
	Fri, 22 Dec 2000 01:37:51 -0500
Message-Id: <l03130301b6688dc696fd@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 21 Dec 2000 22:00:50 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromatix@penguinpowered.com>
Subject: PPPoE trouble
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not entirely sure whether this is the right place to ask support questions,
but here goes...

I have set up a gateway machine running SuSE 6.4 and kernel 2.4.0-test12
for a family I am staying with in NM.  The gateway is running fine on a
28.8 modem now, but the intent is to use it with the ADSL connection
(MindSpring).  The pppoed appears to be able to contact the PPPoE servers
at MindSpring, but cannot access the device to actually make the connection.

eth0 is a 3c905 connected directly to the DSL modem.
eth1 is a 3c905b connected to the internal LAN.

Here's a dump from a connection attempt:

frankenstein:~ # pppoed -I eth0
frankenstein:~ # !tail
tail -n 11 /var/log/allmessages
Dec 21 14:56:14 frankenstein pppoed[4716]: ppp_connect: total retries to go 1
Dec 21 14:56:14 frankenstein pppoed[4716]:  PPPoE tag: type=0102
length=001d (AC Name) data (UTF-8): 41021030045982-redback-1.phx2
Dec 21 14:56:14 frankenstein pppoed[4716]:  PPPoE tag: type=0101
length=000e (Service name) data (UTF-8): mindspring.com
Dec 21 14:56:14 frankenstein pppoed[4716]:  PPPoE tag: type=0101
length=0015 (Service name) data (UTF-8): tunnel.mindspring.com
Dec 21 14:56:14 frankenstein pppoed[4716]:  PPPoE tag: type=0102
length=001d (AC Name) data (UTF-8): 41021030045982-redback-1.phx2
Dec 21 14:56:14 frankenstein pppoed[4716]:  PPPoE tag: type=0101
length=000e (Service name) data (UTF-8): mindspring.com
Dec 21 14:56:14 frankenstein pppoed[4716]:  PPPoE tag: type=0101
length=0015 (Service name) data (UTF-8): tunnel.mindspring.com
Dec 21 14:56:14 frankenstein kernel: Registered PPPoX v0.5
Dec 21 14:56:14 frankenstein kernel: Registered PPPoE v0.6.4
Dec 21 14:56:14 frankenstein pppoed[4716]: cannot open /dev/pppox0: No such
device
Dec 21 14:56:14 frankenstein pppoed[4716]: Exit.
frankenstein:~ # ls -l /dev/pppox0
crw-rw----   1 root     uucp     144,   0 Mar 24  2000 /dev/pppox0

The PPPoX and PPPoE drivers are loaded as modules with no arguments.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a19 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
