Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVEMTUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVEMTUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVEMTRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:17:21 -0400
Received: from remus.commandcorp.com ([130.205.32.4]:16095 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S262497AbVEMTPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:15:17 -0400
Subject: Re: Sync option destroys flash!
From: "Michael H. Warfield" <mhw@wittsend.com>
Reply-To: mhw@wittsend.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mhw@wittsend.com
In-Reply-To: <1116009619.9371.494.camel@localhost.localdomain>
References: <1116001207.5239.38.camel@localhost.localdomain>
	 <1116009619.9371.494.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nlZk2aFDOPgpWBpomdBb"
Organization: Thaumaturgy & Speculms Technology
Date: Fri, 13 May 2005 15:10:30 -0400
Message-Id: <1116011430.5239.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
X-MailScanner-From: mhw@wittsend.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nlZk2aFDOPgpWBpomdBb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey Alan,

On Fri, 2005-05-13 at 19:40 +0100, Alan Cox wrote:
> > 	What happens, with the sync option on a VFAT file system, is that the
> > FAT tables are getting pounded and over-written over and over and over
> > again as each and every block/cluster is allocated while a new file is
> > written out.  This constant overwriting eventually wears out the first
> > block or two of the flash drive.

> All non-shite quality flash keys have an on media log structured file
> system and will take 100,000+ writes per sector or so. They decent ones
> also map out bad blocks and have spares. The "wear out the same sector"
> stuff is a myth except on ultra-crap devices.

	That's easy enough to say but AFAICT there doesn't seem to be any easy
well to tell the good from the bad from the just plain ugly.  I
typically don't buy junk (I didn't think), but I've definitely
experienced this, first hand, with Sony Memory Vaults, SanDisk CF cards,
some SimpleTech CF cards, some SmartMedia cards (what an oximoron that
is), and now this 1G USB stick (which was, I admit, an "off brand" I had
never heard of before at Frys Electronics).  The CF cards were burned up
in a PDA, so it's not just this.  For a myth, I've definitely seen too
much of it.

	Strangely (and in response to another comment someone made) some USB
cards which I reformated for ext2 have survived quite well.

> > 	I'm also going to file a couple of bug reports in bugzilla at RedHat
> > but this seems to be a more fundamental problem than a RedHat specific
> > problem.  But, IMHO, they should never be setting that damn sync flag
> > arbitrarily.

> It sounds like your need to find a vendor who makes decent keys. For
> that matter several vendors now offer life time guarantees with their
> USB flash media.

	Now THAT I gotta check into.  I never noticed anything on the packaging
about a guarantee, but I will now.  But how do you determine which are
"decent" keys?  They don't put stickers on them saying "this one is
decent" and "this one is junk" and I'm an old cynic who has learned that
price is not always a good indicator either.  Maybe the guarantee will
be a clue.  I've just got to shop for it more.

> Sync gets set by RH because it seemed the right thing to do to handle
> random user device pulls. Now O_SYNC works so excessively well on
> fat/vfat that needs looking at - and as you say likewise perhaps the
> nature of the FAT rewriting.

> However its not a media issue, its primarily a performance issue.

	Yeah, several of us have noticed the performance issue!

> Alan

	Mike
--=20
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com =20
  /\/\|=3Dmhw=3D|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/=
mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

--=-nlZk2aFDOPgpWBpomdBb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQCVAwUAQoT7puHJS0bfHdRxAQKuQAP/VyjXuZVtezkEs0oBc8xC2O2tuiOaQl1o
dnYu8m4AXBkKWl8gSraGb4E1EZmbg0OLyRYaeBVKoDqsQm6Iz48WGZnn7n/EDxvS
mGsehsBUNQ95HdIsSx26wuz5Ei8i6tq20QAZSOhlc5RRlckKpMhmWgZfNUnXvpIH
rqEh+rjZSmc=
=H379
-----END PGP SIGNATURE-----

--=-nlZk2aFDOPgpWBpomdBb--

