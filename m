Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSLZI0R>; Thu, 26 Dec 2002 03:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSLZI0R>; Thu, 26 Dec 2002 03:26:17 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:20961 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262646AbSLZI0P>; Thu, 26 Dec 2002 03:26:15 -0500
Date: Thu, 26 Dec 2002 00:34:05 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA and hermer/orinoco_cs drivers b0rken?
Message-Id: <20021226003405.014f0638.joshk@mspencer.net>
In-Reply-To: <87u1h3fim2.fsf@lapper.ihatent.com>
References: <87u1h3fim2.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Uv0p)t6z73BkA7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Uv0p)t6z73BkA7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Are you using the modules from the kernel source or from pcmcia-cs? Are
you using yenta_socket or pcmcia-cs? pcmcia-cs has given me a lot more
positive results than trying to use yenta_socket and the built in kernel
modules. Also, try binding your card IDs to use wavelan_cs instead and
see if it works (maybe those cards are a bit older and as such need
older drivers.)

Also see if /sbin/iwconfig (hopefully you have this gem installed, it's
wireless-tools by Jean Tourrilhes @
http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html) gives
you any useful information. Is it picking up an AP?

Finally, ACPI might not make a difference, but see if enabling or
disabling APM does.

Hope this helps you.
Regards

-Josh

I have nearly the same setup as you
Rabid cheeseburgers forced Alexander Hoogerhuis<alexh@ihatent.com> to
write this on 24 Dec 2002 18:10:29+0100:	

> Since very early 2.4 somewhere it has been impossible to use my two
> wireless cards, a NetGear ME401 and a Lucent card (both
> orinoco-based). Both are able to load the modules when pluggen in, but
> trying to use them is futile, as nothing gets transmitted, and dmesg
> show tons of this:
> 
> eth1: Station identity 001f:0006:0001:0003
> eth1: Looks like an Intersil firmware version 1.03
> eth1: Ad-hoc demo mode supported
> eth1: IEEE standard IBSS ad-hoc mode supported
> eth1: WEP supported, 104-bit key
> eth1: MAC address 00:09:5B:27:DC:F9
> eth1: Station name "Prism  I"
> eth1: ready
> eth1: index 0x01: Vcc 5.0, irq 6, io 0x0100-0x013f
> NETDEV WATCHDOG: eth1: transmit timed out
> eth1: Tx timeout! Resetting card. ALLOCFID=0128, TXCOMPLFID=0127,
> EVSTAT=800c eth1: Error -110 writing packet to BAP
> eth1: Error -110 writing Tx descriptor to BAP
> eth1: Error -110 writing Tx descriptor to BAP
> NETDEV WATCHDOG: eth1: transmit timed out
> eth1: Tx timeout! Resetting card. ALLOCFID=0128, TXCOMPLFID=0127,
> EVSTAT=800c
> 
> The situation is similar for both cars, and I'm wondering if this is
> a known broken setup, or I've messed up?
> 
> Currnently I'm on 2.4.20, tried both with and without the ACPI and
> preempt patches (vmware deosnt make a difference either), the hardware
> is a Compaq Evo n800c notebook and this is the cardbus bridge:
> 
> 02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
> Controller (rev 02)
> 	Subsystem: Compaq Computer Corporation: Unknown device 004a
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> 	ParErr- Stepping- SERR- FastB2B- Status: Cap+ 66Mhz- UDF-
> 	FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
> 	<PERR- Latency: 168, cache line size 20
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 40000000 (32-bit, non-prefetchable)
> 	[size=4K] Bus: primary=02, secondary=03, subordinate=03,
> 	sec-latency=176 Memory window 0: 30400000-307ff000
> 	(prefetchable) Memory window 1: 30800000-30bff000
> 	I/O window 0: 00004800-000048ff
> 	I/O window 1: 00004c00-00004cff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
> 	PostWrite+ 16-bit legacy interface ports at 0001
> 
> mvh,
> A
> -- 
> Alexander Hoogerhuis                               | alexh@ihatent.com
> CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
> "You have zero privacy anyway. Get over it."  --Scott McNealy
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc

--=.Uv0p)t6z73BkA7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Cr7/6TRUxq22Mx4RAv5dAJ9lcD0j6AqvAYA3obEQhsjK4164ZQCeJlon
oA2rsXGbszJC+RH7OEAKi4M=
=xrnu
-----END PGP SIGNATURE-----

--=.Uv0p)t6z73BkA7--
