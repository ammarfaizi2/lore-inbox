Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbTDWQ2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTDWQ2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:28:11 -0400
Received: from [195.167.170.152] ([195.167.170.152]:48044 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S264101AbTDWQ2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:28:10 -0400
Date: Wed, 23 Apr 2003 17:40:16 +0100
From: Athanasius <link@miggy.org>
To: Danny ter Haar <dth@uucp.cistron.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, andre@linux-ide.org,
       andre@linuxdiskcert.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030423164015.GJ25981@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	Danny ter Haar <dth@uucp.cistron.nl>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, andre@linux-ide.org,
	andre@linuxdiskcert.org, alan@lxorguk.ukuu.org.uk
References: <cistron.Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <E198M48-0000tC-00@ncc1701.cistron.net> <20030423153603.GI25981@miggy.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
In-Reply-To: <20030423153603.GI25981@miggy.org>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2feizKym29CxAecD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2003 at 04:36:04PM +0100, Athanasius wrote:
> On Wed, Apr 23, 2003 at 05:21:44PM +0200, Danny ter Haar wrote:
> > In article <cistron.20030423150956.GH25981@miggy.org> you write:
> > >  I'm still seeing a problem with my primary IDE channel locking up for
> > >10-15s at a time, an event I can trigger by running updatedb (i.e. the
> > >database update for 'locate').
> > >
> >=20
> > I have similar problems.
> > I "cured" it with dis-abling "IO-APIC"
> >=20
> > Could you recompile a kernel without the io-apic option ?
> >=20
> > local-apic on UP is ok, only disable io-apic.
>=20
>   Aha, a reply about this at last.  I forgot to put my config in on the
> original post, was going to follow up with it when I saw the post come
> up.  Anyway, yes, I have:
>=20
> # CONFIG_SMP is not set
> CONFIG_X86_UP_APIC=3Dy
> CONFIG_X86_UP_IOAPIC=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
>=20
> currently,  I'll go try with all but CONFIG_X86_LOCAL_APIC set to n
> then.

  Yup, that *seems* to have fixed it.  Booted up, updatedb run, compile
of a few things done, running X, even burned a CD, no sign of the
reported problem.

  This could do with some easily accessible documentation someplace, but
I'm not sure *where* such should go.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--2feizKym29CxAecD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj6mwe8ACgkQIr2uvLNOS8OebgCfWxBnXIUQHOrS67VzwDE5+VNO
8UMAn3vCMFjhls8riL7Vhelihnp+a/+1
=5Ahn
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
