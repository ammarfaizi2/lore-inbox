Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132119AbQLOPCO>; Fri, 15 Dec 2000 10:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131938AbQLOPCE>; Fri, 15 Dec 2000 10:02:04 -0500
Received: from ns.snowman.net ([63.80.4.34]:46349 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S130376AbQLOPBv>;
	Fri, 15 Dec 2000 10:01:51 -0500
Date: Fri, 15 Dec 2000 09:30:16 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
Message-ID: <20001215093016.S26953@ns>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Netfilter <netfilter@us5.samba.org>
In-Reply-To: <Pine.LNX.4.10.10012141552180.12695-100000@penguin.transmeta.com> <Pine.LNX.4.30.0012142244200.27741-100000@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lV0sGir0hZRRmFZQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012142244200.27741-100000@waste.org>; from oxymoron@waste.org on Thu, Dec 14, 2000 at 10:58:05PM -0600
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 9:26am  up 120 days, 13:16,  8 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lV0sGir0hZRRmFZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Oliver Xymoron (oxymoron@waste.org) wrote:
> On Thu, 14 Dec 2000, Linus Torvalds wrote:
>=20
> > A 100ms delay sounds like some interrupt shut up or similar (and then
> > timer handling makes it limp along).
>=20
> Possibly related datapoint: after several days of uptime, my
> 2.4.0-test10pre? machine went into some sort of slow mode after coming
> back from suspend (and doing an /etc/init.d/networking restart). Symptoms
> seemed to be extra second or so setting up a TCP connection. Ping, etc.,
> appeared to work just fine, no packet loss apparent, bandwidth looked good
> too. Sadly I had to do actual work that required zippy web access, so I
> rebooted rather than doing a thorough diagnostic. This is a VAIO with
> compiled in eepro100, no special networking options.

	Actually, I figured out what it was and I feel kind of stupid, and
suprised.  I knew I should have tried rebooting before complaining.  It
turns out it actually was something in my firewall rules, it appears that
for every logged packet there is something along the lines of a 100ms
delay that gets added on.

	Not sure if that is something that could be easily fixed or not, or
perhaps I'm doing something wrong, but that seems unlikely since all I
changed was if it jumped to the LOG chain or not.

		Stephen

--lV0sGir0hZRRmFZQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Oir4rzgMPqB3kigRArbyAJ0RtCjh7eERyAnIdTnKosAB2vRmhQCeMhMk
+4s5xcIEdMD1z5G+4ejv1Ps=
=pt99
-----END PGP SIGNATURE-----

--lV0sGir0hZRRmFZQ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
