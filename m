Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264239AbUD0Rgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbUD0Rgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUD0Rgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:36:37 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:20129 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264239AbUD0Rfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:35:51 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Ian Kumlien <pomac@vapor.com>
To: a.verweij@student.tudelft.nl
Cc: Ross Dickson <ross@datscreative.com.au>, Len Brown <len.brown@intel.com>,
       Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QULf/QG91JAPwPWrYJxq"
Message-Id: <1083087349.13827.21.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 19:35:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QULf/QG91JAPwPWrYJxq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-04-27 at 19:02, Arjen Verweij wrote:
> Hello,
>=20
> I'm sorry for the small interlude in this thread, but I just want to get
> something clear.

Imho it was a nice summation of the situation and it might be welcome
for ppl that just started reading about this.

> Basically we have a problem that is all around, except for (some) Shuttle
> boards. Noone really knows what's going on, or at least if they know they
> are not vocal about it.

Yep, and asus seems to only add support for new ram manuf in dual ddr
mode.

> In comes Ross Dickson. He starts poking at the problem until he comes up
> with two patches. Near the end of 2003, an NVIDIA engineer (Allen Martin)
> states that he (or maybe NVIDIA as a whole?) has been unable to reproduce
> this weird problem with hard locks, seemingly related to APIC and IO.



> He can tell us there was a bug in a reference BIOS that NVIDIA sent out
> into the world, but that it has been fixed in a follow-up. Somewhere at
> the start of December, Shuttle updates its BIOS for the AN35. Jesse Allen
> flashes the new BIOS into his board and for reasons unknown his hard lock
> problem has vanished. The importance of the update of NVIDIA's reference
> BIOS in relation to the Shuttle update of the BIOS for their product(s) i=
s
> unknown as well.



> Meanwhile, Ross Dickson drops requests for support tickets at AMD and
> NVIDIA. Until this day, no reply yet. Unaffected by the deafening silence
> he keeps improving his patches which seem to work(tm).

Yep, and we are all great full for that =3D), thanks Ross.

> Without Ross' hard labor one can avoid the hard locks by banning APIC
> support from the kernel, or turn off the C1 disconnect feature in the
> BIOS, which is misinterpreted by one ACPI developer as running the CPU
> "out of spec."

Well, it gets hot... like hell.

> Recently Len Brown, the ACPI Linux kernel maintainer and Intel employee -
> can you spot the irony? - agrees to attempt to reproduce the problem.
> After having his box run with cat /dev/hda > /dev/null for a night
> straight no lockup has occured. The brand of his motherboard is Shuttle.
> Did I mention irony...?

Heh.

> Although this topic is primarily about nforce2 chipsets, similar problems
> have been reported with SiS chipsets for AMD cpus. Other chipsets capable
> of having the CPU disconnect include VIA KT266(A), KT333 and KT400. For
> linux a tool like athcool can set the bits for the disconnect and the HLT
> instruction. It is unconfirmed that these chipsets suffer from the same
> symptoms as nforce2 chipsets.

There are several other things that can nuke machines though.
A friend has problem with dma on a intel chipset (i keep monitoring the
changelogs for fixes) but he has problems getting a > 20 says uptime.
(crashes faster with dma enabled)

My firewall, a VIA Samuel 2 (microitx) dies after a few hours if you
enable cpu freq. But it also seems like it changes cpu speed to often.

The common denominator with my fw and my desktop is 'to often'. Which
leads me to suspect that the Hz change from 100 -> 1000 could be
somewhat responsible. Could it be that we just run it to often and thus
worsen the impact? And C1 disconnect shouldn't be run that often imho.
Neither should cpu freq.

Perhaps some throttling would have about the same affect as Ross patches
(which is what his original patches did, but not to the C1 disconnect or
the HLT instruction. Could it be that some kernel code isn't well
adapted to the 100 -> 1000 change?)

Anyways, that my 0.2 eur

> Does anyone have some input on how to tackle this problem? The only thing=
s
> I can come up with is mailing all the motherboard manufacturers I can
> think of, harass NVIDIA and/or AMD some more through proper channels (i.e=
.
> file a "bug report", but I don't expect much from this, sorry Allen) or
> buy Len the cheapest broken nforce2 board I can find at pricewatch.com an=
d
> have it shipped to his house :)

Heh, that would be fun if he's willing to do the work/research =3D).

PS. CC, since i'm not on this list.
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-QULf/QG91JAPwPWrYJxq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAjpn17F3Euyc51N8RAiAeAJ9+QkToh9CamHTbB4c508fXIiVZeACgqJDa
CVK2BSgcLx8MdrqS1oGk7AQ=
=qS9C
-----END PGP SIGNATURE-----

--=-QULf/QG91JAPwPWrYJxq--

