Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbRFZJXd>; Tue, 26 Jun 2001 05:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265965AbRFZJXX>; Tue, 26 Jun 2001 05:23:23 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:59470 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264908AbRFZJXF>; Tue, 26 Jun 2001 05:23:05 -0400
Date: Tue, 26 Jun 2001 10:23:03 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically
Message-ID: <20010626102303.K7663@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0106260308100.1730-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xIk0xHvQc0Ku+QuL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106260308100.1730-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Jun 26, 2001 at 03:17:32AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xIk0xHvQc0Ku+QuL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 26, 2001 at 03:17:32AM -0300, Marcelo Tosatti wrote:

> If the initialization of parport_serial fails, we obviously get an
> error message, which is really annoying:

[This is different to the issue that is fixed in the -ac tree about
parport_serial getting probed for even when disabled in config.]

The idea was that people who have multi-IO cards but don't know what
modules are can have things Just Work: parport_serial gets loaded
automagically and detects their cards for them.  But yes, the flip
side is that people who _don't_ have multi-IO cards are going to get
that error.

There are three ways out, I think:

- change parport_pc so that it doesn't request parport_serial at
  init.  In this case, how will parport_serial get loaded at all?
  Perhaps with some recommended /etc/modules.conf lines (perhaps
  parport_lowlevel{1,2,3,...})?

- people who get the error and don't like it can put 'alias
  parport_serial off' in /etc/modules.conf.  Not especially pleasant,
  I guess.

- parport_serial could be made to initialise successfully even if it
  doesn't see any devices that it can drive.

What do people think?

Tim.
*/

--xIk0xHvQc0Ku+QuL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7OFR2ONXnILZ4yVIRAmRtAJ9RD5pzKu7FMTaZpkX5VtQ7RPq/UQCglJIB
PSdsNEfO3is4zScMiTe/+rY=
=HoCf
-----END PGP SIGNATURE-----

--xIk0xHvQc0Ku+QuL--
