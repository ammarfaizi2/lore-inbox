Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTLSWDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 17:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTLSWDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 17:03:20 -0500
Received: from dsdwebs.sztaki.hu ([193.225.86.11]:2092 "HELO lutra.sztaki.hu")
	by vger.kernel.org with SMTP id S263642AbTLSWDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 17:03:19 -0500
Date: Fri, 19 Dec 2003 23:03:17 +0100 (MET)
From: Zoltan Farkas <zfarkas@lutra.sztaki.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Two NICs, one eth interface?
Message-ID: <Pine.GS4.4.33.0312192251180.6715-100000@lutra.sztaki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi!

 The following is happening when using 2.6: I've got two network interface
cards: SMC Ultra (ISA PNP card) and an Intel eepro100 card. The strange
thing is that both of these cards get the eth0 interface. Relative to
dmesg:
...
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:07.2
eth0: OEM i82557/i82558 10/100 Ethernet, 00:90:27:A7:CE:6A, IRQ 11.
  Board assembly 734938-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
pnp: Device 00:01.00 activated.
smc-ultra.c: ISAPnP reports SMC EtherEZ (8416) at i/o 0x240, irq 5.
smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth0: SMC EtherEZ at 0x240, 00 00 C0 2A 26 DE,assigned  IRQ 5 programmed-I/O mode.
smc-ultra.c: No ISAPnP cards found, trying standard ones...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

So you can see there is only one eth interface for two NICs.
Modules are turned off, and ISAPnP is enabled.
Cheers,

	Zoltan

