Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWHDLle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWHDLle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 07:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWHDLld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 07:41:33 -0400
Received: from nsm.pl ([195.34.211.229]:34058 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S932604AbWHDLld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 07:41:33 -0400
Date: Fri, 4 Aug 2006 13:41:25 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Checksumming blocks? [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060804114125.GA10814@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF84F0.8080303@slaphack.com> <1154452770.15540.65.camel@localhost.localdomain> <44CF9217.6040609@slaphack.com> <20060803135811.GA7431@merlin.emma.line.org> <44D285DF.7060905@elegant-software.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <44D285DF.7060905@elegant-software.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2006 at 07:25:19PM -0400, Russell Leighton wrote:
>=20
> If the software (filesystem like ZFS or database like Berkeley DB) =20
> finds a mismatch for a checksum on a block read, then what?
>=20
> Is there a recovery mechanism, or do you just be happy you know there is=
=20
> a problem (and go to backup)?

  ZFS readsthis block again from different mirror, and if checksum is
right -- returns good data to userspace and rewrites failed block with
good data.

  Note, that there could be multiple mirrors, either physically (like
RAID1) or logically (blocks could be mirrored on different areas of the
same disk; some files can be protected with multiple mirrors, some left
unprotected without mirrors).

--=20
Tomasz Torcz                        To co nierealne -- tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na =BFycie maj=B1 tu patenty spe=
cjalne.


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFE0zJlThhlKowQALQRAk57AKClX8ImQo/m9pvJMdQAhe5nhLMBZgCgzXBd
1DZZ5DjgPTisaa//iQWI/E0=
=8u98
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
