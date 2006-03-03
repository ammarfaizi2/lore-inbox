Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWCCNj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWCCNj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWCCNj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:39:28 -0500
Received: from daemo09.udag.de ([62.146.33.133]:40584 "EHLO mail.udag.de")
	by vger.kernel.org with ESMTP id S1751441AbWCCNj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:39:27 -0500
From: Alexander Mieland <dma147@linux-stats.org>
Organization: Linux Statistics
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: how to find out which module was built by which .config variables?
Date: Fri, 3 Mar 2006 14:39:20 +0100
User-Agent: KMail/1.9
References: <200603031420.46801.dma147@linux-stats.org> <Pine.LNX.4.61.0603031434520.2581@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603031434520.2581@yvahk01.tjqt.qr>
X-Face: "[.(DJ7n08,b3KjixLk+L+kK%5O{[xod@~Mo/'mqsUN#[CVc-:2Bkl1K9W)=?utf-8?q?JoO=7C=2EtD=26N6y=0A=09V=3B=26ah=27=3Fox=3AmGfop=3AC=5BO=60=2E8?=
 =?utf-8?q?3Qk-vk=5FX?=@=glws(}Ts]sVCi'9Mw~Wm4nIqVQ)
 =?utf-8?q?b=27qvcxbNX=5E=7B=0A=09kG=3F=3DK=2EOy?="cn{u.05=LxYh{l^kU?Y,lu5rG?@~M_3xmKjrPm:
X-Count: Registered Linux-User #249600
X-ePatents: NO!!!!
X-Motto: Give drugs no chance!
X-Kernel: 2.6.15-ck3--r1-fb-my4 SMP
X-Cpu: 2x Intel Pentium 2,6 GHz with HT
X-Distribution: Gentoo 2005.1-r1
X-Homepage: http://www.linux-stats.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8796298.DhxF2u27B2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603031439.24367.dma147@linux-stats.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8796298.DhxF2u27B2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Friday 03 March 2006 14:35 schrieben Sie:
> >Hello,
> >
> >I need to create a database with configuration options (the ones
> >in .config) and the resulting kernel modules.
>
> Let's pick 8139too.ko for example.
> Find /usr/src/linux -name 8139too.ko
> In that same directory, look at the Makefile:
> obj-$(CONFIG_8139TOO) +=3D 8139too.o

Ahh, great, this helps much more!
Thanks. ;)


> >Is there any simple possibility (with bash and its applications) to
> > find out, which kernel modules will be built by which .config options?
> > I know that there are also many dependencies between the options and
> > the modules and I want to add them to the database too. The
> > dependencies can be found out with the Kconfig files, I think.
> >
> >I've already looked into the source files of some modules, but I can
> > not find any commonalities which would make it easy to find the
> > module-name which will be build.
> >
> >I've found some stuff like this:
> >#define DRIVER_NAME	"8139too"
> >or things linke:
> >#define <something>_MODULES_NAME	"some string which seems to be the
> >descriptive name"
> >
> >But this doesn't really help... :(

=2D-=20
Alexander 'dma147' Mieland                   2.6.15-ck3-r1-fb-my4 SMP
=46nuPG-ID: 27491179                      Registered Linux-User #249600
http://blog.linux-stats.org                http://www.linux-stats.org
http://www.mieland-programming.de          http://www.php-programs.de

--nextPart8796298.DhxF2u27B2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBECEcMCYRNlSdJEXkRAjTTAJ9Rr7DYHizSCxdVL0c/lKTUULq+jACfYVIO
gJ91N1Ppb0DBxRRpQ/XVwLE=
=SsJa
-----END PGP SIGNATURE-----

--nextPart8796298.DhxF2u27B2--
