Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbQLOA2s>; Thu, 14 Dec 2000 19:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135292AbQLOA2j>; Thu, 14 Dec 2000 19:28:39 -0500
Received: from ns.snowman.net ([63.80.4.34]:58634 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S132669AbQLOA2F>;
	Thu, 14 Dec 2000 19:28:05 -0500
Date: Thu, 14 Dec 2000 18:56:21 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
Message-ID: <20001214185620.P26953@ns>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Netfilter <netfilter@us5.samba.org>
In-Reply-To: <20001214184544.O26953@ns> <E146iAI-0000IA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iASP2QDfFF5MN+I5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E146iAI-0000IA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 14, 2000 at 11:51:56PM +0000
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 8:28am  up 89 days, 12:22,  4 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iASP2QDfFF5MN+I5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> > machine?  For no apparent reason after 5 days running 2.4.0test12
> > everything going through my firewall (set up using iptables) I got about
> > 100ms time added on to pings and traceroutes.  I'll probably reboot the
> > machine tonight and see if that helps.
>=20
> Before you do that can you see if ifconfig down, rmmod, insmod, ifconfig =
up
> fixes it.=20

	This go around I compiled everything into the kernel, actually.
If it would be useful I can compile them as modules reboot and then see
what happens...

=3D=3D=3D# cat /proc/modules
ppp_deflate            39200   0 (autoclean)
bsd_comp                4160   0 (autoclean)
ppp_async               6512   1 (autoclean)
ppp_generic            15232   3 (autoclean) [ppp_deflate bsd_comp ppp_asyn=
c]
slhc                    4528   0 (autoclean) [ppp_generic]
=3D=3D=3D#

	I can say that cleaning out all my firewall rules and adding them
back didn't change behaviour any.  Also, I'm sure that this was not happeni=
ng
until today or maybe yesterday.  Earlier in the week the machine was doing
fine and I was getting reasonable response times.  Now, out *every* interfa=
ce,
I get something close to 100ms additional time.  Also of note, traceroutes
appear to be more lagged than pings, for what that's worth (traceroute using
udp, ping using icmp, dunno if it makes a difference).

		Stephen

--iASP2QDfFF5MN+I5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OV4krzgMPqB3kigRAs44AJ9RqjjAXlDaYo4LYochLVBU1O6ctwCeMmMu
O/FRntFXqGqPwerNSn/ECEE=
=PBE8
-----END PGP SIGNATURE-----

--iASP2QDfFF5MN+I5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
