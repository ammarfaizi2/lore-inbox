Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWBFTeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWBFTeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWBFTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:34:45 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:15301 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932316AbWBFTep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:34:45 -0500
Message-ID: <43E7A4C0.4020209@t-online.de>
Date: Mon, 06 Feb 2006 20:34:24 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, Ed Sweetman <safemode@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net> <43E3D103.70505@comcast.net> <Pine.LNX.4.58.0602060836520.1309@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0602060836520.1309@shark.he.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig61D7DA4E8083AE4CFD331422"
X-ID: ZeDyRwZDreRpIT4veXIucBoUVagEnWvreyvhwAi63A99kGh-4xQu4x
X-TOI-MSGID: 3c484fd9-056d-43d3-bf78-4b7d808b18cc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61D7DA4E8083AE4CFD331422
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

Randy.Dunlap wrote:
> On Fri, 3 Feb 2006, Ed Sweetman wrote:
> 
> 
> 
> Agreeing with your paragraph above.  I tested my SATA ATAPI CD/DVD
> drive with libata/PATA (ata_piix controller driver) and could not
> see the CD/DVD drive.
> 

Maybe it would be of general interest if somebody could post
how it is _supposed_ to work? Is there a conflict between
ata_piix and piix/mpiix? A short summary could be very helpfull
to identify problems, and to reduce confusion.

I got the impression that the current implementation seems to
be very fragile wrt. the kernel configuration, the module load
sequence, and the attributes to libata.


Hardware (Aopen MZ915-M):

0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O Controller (rev 0e)
0000:00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL Express Chipset Family Graphics Controller (rev 0e)
0000:00:02.1 Display controller: Intel Corporation 82915G Express Chipset Family Graphics Controller (rev 0e)
0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04)
0000:00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 4 (rev 04)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d4)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 04)
0000:00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 04)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit Ethernet Controller (rev 19)
0000:03:00.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)

0000:00:00.0 0600: 8086:2580 (rev 0e)
0000:00:02.0 0300: 8086:2582 (rev 0e)
0000:00:02.1 0380: 8086:2782 (rev 0e)
0000:00:1b.0 0403: 8086:2668 (rev 04)
0000:00:1c.0 0604: 8086:2660 (rev 04)
0000:00:1c.3 0604: 8086:2666 (rev 04)
0000:00:1d.0 0c03: 8086:2658 (rev 04)
0000:00:1d.1 0c03: 8086:2659 (rev 04)
0000:00:1d.2 0c03: 8086:265a (rev 04)
0000:00:1d.3 0c03: 8086:265b (rev 04)
0000:00:1d.7 0c03: 8086:265c (rev 04)
0000:00:1e.0 0604: 8086:244e (rev d4)
0000:00:1f.0 0601: 8086:2640 (rev 04)
0000:00:1f.2 0101: 8086:2651 (rev 04)
0000:00:1f.3 0c05: 8086:266a (rev 04)
0000:02:00.0 0200: 11ab:4362 (rev 19)
0000:03:00.0 0400: 4444:0016 (rev 01)


Many thanx

Harri

--------------enig61D7DA4E8083AE4CFD331422
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD56TIUTlbRTxpHjcRAvaDAJ98VO2Xs7TxNSofZ29aUGF7pNK1VgCdEbJC
HKCuY0lR39/vg5GGP5oXA/U=
=rV7r
-----END PGP SIGNATURE-----

--------------enig61D7DA4E8083AE4CFD331422--
