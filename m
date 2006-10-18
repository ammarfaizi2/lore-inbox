Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWJRKMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWJRKMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWJRKMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:12:35 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:38374 "EHLO
	mail-in-12.arcor-online.net") by vger.kernel.org with ESMTP
	id S932182AbWJRKMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:12:34 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to off
Date: Wed, 18 Oct 2006 12:12:48 +0200
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, mingo@redhat.com,
       linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, hnguyen@de.ibm.com
References: <200610050938.10997.prakash@punnoor.de> <20061017211301.GE3502@stusta.de> <20061017144053.29b6b29c@freekitty>
In-Reply-To: <20061017144053.29b6b29c@freekitty>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8121510.MIUtiWASzF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610181212.48952.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8121510.MIUtiWASzF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 17 Oktober 2006 23:40 schrieb Stephen Hemminger:
> On Tue, 17 Oct 2006 23:13:01 +0200
>
> Adrian Bunk <bunk@stusta.de> wrote:
> > On Thu, Oct 05, 2006 at 11:08:57PM +0200, Prakash Punnoor wrote:
> > > Am Donnerstag 05 Oktober 2006 19:30 schrieb Fatih A????c??:
> > > > 2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> > > > > Hi,
> > > > >
> > > > > subjects say it all. Without irqpoll my nic doesn't work anymore.=
 I
> > > > > added Ingo
> > > > > to cc, as my IRQs look different, so it may be a prob of APIC
> > > > > routing or the
> > > > > like.
> > > > >
> > > > > Can you try booting with pci=3Dnomsi ? I have a similar problem w=
ith
> > > > > my
> > >
> > > I used snd-hda-intel.disable_msi=3D1 and this actually helped! Now the
> > > nforce nic works w/o problems. So it was the audio driver causing hav=
oc
> > > on the nic. ...
> >
> > Unless someone finds and fixes what causes such problems, I'd therefore
> > suggest the patch below to let MSI support to be turned off by default.

Could it perhaps be that the forcedeth driver isn't MSI aware and this caus=
es=20
breakage?

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart8121510.MIUtiWASzF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNf4gxU2n/+9+t5gRAjsrAKDjX1Akfp5p1tAkUmKnWZitnP6jxgCgjFEG
zZ6jt9hmlGu1qaX0r+iuf0o=
=IRcl
-----END PGP SIGNATURE-----

--nextPart8121510.MIUtiWASzF--
