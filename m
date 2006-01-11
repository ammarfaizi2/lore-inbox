Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWAKBJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWAKBJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWAKBJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:09:21 -0500
Received: from smtp06.auna.com ([62.81.186.16]:10727 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S932567AbWAKBJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:09:20 -0500
Date: Wed, 11 Jan 2006 02:13:18 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060111021318.7e61384c@werewolf.auna.net>
In-Reply-To: <43C40803.2000106@rtr.ca>
References: <20060110125852.GA3389@suse.de>
	<20060110132957.GA28666@elte.hu>
	<20060110133728.GB3389@suse.de>
	<Pine.LNX.4.63.0601100840400.9511@winds.org>
	<20060110143931.GM3389@suse.de>
	<Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
	<43C3E9C2.1000309@rtr.ca>
	<20060110173217.GU3389@suse.de>
	<43C3F0CA.10205@rtr.ca>
	<43C403BA.1050106@pobox.com>
	<43C40803.2000106@rtr.ca>
X-Mailer: Sylpheed-Claws 1.9.100cvs129 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_MSYg9WSM_L1+r1OeuR2EIFU;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.223.226] Login:jamagallon@able.es Fecha:Wed, 11 Jan 2006 02:09:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_MSYg9WSM_L1+r1OeuR2EIFU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jan 2006 14:16:19 -0500, Mark Lord <lkml@rtr.ca> wrote:

> Okay, fixed the ordering of the "default" lines
> so that the Kconfig actually works correctly.
>=20
> Best for Andrew to soak this one in -mm.
>=20
> Signed-off-by:  Mark Lord <mlord@pobox.com>
>=20

Working nice on top of 2.6.15-mm2.
Even with the 'evil binary' nVidia driver 8178 ;).
In fact, I have been using the 1Gb-lowmem patch on -mm and the nVidia
driver since long ago, without problems.

I really like to see this in -mm, and finally in mainline.

My only objection is about the menu entry names and help. I think
people building a kernel would not exactly understand what all this is
about (even I think I don't have it realle clear).

Is there any doc which states clearly somthing like:

- no highmem is the fastest
- 4Gb introduces one indirection, so it is slower...(really ?)
- 64Gb introduces two (PAE ?)

mixed with

- 3G/1G standard maping:
   - nor user nor kernel can use any memory above 860 Mb
   - user processes (my numbercruncher) can not allocate more than XGb
- 2G/2G: idem:
   - max memory seen by my linux system (not kernel, but kernel+userspace,
   - how much can I allocate for a single process (how big my problem
     can be ?)

If there is already a doc like that, it would be very interesting to
have pointer/link to it in the help text.

For example, when I read this:

+	  If the address range available to the kernel is less than the
+	  physical memory installed, the remaining memory will be available
+	  as "high memory". Accessing high memory is a little more costly
+	  than low memory, as it needs to be mapped into the kernel first.

Does this mean that with 3/1 standard split, I still can use the lost
128 Mb for something ? I though I can't.

Don't be too hard with me, just anxious to finally understand this...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam2 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_MSYg9WSM_L1+r1OeuR2EIFU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDxFuuRlIHNEGnKMMRAu/iAJ4wgP2qbGkQW93NhW2HpB0xaD3y3ACeJ6ka
KgsuS+o1b408Pa0m2J3FN/s=
=oo05
-----END PGP SIGNATURE-----

--Sig_MSYg9WSM_L1+r1OeuR2EIFU--
