Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbRDJQs1>; Tue, 10 Apr 2001 12:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132846AbRDJQsS>; Tue, 10 Apr 2001 12:48:18 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:59376 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132465AbRDJQsK>; Tue, 10 Apr 2001 12:48:10 -0400
Date: Tue, 10 Apr 2001 17:48:03 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Juan <piernas@ditec.um.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 && ppa: total lockup. No problem with 2.2.17
Message-ID: <20010410174803.X1136@redhat.com>
In-Reply-To: <20010330152921.Q10553@redhat.com> <Pine.LNX.4.21.0103310156530.23634-100000@ditec.um.es> <20010403173839.I9355@redhat.com> <3ACA55D5.FC2E444C@ditec.um.es> <20010404092610.P9355@redhat.com> <3ACCDB0C.3A3ED66C@ditec.um.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="YI37jEh306anPMfG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACCDB0C.3A3ED66C@ditec.um.es>; from piernas@ditec.um.es on Thu, Apr 05, 2001 at 10:52:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YI37jEh306anPMfG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2001 at 10:52:28PM +0200, Juan wrote:

> Tim Waugh escribi=F3:
> >=20
> > Could you build a kernel without SMP support and see if the problem
> > still happens?
> Without SMP support, the machine doesn't hang but I can't load the ppa
> module.
> See messages below.
[...]
> [root@localhost /root]# modprobe ppa
> ppa: Version 2.07 (for Linux 2.2.x)
> WARNING - no ppa compatible devices found.
>   As of 31/Aug/1998 Iomega started shipping parallel
>   port ZIP drives with a different interface which is
>   supported by the imm (ZIP Plus) driver. If the
>   cable is marked with "AutoDetect", this is what has
>   happened.
> scsi : 0 hosts.
> /lib/modules/2.2.19/scsi/ppa.o: init_module: Device or resource busy

That's really strange.  Does anyone else see this problem with ppa in
2.2.19?  The only change should be to the _error_ path; it shouldn't
make things that once worked not work.

> > You could remove this line, just to see if it makes a difference (it
> > shouldn't, but it might).
> I will try this tomorrow.

I take it that it had no effect?

> > > messages on screen, doesn't it?
> >=20
> > Better is something like 'dmesg -n 8'.
> OK.

How about this?  Did you see messages on the screen on the SMP kernel
with 'dmesg -n 8' set when you load ppa?

Tim.
*/

--YI37jEh306anPMfG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE60zlCONXnILZ4yVIRAiA7AKCadAqD7zPPl578mpdzIWJvEP3SPQCdFmEY
D0szJigAIZgT3YR3z0Iew50=
=2YI/
-----END PGP SIGNATURE-----

--YI37jEh306anPMfG--
