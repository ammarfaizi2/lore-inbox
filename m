Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbUDFPGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUDFPGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:06:12 -0400
Received: from mout1.freenet.de ([194.97.50.132]:35783 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263856AbUDFPGC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:06:02 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: APIC error on CPU0
Date: Tue, 6 Apr 2004 17:05:46 +0200
User-Agent: KMail/1.6.2
References: <200404060057.i360vtNV012133@harpo.it.uu.se>
In-Reply-To: <200404060057.i360vtNV012133@harpo.it.uu.se>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Steve Youngs <sryoungs@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404061705.56852.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 06 April 2004 02:57, you wrote:
> On Mon, 5 Apr 2004 23:35:59 +0200, Michael Buesch wrote:
> >What does this kernel message mean?
> >
> >Apr  5 23:16:20 lfs kernel: APIC error on CPU0: 60(60)
> >Apr  5 23:16:31 lfs kernel: APIC error on CPU0: 60(60)
> >
> >kernel is 2.6.5 with reiser4 patch.
> 
> Send Illegal Vector and Receive Illegal Vector at the same time.
> This is more interesting than the usual 40(40) errors
> (just Receive Illegal Vector), since 60 implies that the
> CPU itself is the source of the bogus vector, whereas 40
> usually implies a crap mainboard.
> 
> My guess is that either your hardware (whatever it is,
> you didn't leave any clues) has problems with a noisy
> APIC bus, broken chipset, or something like that, or
> you enabled ACPI and the ACPI tables are crap.
> 
> In any event, Linux is probably not the source of the
> problem. You may need to run without I/O APIC ("noapic"
> kernel param), no ACPI-based PCI routing ("pci=noapci"),
> or completely without ACPI ("acpi=off").

Ok, thanks for this long explanation.
I think it's possible, that the reason is bad hardware.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcsdTFGK1OIvVOP4RAji5AJ9G4ms5U3ktWNDV0zih30XnPAMwxQCgqkxI
5bDE3Tki3a+BSSyWS1kw9+Q=
=Oqt5
-----END PGP SIGNATURE-----
