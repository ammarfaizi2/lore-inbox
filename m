Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVBAMsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVBAMsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 07:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVBAMsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 07:48:22 -0500
Received: from math.ut.ee ([193.40.5.125]:29850 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262004AbVBAMsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 07:48:14 -0500
Date: Tue, 1 Feb 2005 14:48:09 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Scott Feldman <sfeldma@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANN] removal of certain net drivers coming soon:
 eepro100,?xircom_tulip_cb, iph5526
In-Reply-To: <1106939504.18167.364.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0502011444310.26768@math.ut.ee>
References: <E1CuSUy-00063X-LK@rhn.tartu-labor> <1106939504.18167.364.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> See if eepro100 works on your 82556 cards.  I would be surprised if it
> does.  If it does, maybe it's not that much trouble to add support to
> e100.  Let us know.

I did add the PCI ID to e100 to to try it with both drivers.

In short: both eepro100 and e100 have problems loading the eeprom and 
don't work at least out of the box.

Here is the dmesg, first card is onboard e100, 0000:01:0c.0 and 
0000:01:0d.0 are the 82556's.

e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xff8fe000, irq 11, MAC addr 00:03:47:A4:64:D5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
e100: 0000:01:0c.0: e100_eeprom_load: EEPROM corrupted
e100: probe of 0000:01:0c.0 failed with error -11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: 0000:01:0d.0: e100_eeprom_load: EEPROM corrupted
e100: probe of 0000:01:0d.0 failed with error -11

[...]

eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
eth1: Invalid EEPROM checksum 0x0000, check settings before activating this device!
eth1: 0000:01:0c.0, 00:00:00:00:00:00, IRQ 9.
   Receiver lock-up bug exists -- enabling work-around.
   Board assembly 000000-000, Physical connectors present:
   Primary interface chip None PHY #0.
Self test failed, status ffffffff:
  Failure to initialize the i82557.
  Verify that the card is a bus-master capable slot.
   Receiver lock-up workaround activated.
ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
eth2: Invalid EEPROM checksum 0x0000, check settings before activating this device!
eth2: 0000:01:0d.0, 00:00:00:00:00:00, IRQ 11.
   Receiver lock-up bug exists -- enabling work-around.
   Board assembly 000000-000, Physical connectors present:
   Primary interface chip None PHY #0.
Self test failed, status ffffffff:
  Failure to initialize the i82557.
  Verify that the card is a bus-master capable slot.
   Receiver lock-up workaround activated.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.
  mdio_read() timed out with val = 00000028.

-- 
Meelis Roos (mroos@linux.ee)
