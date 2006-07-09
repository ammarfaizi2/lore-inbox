Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWGIVFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWGIVFL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWGIVFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:05:10 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:4033 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161148AbWGIVFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:05:09 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Mon, 10 Jul 2006 07:04:59 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arjan van de Ven <arjan@infradead.org>,
       Sunil Kumar <devsku@gmail.com>, Bojan Smojver <bojan@rexursive.com>,
       Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <200607082125.12819.rjw@sisk.pl> <20060709121545.GA2736@srcf.ucam.org>
In-Reply-To: <20060709121545.GA2736@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1312810.m4sKxKAnvZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607100705.08374.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1312810.m4sKxKAnvZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 09 July 2006 22:15, Matthew Garrett wrote:
> On Sat, Jul 08, 2006 at 09:25:12PM +0200, Rafael J. Wysocki wrote:
> > Now there seem to be two possible ways to go:
> > 1) Drop the implementation that already is in the kernel and replace it
> > with the out-of-the-tree one.
>
> This would break existing interfaces to some extent, right? suspend2
> doesn't have the same set of tunables. I'm not sure whether this is
> something we especially care about, but it would potentially break some
> existing userland code.

I don't want to go this way immediately, but if we did, it doesn't need to=
=20
mean breakage for userland. Suspend2 could replace the tunables that swsusp=
=20
uses, so it could be a transparent replacement for swsusp, assuming that th=
e=20
filewriter was turned off by default. (I say this because if the filewriter=
=20
and swapwriter are both compiled in, the format for resume2 is

resume2=3D[swap|file]:/dev/<whatever><:offset>

But with only the swapwriter or only the filewriter, the "swap" or "file" i=
s=20
optional.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1312810.m4sKxKAnvZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsW+EN0y+n1M3mo0RAjlEAKDDXBVCeRaY7bTY1VzqFt4zLLLcPQCgmKIr
XvEWwm+3jGQePwKrKIVLID4=
=y7RI
-----END PGP SIGNATURE-----

--nextPart1312810.m4sKxKAnvZ--
