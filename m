Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUDYRuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUDYRuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 13:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUDYRuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 13:50:12 -0400
Received: from exoskeleton.math.harvard.edu ([140.247.28.55]:18954 "EHLO
	petunia.bostoncoop.net") by vger.kernel.org with ESMTP
	id S263059AbUDYRuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 13:50:02 -0400
Date: Sun, 25 Apr 2004 13:50:00 -0400
From: Dylan Thurston <dpt@math.harvard.edu>
To: linux-kernel@vger.kernel.org
Subject: pcnet_cs driver freezes in 2.6.5 when link beat detected on Gateway Solo 9100
Message-ID: <20040425175000.GA19190@exoskeleton.math.harvard.edu>
Reply-To: dpt@math.harvard.edu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I'm seeing a strange problem, of a type I haven't seen reported before.

I'm using a Gateway Solo 9100, using Debian's stock 2.6.5 kernel, and
the pcnet_cs driver for a D-Link DMF-560TXD card.  The card is detected
fine when it is inserted and the driver is loaded, but as soon as the
network cable is attached (i.e., the link beat is detected) the system
freezes and doesn't produce any output or respond to any input, not even
SysRq.(*)  When the network cable is removed, the system returns to
life, and the following message is logged to the console:

  Trying to free nonexistent resource <0000af8-00000aff>

This problem also occurs with 2.4.25; I haven't check other kernels
extensively.  See below for the output of 'lspci -v'

Any leads?  Please CC me on responses.

Thanks,
	Dylan Thurston

(*) The Debian stock kernel does not have SysRq compiled in; this
comment applies to a 2.4.25 kernel I compiled myself.


00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 02)
	Flags: bus master, medium devsel, latency 64
	Memory at <unassigned> (32-bit, prefetchable) [size=256M]

00:02.0 VGA compatible controller: Trident Microsystems Cyber 9397 (rev f3) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Memory at fe400000 (32-bit, non-prefetchable) [size=4M]
	Memory at fede0000 (32-bit, non-prefetchable) [size=128K]
	Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:04.0 Multimedia video controller: C-Cube Microsystems: Unknown device 6120
	Flags: bus master, fast devsel, latency 120, IRQ 10
	I/O ports at fcc0 [size=64]
	I/O ports at fc70 [size=8]
	I/O ports at fc7c [size=4]
	I/O ports at fc88 [size=4]
	I/O ports at fc8c [size=4]

00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at fc90 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at fca0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

00:0a.0 CardBus bridge: Cirrus Logic PD 6832 (rev c1)
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Cirrus Logic PD 6832 (rev c1)
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 10c00000-10fff000
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAi/pIVeybfhaa3tcRAlbxAKChnFXshML0aBzRWeS93ppP/fmvgQCeJgMe
M/zULn6ki89Z0D3Sbf/6lvM=
=UV/A
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
