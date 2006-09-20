Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWITBFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWITBFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 21:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWITBFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 21:05:01 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:38595
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750797AbWITBFA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 21:05:00 -0400
Message-Id: <200609200103.k8K13uWa006107@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.18-rc7-mm1: networking breakage on HPC nx6325 + SUSE 10.1
In-Reply-To: Your message of "Tue, 19 Sep 2006 23:30:34 +0200."
             <200609192330.34769.rjw@sisk.pl>
From: Valdis.Kletnieks@vt.edu
References: <20060919012848.4482666d.akpm@osdl.org> <200609192225.21801.rjw@sisk.pl> <20060919133606.f0c92e66.akpm@osdl.org>
            <200609192330.34769.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1158714236_3580P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Sep 2006 21:03:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1158714236_3580P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Sep 2006 23:30:34 +0200, "Rafael J. Wysocki" said:

> Well, I can configure the interfaces manually, with ifconfig, but the SUSE's
> configuration tools don't work.  For example, "ifup eth0" tells me that
> "No configuration found for eth0" and that's all.

I'm seeing issues on a Dell Latitude C840 as well, but I'm not positive
it's the same bug(s).  The problem I'm seeing is that device renaming is
failing (I have up to 5 different ethernet-ish interfaces that can be
connected, so I abuse /sbin/nameif extensively. There seem to be some
other issues with pcmcia, but it's not clear what the problem is - it
manages to find the (normally down) ethernet on my Xircom card, but the
orinoco driver seems unable to find my wireless card....

For instance, under 2.6.18-rc6-mm2, I see:

pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth2: Xircom cardbus revision 3 at irq 11
PCI: Enabling device 0000:03:00.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
0000:03:00.1: ttyS1 at I/O 0xe080 (irq = 11) is a 16550A
pccard: PCMCIA card inserted into slot 2
[rename_device:851]: Changing netdevice name from [eth1] to [eth3]
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[374fc0002a71c021]
[rename_device:1237]: Changing netdevice name from [eth2] to [eth1]
cs: memory probe 0xf4000000-0xfbffffff: excluding 0xf4000000-0xf8ffffff 0xfa000000-0xfbffffff
pcmcia: registering new device pcmcia2.0
orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
eth2: Hardware identity 0005:0004:0005:0000
eth2: Station identity  001f:0001:0008:000a
eth2: Firmware determined as Lucent/Agere 8.10
eth2: Ad-hoc demo mode supported
eth2: IEEE standard IBSS ad-hoc mode supported
eth2: WEP supported, 104-bit key
eth2: MAC address 00:02:2D:5C:11:48
eth2: Station name "HERMES I"
eth2: ready
eth2: orinoco_cs at 2.0, irq 11, io 0xe100-0xe13f
[rename_device:1295]: Changing netdevice name from [eth2] to [eth5]
Non-volatile memory driver v1.2

and under -rc7-mm1, I see:

pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth1: Xircom cardbus revision 3 at irq 11 
PCI: Enabling device 0000:03:00.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
0000:03:00.1: ttyS1 at I/O 0xe080 (irq = 11) is a 16550A
pccard: PCMCIA card inserted into slot 2
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[374fc0002a71c021]
Non-volatile memory driver v1.2

Amazingly less chatty.  Much later, when /etc/rc5.d/S10network runs, we finally
see:

orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)

but no output for the wireless configuring.

Unless somebody has a better idea overnight, I'll start a bisect of -rc7-mm1
in the morning...


--==_Exmh_1158714236_3580P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFEJN8cC3lWbTT17ARApQFAKCl2mCHnTSrnozbBOrkm+VDkd9TzACggh/T
CZIxVHs1kFj7m450UK4s0do=
=waL/
-----END PGP SIGNATURE-----

--==_Exmh_1158714236_3580P--
