Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUDSReg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUDSReg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:34:36 -0400
Received: from pool-141-155-158-151.ny5030.east.verizon.net ([141.155.158.151]:64233
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S261661AbUDSReM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:34:12 -0400
Subject: Badness in get_phy_reg at drivers/ieee1394/ohci1394.c:238
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lN82rIqb+/0QYcUsioq5"
Message-Id: <1082396118.29955.8.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.6.2 (Slackware Linux)
Date: Mon, 19 Apr 2004 13:35:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lN82rIqb+/0QYcUsioq5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi folks,

I have reported this around 2.6.5-rc3-mm1 but it never go away.

Kernel Linux blaze 2.6.6-rc1-mm1 #1 Mon Apr 19 04:03:51 EDT 2004 i686
unknown unknown GNU/Linux

Slackware Linux on NForce2 (gigabyte 7NNXP) board with built in ieee1394
adapter.

Dmesg shows this on every boot:

ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[22]
MMIO=3D[ee084000-ee0847ff]  Max Packet=3D[2048]
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:04.0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 21, pci mem f9897000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xe0000000
Badness in get_phy_reg at drivers/ieee1394/ohci1394.c:238
Call Trace:
 [<f988810e>] get_phy_reg+0x10e/0x120 [ohci1394]
 [<f9888e4c>] ohci_devctl+0x5c/0x5d0 [ohci1394]
 [<c0106a56>] apic_timer_interrupt+0x1a/0x20
 [<c01112d4>] delay_tsc+0x14/0x20
 [<f988af1f>] ohci_irq_handler+0x55f/0x800 [ohci1394]
 [<c012403f>] do_timer+0xdf/0xf0
 [<c01082ea>] handle_IRQ_event+0x3a/0x70
 [<c01086b5>] do_IRQ+0xc5/0x1a0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0106a34>] common_interrupt+0x18/0x20
 [<f9888193>] set_phy_reg+0x73/0x120 [ohci1394]
 [<f98a6d00>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<f9888e66>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<f98af3b7>] csr1212_fill_cache+0x97/0x100 [ieee1394]
 [<f98a6d00>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<f98a419c>] hpsb_reset_bus+0x3c/0x40 [ieee1394]
 [<f98a6db4>] delayed_reset_bus+0xb4/0xd0 [ieee1394]
 [<c0123e54>] run_timer_softirq+0xd4/0x1d0
 [<c011fe3d>] __do_softirq+0x7d/0x80
 [<c0108fd3>] do_softirq+0x43/0x60
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c010873b>] do_IRQ+0x14b/0x1a0
 [<c0106a34>] common_interrupt+0x18/0x20
 [<c01235f9>] __mod_timer+0x119/0x1a0
 [<f9933756>] usb_start_wait_urb+0x86/0xe0 [usbcore]
 [<f993381b>] usb_internal_control_msg+0x6b/0x80 [usbcore]
 [<f9933650>] timeout_kill+0x0/0x80 [usbcore]
 [<f993381b>] usb_internal_control_msg+0x6b/0x80 [usbcore]
 [<f99338c6>] usb_control_msg+0x96/0xb0 [usbcore]
 [<f992f758>] clear_port_feature+0x58/0x60 [usbcore]
 [<f9930b37>] hub_port_reset+0xa7/0xc0 [usbcore]
 [<f9930e1d>] hub_port_connect_change+0xfd/0x280 [usbcore]
 [<f99312bb>] hub_events+0x31b/0x390 [usbcore]
 [<f993135d>] hub_thread+0x2d/0xf0 [usbcore]
 [<c0105f9e>] ret_from_fork+0x6/0x14
 [<c0118ff0>] default_wake_function+0x0/0x20
 [<f9931330>] hub_thread+0x0/0xf0 [usbcore]
 [<c0104291>] kernel_thread_helper+0x5/0x14
=20
Badness in set_phy_reg at drivers/ieee1394/ohci1394.c:267
Call Trace:
 [<f9888230>] set_phy_reg+0x110/0x120 [ohci1394]
 [<f9888e66>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<c01112d4>] delay_tsc+0x14/0x20
 [<f988af1f>] ohci_irq_handler+0x55f/0x800 [ohci1394]
 [<c012403f>] do_timer+0xdf/0xf0
 [<c01082ea>] handle_IRQ_event+0x3a/0x70
 [<c01086b5>] do_IRQ+0xc5/0x1a0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0106a34>] common_interrupt+0x18/0x20
 [<f9888193>] set_phy_reg+0x73/0x120 [ohci1394]
 [<f98a6d00>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<f9888e66>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<f98af3b7>] csr1212_fill_cache+0x97/0x100 [ieee1394]
 [<f98a6d00>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<f98a419c>] hpsb_reset_bus+0x3c/0x40 [ieee1394]
 [<f98a6db4>] delayed_reset_bus+0xb4/0xd0 [ieee1394]
 [<c0123e54>] run_timer_softirq+0xd4/0x1d0
 [<c011fe3d>] __do_softirq+0x7d/0x80
 [<c0108fd3>] do_softirq+0x43/0x60
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c010873b>] do_IRQ+0x14b/0x1a0
 [<c0106a34>] common_interrupt+0x18/0x20
 [<c01235f9>] __mod_timer+0x119/0x1a0
 [<f9933756>] usb_start_wait_urb+0x86/0xe0 [usbcore]
 [<f993381b>] usb_internal_control_msg+0x6b/0x80 [usbcore]
 [<f9933650>] timeout_kill+0x0/0x80 [usbcore]
 [<f993381b>] usb_internal_control_msg+0x6b/0x80 [usbcore]
 [<f99338c6>] usb_control_msg+0x96/0xb0 [usbcore]
 [<f992f758>] clear_port_feature+0x58/0x60 [usbcore]
 [<f9930b37>] hub_port_reset+0xa7/0xc0 [usbcore]
 [<f9930e1d>] hub_port_connect_change+0xfd/0x280 [usbcore]
 [<f99312bb>] hub_events+0x31b/0x390 [usbcore]
 [<f993135d>] hub_thread+0x2d/0xf0 [usbcore]
 [<c0105f9e>] ret_from_fork+0x6/0x14
 [<c0118ff0>] default_wake_function+0x0/0x20
 [<f9931330>] hub_thread+0x0/0xf0 [usbcore]
 [<c0104291>] kernel_thread_helper+0x5/0x14
=20
ohci1394: fw-host0: SelfID received outside of bus reset sequence
usb usb1: control timeout on ep0out
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[8a1cc7ffff0020ed]
ip1394: $Rev: 1198 $ Ben Collins <bcollins@debian.org>
ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)

More info available upon request.

Thanks,

Paul B.

--=-lN82rIqb+/0QYcUsioq5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAhA3Wv0+bfGBjm98RAlOvAJwP/cazMpXwo6cV90kySE8p2/ZYiwCcDmet
DNKUlNqT4sFSl8B/MxGDy/w=
=SueV
-----END PGP SIGNATURE-----

--=-lN82rIqb+/0QYcUsioq5--

