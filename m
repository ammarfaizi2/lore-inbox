Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265116AbRFZTvN>; Tue, 26 Jun 2001 15:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265115AbRFZTvC>; Tue, 26 Jun 2001 15:51:02 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:60461 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S265102AbRFZTu4>; Tue, 26 Jun 2001 15:50:56 -0400
Date: Tue, 26 Jun 2001 20:50:54 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Philip Blundell <philb@gnu.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically
Message-ID: <20010626205054.J7663@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0106260308100.1730-100000@freak.distro.conectiva> <20010626102303.K7663@redhat.com> <twaugh@redhat.com> <E15Ex7I-0008TV-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="YyxSosoRaUW6PdRh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15Ex7I-0008TV-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Tue, Jun 26, 2001 at 06:59:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YyxSosoRaUW6PdRh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2001 at 06:59:11PM +0100, Philip Blundell wrote:

> This would be a bit bad, because it would require people to guess
> whether they might have a card that parport_serial can drive and/or
> try loading the module to see what happens.

Not necessarily.  The module has a PCI device table, so a user-space
utility can figure it out and adjust /etc/modules.conf accordingly.

> I guess one option would be for parport_pc to somehow "know" what cards a=
re=20
> really multi-I/O ones, and only load parport_serial when it will be able =
to=20
> find something to do.  Doesn't seem all that appealing though.

Replace parport_pc's "knowledge" with parport_serial's PCI device
table and a user-space utility, and that's kind of what I had in
mind.

> If you do that then the code will effectively be there all the time,
> even when it's not needed.  You might as well just compile it in to
> parport_pc.  To be honest, there isn't all that much of it so maybe
> this wouldn't be such a bad idea.

Perhaps.

Tim.
*/

--YyxSosoRaUW6PdRh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7OOedONXnILZ4yVIRAlERAKCpgANy9pD4NL1VByhyik8GcAobtACfXM89
gqsFdV8dBm7FWH5bBSeR4LQ=
=uNjP
-----END PGP SIGNATURE-----

--YyxSosoRaUW6PdRh--
