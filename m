Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUILU75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUILU75 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 16:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUILU75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 16:59:57 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:46341 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261610AbUILU7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 16:59:53 -0400
Date: Sun, 12 Sep 2004 22:59:51 +0200
From: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
To: linux-kernel@vger.kernel.org
Subject: Re: iMac G3 IPv6 issue
Message-ID: <20040912205951.GB11293@caladan.roxor.be>
Reply-To: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040912133936.GA11099@caladan.roxor.be> <1095011851.4995.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <1095011851.4995.54.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2004 at 06:57:31PM +0100, David Woodhouse wrote:
> On Sun, 2004-09-12 at 15:39 +0200, Aur=E9lien G=C9R=D4ME wrote:
> > I put IPv6 support, but the console is flooded by a lot of:
> > hw tcp v6 csum failed
> > However, IPv6 works, and IPv4 packets do not have this kind of issue.
> > The network card is a Sun Gem. It is kind of weird to see bad packets.
>=20
> I use the sungem in a similar machine with IPv6, and haven't seen any
> problems. Can you tcpdump from a different machine on the network and
> confirm whether these reported bad checksums really are happening or if
> it's the fault of the hardware/driver?

I have 2 machines on the same switch and an IPv6 ssh connection between
them.

"tcpdump -a -i eth0 -v" on both machines shows [tcp sum ok].

The ssh link is an IPv6 one, arwen is the faulty machine, and aragorn a
sane one.

arwen has also a ppp0 interface, no infamous [bad tcp cksum ....!]
appears, on lo interface too. All is reported [tcp sum ok].

But during this time, the kernel keeps flooding the console with these
"hw tcp v6 csum failed"...

Moreover, like I said, the IPv6 networking works fine.

In that case, is it the driver fault?

I wonder if it is possible to print the checksum and the interface with
the LIMIT_NETDEBUG(printk(KERN_DEBUG "hw tcp v6 csum failed\n"));.

Bests.
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
BOFH excuse #88: Boss' kid fucked up the machine

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBRLjHkFH2kwPhoXIRAiS7AJ49IeGyNN55h65R++56/IPIuFvbXACdHXCZ
qc6X6wFmggvUClMqZVlkzpU=
=xdUd
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
