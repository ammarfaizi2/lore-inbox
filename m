Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264869AbUFHGcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbUFHGcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUFHGcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:32:39 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:3404 "EHLO
	mwinf0901.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264893AbUFHGcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:32:24 -0400
Date: Tue, 8 Jun 2004 08:32:23 +0200
From: Michelle Konzack <linux4michelle@freenet.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: how to configure/build a kernel in a separate directory?
Message-ID: <20040608063223.GB10986@freenet.de>
References: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings MIchelle.
X-Disclaimer-1: Eine weitere Verwendung oder die Veroeffentlichung
X-Disclaimer-2: dieser Mail oder dieser Mailadresse ist nur mit der
X-Disclaimer-3: Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux michelle1 2.4.26-1-686
X-Uptime: 08:08:48 up 12 days, 22:02,  4 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 2004-06-07 17:00:26, schrieb Robert P. J. Day:

>  is there an easy way to configure/build one or both of a 2.4 and 2.6=20
>kernel in a totally separate directory from the source directory itself?

YES=20

>  i'd like to have a totally pristine ("make mrproper"ed) source tree,
>write-protected, readable by all, so that several developers can=20
>independently configure and build their own kernels without stepping on=20
>each other.  currently, they all check out their own copy of the source=20
>via CVS, which starts to take up a lot of space.

Right

>  obviously, it would be great if they could all set up some kind of build=
=20
>structure where they could do their own configuration and build in their=
=20
>personal work directories, so that *all* generated results (header files,
>object files, etc.) are placed in their work directory -- nothing should
>be generated in the kernel source tree itself.
>
>  i'm suspecting that, if there are solutions, they will be different from=
=20
>2.4 to 2.6, so i'll take whatever solutions i can get.  others have=20
>suggested using gnu make in combination with "VPATH", but i'm not sure=20
>that's going to work, as VPATH deals strictly with pre-requisites in other=
=20
>directories, not executable programs like scripts.

/usr/X11R6/bin/lndir

If you use Debian GNU/Linux, the file is in the Package: xutils

  ____ (stdin) _________________________________________________________
 /
|  LNDIR(1)                                                 LNDIR(1)
| =20
| =20
| =20
|  N=08NA=08AM=08ME=08E
|         lndir  -  create  a  shadow directory of symbolic links to
|         another directory tree
| =20
|  S=08SY=08YN=08NO=08OP=08PS=08SI=08IS=08S
|         l=08ln=08nd=08di=08ir=08r [ -=08-s=08si=08il=08le=08en=08nt=08t ]=
 [ -=08-i=08ig=08gn=08no=08or=08re=08el=08li=08in=08nk=08ks=08s ] _=08f_=08=
r_=08o_=08m_=08d_=08i_=08r [ _=08t_=08o_=08d_=08i_=08r ]
| =20
|  D=08DE=08ES=08SC=08CR=08RI=08IP=08PT=08TI=08IO=08ON=08N
|         The _=08l_=08n_=08d_=08i_=08r program makes a shadow copy _=08t_=
=08o_=08d_=08i_=08r of a directory
|         tree _=08f_=08r_=08o_=08m_=08d_=08i_=08r_=08, except that the sha=
dow is not populated with
|         real files but instead with symbolic links pointing at the
|         real files in the _=08f_=08r_=08o_=08m_=08d_=08i_=08r directory t=
ree.  This is usually
|         useful for maintaining source code for  different  machine
|         architectures.   You  create a shadow directory containing
|         links to the real source,  which  you  will  have  usually
|         mounted  from  a  remote  machine.   You  can build in the
|         shadow tree, and the object files will be  in  the  shadow
|         directory,  while the source files in the shadow directory
|         are just symlinks to the real files.
| =20
|         This scheme has the  advantage  that  if  you  update  the
|         source,  you  need  not  propagate the change to the other
|         architectures by hand, since  all  source  in  all  shadow
|         directories are symlinks to the real thing: just cd to the
|         shadow directory and recompile away.
| =20
|         The _=08t_=08o_=08d_=08i_=08r argument is optional and defaults t=
o the current
|         directory.   The  _=08f_=08r_=08o_=08m_=08d_=08i_=08r  argument m=
ay be relative (e.g.,
|         ../src) and is relative to _=08t_=08o_=08d_=08i_=08r (not the  cu=
rrent  direc=AD
|         tory).
| =20
|         Note  that  RCS, SCCS, CVS and CVS.adm directories are not
|         shadowed.
| =20
|         If you add files, simply run _=08l_=08n_=08d_=08i_=08r again.  Ne=
w files  will
|         be  silently  added.   Old files will be checked that they
|         have the correct link.
| =20
|         Deleting files is a more  painful  problem;  the  symlinks
|         will just point into never never land.
| =20
|         If  a  file in _=08f_=08r_=08o_=08m_=08d_=08i_=08r is a symbolic =
link, _=08l_=08n_=08d_=08i_=08r will make
|         the same link in _=08t_=08o_=08d_=08i_=08r rather than making a l=
ink  back  to
|         the  (symbolic  link)  entry in _=08f_=08r_=08o_=08m_=08d_=08i_=
=08r_=08.  The -=08-i=08ig=08gn=08no=08or=08re=08el=08li=08in=08nk=08ks=08s
|         flag changes this behavior.
| =20

<snip>

|  X Version 11               Release 6.5                   LNDIR(1)
 \______________________________________________________________________


>rday

Greetings
Michelle

--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/=20
Michelle Konzack   Apt. 917                  ICQ #328449886
                   50, rue de Soultz         MSM LinuxMichi
0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxV13C0FPBMSS+BIRAmnIAJ9YySAU1l7AO1Zkw1DMfe5ICzD4qQCgk3WJ
Ee5IskREsCh3VsZtRx2GnF4=
=eUFN
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
