Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbRF2Qcv>; Fri, 29 Jun 2001 12:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266113AbRF2Qcl>; Fri, 29 Jun 2001 12:32:41 -0400
Received: from datafoundation.com ([209.150.125.194]:44304 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S266112AbRF2Qcc>; Fri, 29 Jun 2001 12:32:32 -0400
Date: Fri, 29 Jun 2001 12:32:31 -0400 (EDT)
From: John Jasen <jjasen@datafoundation.com>
To: <linux-kernel@vger.kernel.org>
Subject: a couple of NICs that don't NIC
Message-ID: <Pine.LNX.4.30.0106291223560.9716-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In these cases, both network interface cards fall over under moderate to
heavy traffic.

1) 01:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)

kernels: 2.2.19 and 2.4.4

drivers used: kernel eepro100 (2.2.19 and 2.4.4) and intel e100 (2.4.4)

symptoms: the system would spontaneously reboot under heavy NFS traffic,
with no console or /var/log/messages reports.

This could be reliably reproduced by mounting an exported directory, and
looping "find /mounted/directory -depth -print | xargs cat >/dev/null"

2) SMC EZNET 10/100 nic, using a realtek chipset

kernels: 2.4.4

drivers used: kernel 8139too

symptoms: the system would hang under heavy network traffic, and need to
be powercycled backed to life.

ping -f could cause it, as could the test above.

Nothing of interest to report via console or syslog.

I've currently replaced these cards with the Netgear FA310 series, using
the tulip driver (01:0b.0 Ethernet controller: Lite-On Communications Inc
LNE100TX (rev 20)) and have had no problems, so being able to help in
testing would probably be more difficult.


