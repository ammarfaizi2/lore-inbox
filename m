Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTHJMgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 08:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTHJMgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 08:36:52 -0400
Received: from mid-1.inet.it ([213.92.5.18]:16036 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S263752AbTHJMgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 08:36:49 -0400
From: Paolo Ornati <javaman@katamail.com>
To: isdn4linux@listserv.isdn4linux.de
Subject: ISDN driver problem: kernel freeze
Date: Sun, 10 Aug 2003 14:37:01 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308101437.01443.javaman@katamail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm not subscibed to isdn4linux ml so plese CC when replying)

Playing with linux kernel 2.6.0-test2 and 2.6.0-test3 I have a kernel freeze 
trying to load isdn/hisax modules...
I don't know if this is a know problem so I report it :-)

MY HARDWARE: (lspci)

00:0d.0 Network controller: Cologne Chip Designs GmbH ISDN network controller 
[HFC-PCI] (rev 02)
	Subsystem: Cologne Chip Designs GmbH ISDN Board
	Flags: bus master, medium devsel, latency 16, IRQ 5
	I/O ports at 8800 [disabled] [size=8]
	Memory at df800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1


KERNEL CONFIG (2.6.0-test3):

#
# ISDN subsystem
#
CONFIG_ISDN_BOOL=y

#
# Old ISDN4Linux
#
CONFIG_ISDN=m
# CONFIG_ISDN_NET_SIMPLE is not set
# CONFIG_ISDN_NET_CISCO is not set
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
# CONFIG_ISDN_AUDIO is not set

#
# ISDN feature submodules
#
# CONFIG_ISDN_DRV_LOOP is not set
# CONFIG_ISDN_DIVERSION is not set

#
# CAPI subsystem
#
# CONFIG_ISDN_CAPI is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
# CONFIG_DE_AOC is not set
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set
# CONFIG_HISAX_NI1 is not set
CONFIG_HISAX_MAX_CARDS=1

#
# HiSax supported cards
#
# CONFIG_HISAX_16_3 is not set
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
# CONFIG_HISAX_FRITZPCI is not set
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
# CONFIG_HISAX_ELSA is not set
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
# CONFIG_HISAX_GAZEL is not set
CONFIG_HISAX_HFC_PCI=y
# CONFIG_HISAX_W6692 is not set
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_ENTERNOW_PCI is not set
# CONFIG_HISAX_DEBUG is not set
# CONFIG_HISAX_FRITZ_PCIPNP is not set
# CONFIG_HISAX_HFCPCI is not set

#
# Active cards
#
# CONFIG_ISDN_DRV_EICON is not set
# CONFIG_ISDN_DRV_TPAM is not set
# CONFIG_HYSDN is not set


Console's messages (copied by hand):

ISDN subsystem initialized
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.41.6.5
HiSax: Layer2 Revision 2.25.6.4
HiSax: TeiMgr Revision 2.17.6.3
HiSax: Layer3 Revision 2.17.6.5
HiSax: LinkLayer Revision 2.51.6.6
HiSax: Approval certification failed beacause of
HiSax: unathorized source code changes
get_drv 0: 0 -> 1
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: HFC-PCI driver Rev. 1.34.6.8
PCI: Found IRQ 5 for device 0000:00:0d.0
PCI: Sharing IRQ 5 with 0000:00:04.2
PCI: Sharing IRQ 5 with 0000:00:04.3
HiSax: HFC-PCI card manufacturer: CCD/Billion/Asuscom name: 2BD0
HiSax: HFC-PCI: defined at mem 0xc8914000 fifo 0xc4ec8000(0x4ec8000) IRQ 5
ChipID: 30
HFC_PCI: resetting card
HFC 2BDS0 PCI: IRQ 5 count 0

(KERNEL FREEZE / interrupts enabled)

Bye,
Paolo

