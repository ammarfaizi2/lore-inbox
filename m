Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUK2T7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUK2T7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUK2Twy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:52:54 -0500
Received: from mail.signalz.com ([66.37.214.166]:38076 "EHLO mail.signalz.com")
	by vger.kernel.org with ESMTP id S261622AbUK2TuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:50:23 -0500
Subject: Promise SX8  driver performance
From: Matt <matt@signalz.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Signal Advertising
Message-Id: <1101757822.4309.37.camel@schroder.signalz.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Nov 2004 14:50:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all. I've got a Promise SX8 SATA controller and the performance
seems a little off. I'm using a debian-built 2.6.9 kernel and the
read/write I/O seems to level off around 80-90 MB/s. When I use the same
hardware in Windows, sequential I/O goes up to 218 MB/s. (That's about
the limit of my motherboard's buses.) If I move some disks to the
on-board SATA controller, I can get the I/O to go higher but never as
high as in Windows.

Is this a problem with my expectations, my testing, or the driver? 


Some Bonnie numbers for a raid 0 array of Seagate 7200.7's (2 GB file,
sequential, MB/s):

Disks/cntl        Write    Read
-----             -----    ----
1 (sx8)              57      63
2 (sx8)              69      75
2 (ESB)             111     121
3 (sx8)              75      79
3 (1 sx8, 2 ESB)    141     125
4 (sx8)              89      80
4 (2 sx8, 2 ESB)    135     150
5 (sx8)              88      79
6 (sx8)              91      75

Some numbers from Sandra (ugh) in W2K Pro with the latest Promise
drivers and using software RAID 0 (sequential, MB/s):

Disks/cntl      Write    Read
-----           -----    ----
1 (sx8)            56      62
2 (sx8)           106     122
3 (sx8)           151     176
4 (sx8)           178     209
5 (sx8)           180     218
6 (sx8)           179     218
6 (4 sx8, 2 ESB)  169     207


My full hardware:

Supermicro P4SCi motherboard (7210 chipset, 6300ESB SATA on-board)
3.0 GHz P4 Northwood w/ HT enabled
(2) 512MB DDR400 dual channel (non-ECC)
Promise SX8 SATA controller
(6) 200 GB Seagate 7200.7
(1) 40 GB Seagate Baraccuda IV (boot)
Adaptec 2940U




