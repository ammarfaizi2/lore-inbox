Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317204AbSFRAs0>; Mon, 17 Jun 2002 20:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317205AbSFRAsZ>; Mon, 17 Jun 2002 20:48:25 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:41750 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317204AbSFRAsY>; Mon, 17 Jun 2002 20:48:24 -0400
Date: Tue, 18 Jun 2002 02:48:23 +0200
From: Kurt Garloff <garloff@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, marcelo@conectiva.com.br,
       lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [Patch] tsc-disable_A5
Message-ID: <20020618004823.GB3448@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Benjamin LaHaise <bcrl@redhat.com>,
	john stultz <johnstul@us.ibm.com>, marcelo@conectiva.com.br,
	lkml <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>
References: <1024079726.29929.131.camel@cog> <20020614145307.G22888@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20020614145307.G22888@redhat.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Fri, Jun 14, 2002 at 02:53:07PM -0400, Benjamin LaHaise wrote:
> On Fri, Jun 14, 2002 at 11:35:26AM -0700, john stultz wrote:
> > This results in sequential calls to gettimeofday to return
> > non-sequential time values. By disabling the TSCs on these boxes, it
> > forces gettimeofday to use the PIC clock instead, fixing the problem.=
=20
>=20
> This seems to be yet another reason for supporting per-CPU TSC=20
> calibration, as that would fix machines with different speed cpus, too.

I agree.
Maybe the patch I once made to support CPUs with different speeds can serve
as a starting point?

http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0481.html

However, one would need to make sure that all CPUs occasionally do receive
timer interrupts, otherwise your TSC may overflow. Depending on your
hardware (APICs), this might be an issue. I've been told that Fosters do
misbehave ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9DoNXxmLh6hyYd04RAldmAKDJ3JVT6S/XiF4jYtVAbWL4ixa51wCcCk/C
NhQJ7VP9iNKF3PyAvfO4XmA=
=+rcv
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
