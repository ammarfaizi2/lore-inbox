Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVCWTJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVCWTJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVCWTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:09:44 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:40664 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262050AbVCWTJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:09:18 -0500
Date: Wed, 23 Mar 2005 20:09:14 +0100
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.11] audio failing: ac97
Message-ID: <20050323190911.GU29897@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Wed Mar 23 21:52:36 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a hp pavillion zv5231ea. Upto version 2.6.10 audio worked fine.
Since version 2.6.11 that stopped. Sound is silent or repeats the same
fragment over and over before doing the same with the next fragment.

During startup this is outputted:
...
atiixp: codec read timeout (reg 1c)
atiixp: codec read timeout (reg 0)
atiixp: codec read timeout (reg 3c)
atiixp: codec read timeout (reg 1c)
atiixp: codec read timeout (reg 0)
atiixp: codec read timeout (reg 3c)
atiixp: codec read timeout (reg 1c)
atiixp: codec read timeout (reg 0)
atiixp: codec read timeout (reg 3c)
atiixp: codec read timeout (reg 1c)
atiixp: codec read timeout (reg 0)
atiixp: codec read timeout (reg 3c)
atiixp: codec read timeout (reg 1c)
atiixp: codec read timeout (reg 0)
atiixp: codec read timeout (reg 3c)
atiixp: codec read timeout (reg 1c)
AC'97 2 does not respond - RESET
AC'97 2 access is not valid [0xffffffff], removing mixer.

(the timeouts appear a lot more by the way, I shortened things)

The devices in my laptop are:
ehm:/home/folkert# lspci
0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5833 (rev 02)
0000:00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5838
0000:00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4347 (rev 01)
0000:00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4348 (rev 01)
0000:00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 16)
0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4349
0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342
0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audio Controller
0000:00:14.6 Modem: ATI Technologies Inc: Unknown device 434d (rev 01)
0000:01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5835
0000:02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
0000:02:02.0 Network controller: Broadcom Corporation BCM4301 802.11b (rev 02)
0000:02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
0000:02:04.2 System peripheral: Texas Instruments: Unknown device 8201 (rev 01)
0000:02:07.0 USB Controller: NEC Corporation USB (rev 43)
0000:02:07.1 USB Controller: NEC Corporation USB (rev 43)
0000:02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

pci-ids:
ehm:/home/folkert# lspci -n | grep 0000:00:14.5
0000:00:14.5 0401: 1002:4341

The complete .config can be found here:
http://keetweej.vanheusden.com/~folkert/config_laptop


Folkert van Heusden

Auto te koop! Zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!
