Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTHSTZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbTHSTXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:23:33 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24448 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261305AbTHSTXF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:23:05 -0400
Message-Id: <200308191922.h7JJMqBC004447@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Russell King <rmk@arm.linux.org.uk>
Cc: Narayan Desai <desai@mcs.anl.gov>, linux-kernel@vger.kernel.org
Subject: Re: weird pcmcia problem 
In-Reply-To: Your message of "Tue, 19 Aug 2003 19:19:48 BST."
             <20030819191948.C23670@flint.arm.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <87u18efpsc.fsf@mcs.anl.gov> <200308190447.h7J4l0Vq004410@turing-police.cc.vt.edu> <200308191816.h7JIGNBC002405@turing-police.cc.vt.edu>
            <20030819191948.C23670@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1097139492P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Aug 2003 15:22:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1097139492P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Aug 2003 19:19:48 BST, Russell King said:

> That wasn't expected.

Well, I hadn't tried any Yenta patch on top of -mm2, so I wasn't sure..

> Can you provide all the following information please:
> 
> - make/model of machine

Dell Latitude C840

> - type of cardbus bridge (from lspci)


02:01.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
        Subsystem: Dell Computer Corporation: Unknown device 00d5

> - type of card (pcmcia or cardbus)

%  cardctl ident 2
  product info: "Dell", "TrueMobile 1150 Series PC Card", "Version 01.01", ""
  manfid: 0x0156, 0x0002
  function: 6 (network)

> - make/model of card

> - full kernel dmesg (including yenta, card services messages)

Aug 19 14:04:19 turing-police kernel: Yenta: CardBus bridge found at 0000:02:01.0 [1028:00d5]
Aug 19 14:04:19 turing-police kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Aug 19 14:04:19 turing-police kernel: Yenta: Routing CardBus interrupts to PCI
Aug 19 14:04:19 turing-police kernel: Yenta: ISA IRQ list 00b8, PCI irq9
Aug 19 14:04:19 turing-police kernel: Socket status: 30000020
Aug 19 14:04:19 turing-police kernel: PCI: Enabling device 0000:02:01.1 (0000 -> 0002)
Aug 19 14:04:19 turing-police kernel: Yenta: CardBus bridge found at 0000:02:01.1 [1028:00d5]
Aug 19 14:04:19 turing-police kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Aug 19 14:04:19 turing-police kernel: Yenta: Routing CardBus interrupts to PCI
Aug 19 14:04:19 turing-police kernel: Yenta: ISA IRQ list 00b8, PCI irq9
Aug 19 14:04:19 turing-police kernel: Socket status: 30000006
Aug 19 14:04:19 turing-police kernel: Yenta: CardBus bridge found at 0000:02:03.0 [12a3:ab01]
Aug 19 14:04:19 turing-police kernel: Yenta: Enabling burst memory read transactions
Aug 19 14:04:19 turing-police kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Aug 19 14:04:20 turing-police kernel: Yenta: Routing CardBus interrupts to PCI
Aug 19 14:04:20 turing-police kernel: Yenta: ISA IRQ list 0000, PCI irq9
Aug 19 14:04:20 turing-police kernel: Socket status: 30000010

Aug 19 14:04:24 turing-police kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
Aug 19 14:04:24 turing-police kernel: eth1: Station identity 001f:0001:0008:000a
Aug 19 14:04:24 turing-police kernel: eth1: Looks like a Lucent/Agere firmware version 8.10
Aug 19 14:04:24 turing-police kernel: eth1: Ad-hoc demo mode supported
Aug 19 14:04:24 turing-police kernel: eth1: IEEE standard IBSS ad-hoc mode supported
Aug 19 14:04:24 turing-police kernel: eth1: WEP supported, 104-bit key
Aug 19 14:04:25 turing-police kernel: eth1: MAC address 00:02:2D:5C:11:48
Aug 19 14:04:25 turing-police kernel: eth1: Station name "HERMES I"
Aug 19 14:04:25 turing-police kernel: eth1: ready
Aug 19 14:04:25 turing-police kernel: eth1: index 0x01: Vcc 3.3, irq 9, io 0x0100-0x013f
Aug 19 14:04:25 turing-police kernel: eth1: New link status: Connected (0001)
Aug 19 14:04:25 turing-police kernel: eth1: no IPv6 routers present

Aug 19 14:34:14 turing-police dhcpcd[746]: sending DHCP_REQUEST for 198.82.168.169 to 198.82.247.67
Aug 19 14:34:14 turing-police dhcpcd[746]: sendto: Socket operation on non-socket
Aug 19 14:34:14 turing-police dhcpcd[746]: broadcasting DHCP_REQUEST for 198.82.168.169
Aug 19 14:34:14 turing-police dhcpcd[746]: sendto: Socket operation on non-socket
Aug 19 14:34:14 turing-police dhcpcd[746]: dhcpStop: ioctl SIOCSIFADDR: Inappropriate ioctl for device
Aug 19 14:34:14 turing-police dhcpcd[746]: dhcpStop: ioctl SIOCSIFFLAGS: Inappropriate ioctl for device
Aug 19 14:34:14 turing-police dhcpcd[746]: broadcasting DHCP_DISCOVER
Aug 19 14:34:14 turing-police dhcpcd[746]: broadcastAddr option is missing in DHCP server response. Assuming 198.82.168.255
Aug 19 14:34:14 turing-police dhcpcd[746]: broadcasting second DHCP_DISCOVER

Aug 19 14:34:14 turing-police dhcpcd[746]: DHCP_OFFER received from  (198.82.247.67)
Aug 19 14:34:14 turing-police dhcpcd[746]: broadcasting DHCP_REQUEST for 198.82.168.169 

> - cardmgr messages from system log

Aug 19 14:04:13 turing-police pcmcia:  cardmgr.
Aug 19 14:04:13 turing-police cardmgr[657]: starting, version is 3.1.31
Aug 19 14:04:13 turing-police rc: Starting pcmcia:  succeeded
Aug 19 14:04:13 turing-police modprobe: FATAL: Module /dev/cm_657_2 not found. 
Aug 19 14:04:13 turing-police modprobe: FATAL: Module /dev/cm_657_5 not found. 
Aug 19 14:04:13 turing-police modprobe: FATAL: Module /dev/cm_657_8 not found. 
Aug 19 14:04:13 turing-police modprobe: FATAL: Module /dev/cm_657_11 not found.
Aug 19 14:04:13 turing-police cardmgr[657]: watching 3 sockets
Aug 19 14:04:13 turing-police cardmgr[657]: Card Services release does not match
Aug 19 14:04:13 turing-police cardmgr[657]: socket 0: CardBus hotplug device
Aug 19 14:04:14 turing-police cardmgr[657]: socket 2: Intersil PRISM2 11 Mbps Wireless Adapter 
Aug 19 14:04:14 turing-police cardmgr[657]: executing: 'modprobe hermes'
Aug 19 14:04:14 turing-police cardmgr[657]: + FATAL: Module hermes not found.
Aug 19 14:04:14 turing-police cardmgr[657]: modprobe exited with status 1
Aug 19 14:04:14 turing-police cardmgr[657]: module /lib/modules/2.6.0-test3-mm3/pcmcia/hermes.o not available
Aug 19 14:04:14 turing-police cardmgr[657]: executing: 'modprobe orinoco'
Aug 19 14:04:14 turing-police cardmgr[657]: + FATAL: Module orinoco not found.
Aug 19 14:04:14 turing-police cardmgr[657]: modprobe exited with status 1
Aug 19 14:04:14 turing-police cardmgr[657]: module /lib/modules/2.6.0-test3-mm3/pcmcia/orinoco.o not available
Aug 19 14:04:15 turing-police cardmgr[657]: executing: './network start eth1'
Aug 19 14:04:15 turing-police /etc/hotplug/net.agent: invoke ifup eth1

Looking at an earlier boot, the only difference seems to be that net.agent is now
invoking 'ifup'...

Now to figure out why the 100mbit Ethernet won't answer ARP if the wireless card is up,
I suspect it's related to that other thread...  :)

--==_Exmh_-1097139492P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/QnkMcC3lWbTT17ARAlAnAKCGyQ6JssDtRuhix1OQ7TwxjAzWEgCgxy2b
RJlTSinOLONUmM8Op+qPuWc=
=eHUR
-----END PGP SIGNATURE-----

--==_Exmh_-1097139492P--
