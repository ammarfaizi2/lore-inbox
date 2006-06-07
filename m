Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWFGAEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWFGAEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWFGAEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:04:07 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:54190 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751379AbWFGAEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:04:06 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Don Zickus <dzickus@redhat.com>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 10:05:07 +1000
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       shaohua.li@intel.com, miles.lane@gmail.com, jeremy@goop.org,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <200606070134.29292.ak@suse.de> <20060606235551.GE11696@redhat.com>
In-Reply-To: <20060606235551.GE11696@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1351953.GF2kMTQxrU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606071005.14307.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1351953.GF2kMTQxrU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 07 June 2006 09:55, Don Zickus wrote:
> > > So my question is/was what is the proper way to handle processor level
> > > subsystems during the suspend/resume path on an SMP system.  I really
> > > don't understand the hotplug path nor the suspend/resume path very
> > > well.
> >
> > Make it work properly for CPU hotplug for individual CPU and then in
> > suspend you take care of "global" state and the last CPU.
>
> So the assumption is treat all the cpus the same either all on or all off,
> no mixed mode (some cpus on, some cpus off).  I guess I was trying to hard
> to work on the per-cpu level.

This sounds wrong to me. Shouldn't the the effect of hotunplugging a cpu be=
 to=20
put the driver in a state equivalent to if that cpu simply didn't exist?=20
Unplugging shouldn't assume we're going to subsequently have either a drive=
r=20
suspend, or a replug.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1351953.GF2kMTQxrU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBEhhg6N0y+n1M3mo0RAsGbAJihEMizEx5yPvqAF5Xx/348fBi2AJ4kpV+n
Has1GC20VsaLvMXxZs5Lyw==
=eV0X
-----END PGP SIGNATURE-----

--nextPart1351953.GF2kMTQxrU--
