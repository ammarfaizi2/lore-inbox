Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286943AbRL1RiA>; Fri, 28 Dec 2001 12:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286937AbRL1Rhw>; Fri, 28 Dec 2001 12:37:52 -0500
Received: from mail.nep.net ([12.23.44.24]:23052 "HELO nep.net")
	by vger.kernel.org with SMTP id <S286938AbRL1Rhi>;
	Fri, 28 Dec 2001 12:37:38 -0500
Message-ID: <19AB8F9FA07FB0409732402B4817D75A1251C3@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: "Ryan C. Bonham" <Ryan@srfarms.com>,
        "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Tyan Tomcat i815T(S2080) LAN problems
Date: Fri, 28 Dec 2001 12:45:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I installed kernel 2.4.17 and this problem still exists. I have attached the important stuff from demesg and from eepro100-diag. 

> 
> Has anyone gotten the Dual built-in LAN cards to work on the 
> Tyan S2080 Motherboard?  I am running a Redhat kernel 
> 2.4.9-13.. I haven't tried the latest kernel yet.. I saw some 
> talk about this board in the archives but I found no 
> solutions. It says it has a Intel 82559 LAN controller and a 
> ICH2 LAN Controller. I am only seeing one NIC when I boot up. 
> And dmesg is showing
> eth0: Invalid EEPROM checksum 0xFF00, check setting before 
> activating this device!
> 

Thanks,


eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 01:08.0
eth0: Invalid EEPROM checksum 0xff00, check settings before activating this device!
eth0: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 11.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
  Primary interface chip unknown-15 PHY #31.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).

----------------------------------  eerpro100-diag -aaeef

eepro100-diag.c:v2.06 12/10/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82562 Pro/100 V adapter at 0xc800.
i82557 chip registers at 0xc800:
  0c000050 07036000 00000000 00080002 3fe1ffff 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Suspended'.
   The receive unit state is 'Ready'.
  This status is normal for an activated but idle interface.
 The Command register has an unprocessed command 0c00(?!).
EEPROM contents, size 256x16:
    00: ffff ffff ffff ffff ffff ffff ffff ffff
  0x08: ffff ffff ffff ffff ffff ffff ffff ffff
  0x10: ffff ffff ffff ffff ffff ffff ffff ffff
  0x18: ffff ffff ffff ffff ffff ffff ffff ffff
  0x20: ffff ffff ffff ffff ffff ffff ffff ffff
  0x28: ffff ffff ffff ffff ffff ffff ffff ffff
  0x30: ffff ffff ffff ffff ffff ffff ffff ffff
  0x38: ffff ffff ffff ffff ffff ffff ffff ffff
  0x40: ffff ffff ffff ffff ffff ffff ffff ffff
  0x48: ffff ffff ffff ffff ffff ffff ffff ffff
  0x50: ffff ffff ffff ffff ffff ffff ffff ffff
  0x58: ffff ffff ffff ffff ffff ffff ffff ffff
  0x60: ffff ffff ffff ffff ffff ffff ffff ffff
  0x68: ffff ffff ffff ffff ffff ffff ffff ffff
  0x70: ffff ffff ffff ffff ffff ffff ffff ffff
  0x78: ffff ffff ffff ffff ffff ffff ffff ffff
  0x80: ffff ffff ffff ffff ffff ffff ffff ffff
  0x88: ffff ffff ffff ffff ffff ffff ffff ffff
  0x90: ffff ffff ffff ffff ffff ffff ffff ffff
  0x98: ffff ffff ffff ffff ffff ffff ffff ffff
  0xa0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xa8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xb0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xb8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xc0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xc8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xd0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xd8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xe0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xe8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xf0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xf8: ffff ffff ffff ffff ffff ffff ffff ffff
 *****  The EEPROM checksum is INCORRECT!  *****
  The checksum is 0xFF00, it should be 0xBABA!
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address FF:FF:FF:FF:FF:FF.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
  Primary interface chip i82555 PHY #-1.
    Secondary interface chip i82555, PHY -1.
   Sleep mode is enabled.  This is not recommended.
   Under high load the card may not respond to
   PCI requests, and thus cause a master abort.
   To clear sleep mode use the '-G 0 -w -w -f' options..
