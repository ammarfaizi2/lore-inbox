Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131260AbRCUKFx>; Wed, 21 Mar 2001 05:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131262AbRCUKFo>; Wed, 21 Mar 2001 05:05:44 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:32707 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131260AbRCUKFh>; Wed, 21 Mar 2001 05:05:37 -0500
Date: Wed, 21 Mar 2001 10:04:23 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org,
        Will Newton <will@misconception.org.uk>
Subject: Re: VIA audio and parport in 2.4.2
Message-ID: <20010321100423.P12081@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0103171951340.440-100000@mikeg.weiden.de> <Pine.LNX.4.33.0103190015080.8534-100000@dogfox.localdomain> <20010318192221.A27150@redhat.com> <3AB82C36.C807B787@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UJhykcm+BCcdfd3/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB82C36.C807B787@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Mar 20, 2001 at 11:21:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UJhykcm+BCcdfd3/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2001 at 11:21:10PM -0500, Jeff Garzik wrote:

> The current Via-specific parport_pc.c code forces on the best possible
> parallel port modes the chip can handle.  In retrospect, what it should
> be doing is reading the configuration BIOS has set up, and not touching
> it.

Yes, I think you are right.

> I am not sure that I agree, however, that an "irq=none" on the kernel
> cmd line should affect the operation of the Via code.  I would much
> rather fix the Via code as I suggest above.

irq=none should definitely be honoured, or else the user has to reboot
in order to debug problems with printing.  The user's io=, irq= and
dma= settings should always be honoured. IMHO.

When irq=auto, the BIOS settings should be used.

Case in point: until very recently there was a bad problem in the
irq-driven printing path.  But only people with Via chipsets were
reporting it, and it didn't go away with 'irq=none' (which parport.txt
says to do in order to trouble-shoot).  It makes Via chipsets the
exception, and it's confusing IMHO (it confused me, anyhow).

Tim.
*/

--UJhykcm+BCcdfd3/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6uHymONXnILZ4yVIRApohAJ4ka7ZnTSjHMZkaG6Hs+rHCtMviSQCdE1NP
WWfbgAXhem32s9SaGMQfIjk=
=ojRc
-----END PGP SIGNATURE-----

--UJhykcm+BCcdfd3/--
