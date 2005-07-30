Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbVG3LMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbVG3LMN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVG3LMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:12:13 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:800 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S263043AbVG3LMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:12:12 -0400
X-ME-UUID: 20050730111208726.B172518000AA@mwinf0801.wanadoo.fr
Message-ID: <13196579.1122721928715.JavaMail.www@wwinf0801>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [patch 2.6.13-rc3] sis190 driver
Cc: linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Hutchings <info@a-wing.co.uk>, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.194.245.137]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Sat, 30 Jul 2005 13:12:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 30/07/05 12:13
> De : "Francois Romieu" <romieu@fr.zoreil.com>
[...]
> Lars noticed that the link status is not correctly reported and suggested
> a few changes. Can you check if the version below works better ?
> 
I was precisely modifying mii_chip_table[] in sis190-120 to make it work ;-)

Yes, that new version works well.

#dmesg
sis190 Gigabit Ethernet driver 1.2 loaded.
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:04.0 to 64
0000:00:04.0: Read MAC address from APC.
eth0: Realtek PHY RTL8201 transceiver at address 1.
eth0: Using transceiver at address 1 as default.
0000:00:04.0: sis190 at ffffc20000004c00 (IRQ: 11), 00:11:2f:e9:42:70
eth0: Enabling Auto-negotiation.
eth0: mii ext = 0000.
eth0: mii lpa = c1e1 adv = 01e1.
eth0: link on 100 Mbps Full Duplex mode.

By the way,  i still can not force speed/mode/autoneg (ethtool or mii-tool); 
ethtool reports correctly the changes, but autoneg is not really disabled, 
and the driver falls back to 100 Full...

Had Lars better results with autoneg off?

-
Pascal

