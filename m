Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUILXRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUILXRj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUILXRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:17:38 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:5134 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263795AbUILXRf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:17:35 -0400
Date: Mon, 13 Sep 2004 01:17:31 +0200
From: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
To: linux-kernel@vger.kernel.org
Subject: Re: iMac G3 IPv6 issue
Message-ID: <20040912231730.GC11293@caladan.roxor.be>
Reply-To: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040912133936.GA11099@caladan.roxor.be> <1095011851.4995.54.camel@localhost.localdomain> <20040912155850.0e8fd0b5.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20040912155850.0e8fd0b5.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2004 at 03:58:50PM -0700, David S. Miller wrote:
> On Sun, 12 Sep 2004 18:57:31 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
>=20
> > On Sun, 2004-09-12 at 15:39 +0200, Aur=C3=A9lien G=C3=89R=C3=94ME wrote:
> > > I put IPv6 support, but the console is flooded by a lot of:
> > > hw tcp v6 csum failed
> > > However, IPv6 works, and IPv4 packets do not have this kind of issue.
> > > The network card is a Sun Gem. It is kind of weird to see bad packets.
> >=20
> > I use the sungem in a similar machine with IPv6, and haven't seen any
> > problems. Can you tcpdump from a different machine on the network and
> > confirm whether these reported bad checksums really are happening or if
> > it's the fault of the hardware/driver?
>=20
> One thing that's interesting is that the sungem and sunhme
> drivers are the only two in the whole tree that support
> IPV6 checksum offload.  Like David, I have never seen this
> problem on Sparc systems using the GEM chip and this
> driver.

The board is this:
0002:02:0f.0 Ethernet controller: Apple Computer Inc. UniNorth GMAC (Sun
GEM)

So, it is Apple stuff wrapping a Sun GEM chip. The issue may come from
that. Anyway, I am going to dig in the source code to find out.

Cheers.
--=20
        _,met$$$$$gg.        Aur=E9lien G=C9R=D4ME
     ,g$$$$$$$$$$$$$$$P.     Free Software Developer
   ,g$$P""       """Y$$.".   Unix Sys & Net Admin
  ,$$P'              `$$$.
',$$P       ,ggs.     `$$b:  Web: https://www.roxor.be/
`d$$'     ,$P"'   .    $$$   Mail: ag@roxor.be
 $$P      d$'     ,    $$P   GPG Key ID: 03E1A172
 $$:      $$.   -    ,d$$'
 $$;      Y$b._   _,d$P'    ))  GNU  ((   /   Linux
 Y$$.    `.`"Y$$$$P"'      //         \\
 `$$b      "-.__          ((__,-"""-,__))     .---.
  `Y$$b                    `--)~   ~(--`     /     \
   `Y$$.      Debian      .-'(       )`-.    \.@-@./
     `$$b.                `~~`@)   (@`~~`    /`\_/`\
       `Y$$b.                 |     |       //  _  \\
         `"Y$b._              |     |      | \     )|_
             `""""            (8___8)     /`\_`>  <_/ \
                               `---`      \__/'---'\__/
BOFH excuse #113: Root nameservers are out of sync

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBRNkKkFH2kwPhoXIRAtdjAJ0eh18GCmoBIgUo6waywgLGaONNiACeJGjd
3RJD96VRnbJKTbmyphdBUIg=
=NpKE
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
