Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVEJVLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVEJVLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVEJVLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:11:44 -0400
Received: from attila.bofh.it ([213.92.8.2]:49859 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261804AbVEJVIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:08:35 -0400
Date: Tue, 10 May 2005 23:08:23 +0200
To: Greg KH <gregkh@suse.de>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510210823.GB15541@wonderland.linux.it>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it> <20050510205239.GA3634@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20050510205239.GA3634@suse.de>
User-Agent: Mutt/1.5.9i
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 10, Greg KH <gregkh@suse.de> wrote:

> > > > Because it's impossible to predict how it will interact with other
> > > > install and alias commands.
> > > Then we will just have to find out :)
> > It should be clear that it will interact badly with another install
> > commands, with one of them being ignored. This is not acceptable.
> Why?  Will they not all just be checked in order?
No:

$ cat /etc/modprobe.d/test
install test-module /tmp/test-program 1
install test-module /tmp/test-program 2
$ cat /tmp/test-program
#!/bin/sh -e
echo $* > /tmp/test-log
$ modprobe --verbose test-module
install /tmp/test-program 2
$ cat /tmp/test-log=20
2
$

And if both commands were to be run, it would break in a different way
(blacklisting would not work).

> > It's a feature which I know my users and other maintainers need
> > (for duplicated drivers, OSS drivers, watchdog drivers, usb{mouse,kbd}
> > and so on) so it's a prerequisite for the successful packaging of
> > hotplug-ng.
> Ok, then, care to make a patch to module-init-tools to provide this
> functionality?
Eventually yes if nobody else will beat me, but I cannot spend time on
this currently.

--=20
ciao,
Marco

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgSLHFGfw2OHuP7ERAq9kAJ9pxeWntawfjAiv9ke1qFeBiDNo2gCdFDtI
6zhpu3CS3LVceTzJjW930Ps=
=Gd7v
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
