Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRBJWqf>; Sat, 10 Feb 2001 17:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRBJWq0>; Sat, 10 Feb 2001 17:46:26 -0500
Received: from delta.rollanet.org ([208.18.12.6]:4362 "HELO delta.rollanet.org")
	by vger.kernel.org with SMTP id <S129027AbRBJWqN>;
	Sat, 10 Feb 2001 17:46:13 -0500
Message-ID: <3A85C4A9.8CAD6466@umr.edu>
Date: Sat, 10 Feb 2001 16:46:01 -0600
From: Nathan Neulinger <nneul@umr.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem with adding starfire driver to kernel 2.2.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen this symptom in the past with updated tulip and eepro drivers.
Basically, it appears that it detects the same card more than once. In
the case of the below dmesg output - the machine has 1 tulip based card,
and 1 Adaptec Quartet64. The eth[5-8] are bogus.

In the past, if I remember correctly, so long as I didn't do anything to
the bogus interfaces, stuff was fine, but it's a little disturbing.

Note - I've added the module directly to the kernel (added the .o files
in the drivers/net/Makefile, and the pci_scan/kern_compat stuff etc.)

Any ideas on how I can correct this symptom?

Moving to 2.4.1 isn't an option just yet, although I am considering it
as I'm deploying new machines.

-- Nathan

eth0: Digital DS21143-xD Tulip rev 65 at 0xe000, 00:C0:F0:6B:61:BC, IRQ
5.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3)
block.
eth0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
tulip.c:v0.92t 1/15/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/tulip.html
eth1: Adaptec Starfire 6915 at 0xd0000000, 00:00:d1:ee:77:71, IRQ 11.
eth1: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth2: Adaptec Starfire 6915 at 0xd0081000, 00:00:d1:ee:77:72, IRQ 9.
eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth3: Adaptec Starfire 6915 at 0xd0102000, 00:00:d1:ee:77:73, IRQ 10.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth4: Adaptec Starfire 6915 at 0xd0183000, 00:00:d1:ee:77:74, IRQ 5.
eth4: MII PHY found at address 1, status 0x7809 advertising 01e1.
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
 Updates and info at http://www.scyld.com/network/starfire.html
eth5: Adaptec Starfire 6915 at 0xd0204000, 00:00:d1:ee:77:71, IRQ 11.
eth5: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth6: Adaptec Starfire 6915 at 0xd0285000, 00:00:d1:ee:77:72, IRQ 9.
eth6: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth7: Adaptec Starfire 6915 at 0xd0306000, 00:00:d1:ee:77:73, IRQ 10.
eth7: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device eth8 is deferred
eth8: Adaptec Starfire 6915 at 0xd0387000, 00:00:d1:ee:77:74, IRQ 5.
eth8: MII PHY found at address 1, status 0x7809 advertising 01e1.
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
CIS - Systems Programming                Fax: (573) 341-4216
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
