Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSLPOrQ>; Mon, 16 Dec 2002 09:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSLPOrQ>; Mon, 16 Dec 2002 09:47:16 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:27520 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S263280AbSLPOrP>; Mon, 16 Dec 2002 09:47:15 -0500
Message-Id: <200212161454.gBGEs47t009027@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
Cc: zwane@holomorphy.com, davej@codemonkey.org.uk, pekon@informatics.muni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions) 
In-Reply-To: Your message of "Sat, 14 Dec 2002 09:28:19 PST."
             <336830.1039886899684.JavaMail.nobody@web11.us.oracle.com> 
From: Valdis.Kletnieks@vt.edu
References: <336830.1039886899684.JavaMail.nobody@web11.us.oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1199339868P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Dec 2002 09:54:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1199339868P
Content-Type: text/plain; charset=us-ascii

On Sat, 14 Dec 2002 09:28:19 PST, "ALESSANDRO.SUARDI" said:
> > On Fri, 13 Dec 2002 Valdis.Kletnieks@vt.edu wrote:
> > > On Fri, 13 Dec 2002 17:36:56 GMT, Dave Jones said:
> > >
> > > > It's my understanding that pci_enable_device() *must* be called
> > > > before we fiddle with dev->resource, dev->irq and the like.
> > >
> > > OK.. it looks like the problem only hits if it's a PCMCIA card *with an
> > > onboard ROM*.
> > Hmm i just saw this thread, which card is the non working one?;
> 
> It's a RBEM56G-100.
> 
> Sorry it took me a while to reply - Valdis' patch does fix the problem for
>  me, too. Awaiting for a final form of the fix in the upcoming series :)

Same here.  I was getting bit on a Xircom card:

03:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
03:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03)

Dave has a point about not poking IRQ's before it's initialized, so I think
I'll let him and Alan discuss the *right* way to fix it. (Though if there's
need to test a patch more elegant/correct than mine, I'm more than happy to
do so...)


-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1199339868P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9/ekMcC3lWbTT17ARAmtkAKD72nSkuXcm49wqwoOO/OGx/+JlqgCeOB7V
zE6aeQbpsdgwY9wkqUeluxQ=
=GFB6
-----END PGP SIGNATURE-----

--==_Exmh_1199339868P--
