Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUIOOgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUIOOgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUIOOgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:36:19 -0400
Received: from smtp2.Uni-Siegen.DE ([141.99.2.31]:19724 "HELO
	smtp.uni-siegen.de") by vger.kernel.org with SMTP id S266252AbUIOOgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:36:14 -0400
Message-ID: <41485359.80602@informatik.uni-siegen.de>
Date: Wed, 15 Sep 2004 16:36:09 +0200
From: Thomas Unger <unger@informatik.uni-siegen.de>
Organization: University of Siegen FB12-PS
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: keylargo PCI USB controller nor enabled on G4 xserve
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've been searching through the mailing-list archive but
haven't seen a similar problem report yet, so I'm asking
this here.

We have two G4 dual 1GHz xserves here, they are running 2.4.25-ben1
and working fine, including USB. In the process of upgrading
to 2.6 I had to realize the USB KeyLargo hardware isn't detected.

lspci on 2.4 says:

======================================================================
0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 AGP
0000:00:10.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE]
0000:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 PCI
0000:10:0d.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
0000:10:11.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
0000:10:15.0 RAID bus controller: Promise Technology, Inc. PDC20270
(FastTrak100 LP/TX2/TX4) (rev 02)
0000:10:1b.0 RAID bus controller: Promise Technology, Inc. PDC20270
(FastTrak100 LP/TX2/TX4) (rev 02)
0000:11:07.0 ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
0000:11:08.0 USB Controller: Apple Computer Inc. KeyLargo USB   <----
0000:11:09.0 USB Controller: Apple Computer Inc. KeyLargo USB   <----
0000:12:02.0 Ethernet controller: Apple Computer Inc. Tigon3 Gigabit
Ethernet NIC (BCM5701) (rev 15)
0000:12:03.0 Ethernet controller: National Semiconductor Corporation
DP83820 10/100/1000 Ethernet Controller
0000:22:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 Internal PCI
0000:22:0d.0 ff00: Apple Computer Inc. UniNorth 2 ATA/100
0000:22:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth 2
FireWire (rev 01)
0000:22:0f.0 ffff: Apple Computer Inc. UniNorth 2 GMAC (Sun GEM) (rev ff)
=====================================================================

while on 2.6.6:

=====================================================================
0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 AGP
0000:00:10.0 Ethernet controller: National Semiconductor Corporation
DP83820 10/100/1000 Ethernet Controller
0001:01:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 PCI
0001:01:0d.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
0001:01:11.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
0001:01:15.0 RAID bus controller: Promise Technology, Inc. PDC20270
(FastTrak100 LP/TX2/TX4) (rev 02)
0001:01:1b.0 RAID bus controller: Promise Technology, Inc. PDC20270
(FastTrak100 LP/TX2/TX4) (rev 02)
0001:02:02.0 ffff: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
(rev ff)
0001:02:03.0 ffff: Apple Computer Inc. Tigon3 Gigabit Ethernet NIC
(BCM5701) (rev ff)
0001:03:02.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE]
0001:03:03.0 Ethernet controller: Apple Computer Inc. Tigon3 Gigabit
Ethernet NIC (BCM5701) (rev 15)
0002:04:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 Internal PCI
0002:04:0d.0 ff00: Apple Computer Inc. UniNorth 2 ATA/100
0002:04:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth 2
FireWire (rev 01)
0002:04:0f.0 ffff: Apple Computer Inc. UniNorth 2 GMAC (Sun GEM) (rev ff)
======================================================================

looks to me like a pci problem as the device obviously isn't even
enumerated. I tried several 2.6 versions, none of them fixed this.

Has anyone had similar problems or even a solution to this?
Any help is welcome.

		Thomas Unger





