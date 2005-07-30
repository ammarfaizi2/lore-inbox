Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263026AbVG3Jc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbVG3Jc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 05:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbVG3Jc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 05:32:28 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:18578 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S263026AbVG3JcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 05:32:23 -0400
X-ME-UUID: 20050730093211854.D082F1C001F3@mwinf0809.wanadoo.fr
Message-ID: <8141764.1122715931842.JavaMail.www@wwinf0802>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc3] sis190 driver
Cc: lars.vahlenberg@mandator.com, Alexey Dobriyan <adobriyan@gmail.com>,
       jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.194.245.137]
X-WUM-FROM: |~|
X-WUM-TO: |~||~|
X-WUM-CC: |~||~||~|
X-WUM-REPLYTO: |~|
Date: Sat, 30 Jul 2005 11:32:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 29/07/05 00:13
> De : "Francois Romieu" <romieu@fr.zoreil.com>
[...]
 
> Changes from previous version (20050722)
[...]
> o Minor round of mii/phy related changes. May crash.
> 
> Testing reports/review/patches are always appreciated.
> 

sis190-120 compiles, loads but does not work (sis190_init_phy() function).

# service network start
Bringing up loopback interface:                            [  OK  ]
Bringing up interface eth0:
Determining IP information for eth0... failed; no link present.  Check cable?
                                                           [FAILED]

#dmesg
sis190 Gigabit Ethernet driver 1.2 loaded.
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:04.0 to 64
0000:00:04.0: Read MAC address from APC.
eth0: Unknown PHY transceiver at address 1.
0000:00:04.0: sis190 at ffffc20000004c00 (IRQ: 11), 00:11:2f:e9:42:70
eth0: Enabling Auto-negotiation.

# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Current message level: 0x00000037 (55)
        Link detected: no

I reverted to sis190-110, which works well on my box.

--
Pascal




