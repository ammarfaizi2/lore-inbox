Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271586AbRH1PyL>; Tue, 28 Aug 2001 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271613AbRH1PyB>; Tue, 28 Aug 2001 11:54:01 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:58025 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271586AbRH1Pxu>; Tue, 28 Aug 2001 11:53:50 -0400
Date: Tue, 28 Aug 2001 10:53:30 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB UHCI broken again w/ visor
Message-ID: <20010828105330.S16752@draal.physics.wisc.edu>
In-Reply-To: <20010828013239.N16752@draal.physics.wisc.edu> <20010828083537.B7376@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mIJwGTFTwAlEXlA"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010828083537.B7376@kroah.com>; from greg@kroah.com on Tue, Aug 28, 2001 at 08:35:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7mIJwGTFTwAlEXlA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg KH [greg@kroah.com] wrote:
> On Tue, Aug 28, 2001 at 01:32:40AM -0500, Bob McElrath wrote:
> > USB verbose debug is ON, using driver usb-uhci, on an alpha, kernel
> > 2.4.9, new batteries in the thing.  This worked with 2.4.7.  What
> > happened?  It seems like every other kernel version it gets broken
> > again, and I can't sync my visor.
>=20
> It looks like your uhci controller is not getting interrupts anymore.
> Does the value of /proc/interrupts for the usb-uhci driver get
> incremented?

No, it seems stuck at a non-zero value.

(0)<mcelrath@draal:/home/mcelrath/minijam> cat /proc/interrupts
  1:     224376          XT-PIC   keyboard
  2:          0          XT-PIC   cascade
  8:  250012322             RTC  +timer
 11:    3019583          XT-PIC   PAS16
 12:    1891610          XT-PIC   PS/2 Mouse
 14:      60292          XT-PIC  +ide0
 16:     650152       CABRIOLET   BusLogic BT-958
 18:      23085       CABRIOLET   usb-uhci
 19:     304381       CABRIOLET   eth0
 20:          0       CABRIOLET   isa-cascade
ERR:          0

The non-zero value is probably because I was using another device.

> Does any other usb devices work on this system?

Yes, I have a SanDisk ImageMage (SDDR-12) that sorta-works with the
usb-storage driver.

The device times out though after transferring a few files.  I don't
know if the problem is with the usb-storage driver, usb-uhci, or the
device itself.  But this problem has existed for a long time, and OHCI
users don't report this problem.  (using usb-storage with this device
and my little program to transfer files to it:
http://www.sourceforge.net/projects/mj-tools/)  I haven't been able to
track this bug down yet...

The behaviour of the usb-storage stuff is unchanged from 2.4.7, but the
visor definitely did work with 2.4.7, where it doesn't now.

Thanks,
-- Bob

P.S. please CC me as I am not on linux-kernel.

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--7mIJwGTFTwAlEXlA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuLvnoACgkQjwioWRGe9K3WJACfTST7viD8hFOQlvd448nTxbtV
ukgAoMu/3+ErZBzoDukcmILdebdEZcP4
=OF2H
-----END PGP SIGNATURE-----

--7mIJwGTFTwAlEXlA--
