Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTLDI0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 03:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTLDI0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 03:26:21 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:43013 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263292AbTLDI0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 03:26:16 -0500
Message-ID: <3FCEF3FC.8000708@nishanet.com>
Date: Thu, 04 Dec 2003 03:44:44 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: pcmcia yenta cardbus - no devices found
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elan 1420 chip 32-bit cardbus pcmcia chip related to TI4210

cardmgr and utils of pcmcia-cs 3.2.5

yenta in kernel-2.6.0-test11  but no pcmcia ethernet card drivers
in kernel since I don't know which eth chip is on a Hawking pcmcia
PN672TX 32-bit cardbus 10/100 ethernet card.

boot with compact flash Kingston or Sandisk storage card in
pcmcia adapter and Hawking ethernet pcmcia card in second
pcmcia cardbus slot, nothing, try remove and insert, still
nothing, no pcmcia events or devices reported

Dec  4 02:32:43 where kernel: Linux Kernel Card Services
Dec  4 02:32:43 where kernel:   options:  [pci] [cardbus] [pm]
Dec  4 02:32:43 where kernel: Yenta: CardBus bridge found at 0000:01:0a.0 [414e:454c]
Dec  4 02:32:43 where kernel: Yenta: ISA IRQ list 0000, PCI irq16
Dec  4 02:32:43 where kernel: Socket status: 30000006
Dec  4 02:32:43 where kernel: Yenta: CardBus bridge found at 0000:01:0a.1 [414e:454c]
Dec  4 02:32:43 where kernel: Yenta: ISA IRQ list 0000, PCI irq16
Dec  4 02:32:43 where kernel: Socket status: 30000006
Dec  4 02:32:43 where kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Dec  4 02:32:43 where kernel: cs: IO port probe 0x0800-0x08ff: clean.
Dec  4 02:32:43 where kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x290-0x297 0x3c0-0x3df 0x4d0-0x4d7
Dec  4 02:32:43 where kernel: cs: IO port probe 0x0a00-0x0aff: clean.

root       374  0.0  0.0 ?    [pccardd]
root       380  0.0  0.0 ?    [pccardd]
root       388  0.0  0.0 ?    /sbin/cardmgr
bob      25484  0.0  0.0 pts/0grep card

bob@where cat /var/lib/pcmcia/stab
Socket 0: empty
Socket 1: empty

bob@where $(locate gr/pcic_probe | grep "probe$") -v
PCI bridge probe: ENE 1420 found, 2 sockets.

bob@where $(locate gr/pcic_probe | grep "probe$") -v -m
i82365


