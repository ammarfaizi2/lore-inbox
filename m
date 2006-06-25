Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWFYJrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWFYJrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWFYJrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:47:18 -0400
Received: from outgoing3.smtp.agnat.pl ([193.239.44.85]:28852 "EHLO
	outgoing3.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932220AbWFYJrS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:47:18 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Jean Tourrilhes <jt@hpl.hp.com>
Subject: thinkpad z60m and nsc-ircc
Date: Sun, 25 Jun 2006 11:47:11 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606251147.11694.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just upgraded kernel to todays 2.6.17 git version which has some of 
nsc-ircc patches merged.

Unfortunately nsc-ircc stopped working for me after this upgrade:

hci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[66]  MMIO=[c0001000-c00017ff]  
Max Packet=[2048]  IR/IT contexts=[4/4]
usb 2-1: new low speed USB device using uhci_hcd and address 2
Yenta: CardBus bridge found at 0000:14:00.0 [1014:056c]
pnp: Unable to assign resources to device 00:09.
nsc-ircc: probe of 00:09 failed with error -16
nsc-ircc, Found chip at base=0x164e
nsc-ircc, Wrong chip version ff
Yenta: ISA IRQ mask 0x04b8, PCI irq 169
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x9000 - 0xcfff

In earlier version (2.6.17 rc X) it was:

pnp: Device 00:09 activated.
nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x164e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Using dongle: IBM31T1100 or Temic TFDS6000/TFDS6500

my modprobe setup is:
alias irda0 nsc-ircc
options nsc-ircc dongle_id=0x09 io=0x2f8 irq=3 dma=3
install nsc-ircc /bin/setserial /dev/ttyS1 uart none port 0 irq 
0; /sbin/modprobe --ignore-install nsc-ircc

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
