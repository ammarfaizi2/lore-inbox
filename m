Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313565AbSDLM4s>; Fri, 12 Apr 2002 08:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313313AbSDLM4r>; Fri, 12 Apr 2002 08:56:47 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:27332 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S313565AbSDLM4q>;
	Fri, 12 Apr 2002 08:56:46 -0400
Date: Fri, 12 Apr 2002 14:57:08 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Josh Fryman <fryman@cc.gatech.edu>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Stolen Memory <- i830M video chip
Message-ID: <20020412145708.A19195@crystal.2d3d.co.za>
Mail-Followup-To: Josh Fryman <fryman@cc.gatech.edu>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204112244480.4745-100000@LiSa> <20020412094323.B8997@crystal.2d3d.co.za> <20020412073136.53e533ed.fryman@cc.gatech.edu> <20020412143909.A17660@crystal.2d3d.co.za> <20020412085204.2202df0e.fryman@cc.gatech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 2:53pm  up 16 days,  5:09, 14 users,  load average: 0.81, 0.51, 0.29
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh!

> i've cut the key bits out for back-reference.  (btw, your .sig is kinda
> hefty :)
>=20
> > > so if it's a BIOS problem that can only be fixed by Dell, how were th=
ese guys
> > > able to do the fix?  and why can't the open source guys (XFree or Lin=
ux kernel)=20
> > > seem to do the same?
> >=20
> > I've told people before: If you want it to work, write a non-BIOS setmo=
de.
> > I'll even give you tips if you try, but that is all I can do.=20
>=20
> ok, let me see if i'm following what you're saying.  the XFree86 drivers =
don't
> use the BIOS or anything else - they rely on the kernel.  the kernel, how=
ever,=20
> is relying on the BIOS to tell it what's going on.  when the I8x0 video i=
nterface
> activates, it asks the BIOS which lies through its teeth.

No, the X Server is using the BIOS to set video modes. Since the video
chipset doesn't have any onboard memory, it needs to "steal" some of your
system memory. The BIOS does that for you (hence the term stolen memory).
However, if your BIOS steals only 1mb memory, it isn't enough to support
high resolution modes.

This isn't a problem since we allocate more memory by stealing some memory
in the kernel and then populating the card's page table with those pages.
The problem is that the BIOS don't know about those extra pages and when you
do a setmode, it checks whether there is enough memory, sees only 1mb and
then refuses to set the mode...

--=20

Regards
 Abraham

I give you the man who -- the man who -- uh, I forgets the man who?
		-- Beauregard Bugleboy

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ttmkzNXhP0RCUqMRAnloAJ9oF5IOw1h4cWgNmkqCeDNo1N4kpACfU43W
48QvGOlyuBat5XPqzMvL/rA=
=y/Y0
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
