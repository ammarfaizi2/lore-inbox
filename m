Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270883AbRHNV5N>; Tue, 14 Aug 2001 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270884AbRHNV4x>; Tue, 14 Aug 2001 17:56:53 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:41524 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S270883AbRHNV4o>; Tue, 14 Aug 2001 17:56:44 -0400
Date: Tue, 14 Aug 2001 23:56:56 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: [PATCH] make psaux reconnect adjustable
Message-ID: <20010814235656.B16332@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Gunther Mayer <Gunther.Mayer@t-online.de>,
	linux-kernel@vger.kernel.org,
	Andries Brouwer <Andries.Brouwer@cwi.nl>
In-Reply-To: <200108141112.LAA99888@vlet.cwi.nl> <3B795B82.195CA42B@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <3B795B82.195CA42B@t-online.de>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2001 at 07:10:26PM +0200, Gunther Mayer wrote:
> Andries.Brouwer@cwi.nl wrote:
> Add an "ioctl(PS2_TRANSPARENT)", to disable the current kernel policy.
> So new drivers which understand about "aa 00" sequences can act properly.
> Don't break existing apps.

Well, coneptually, an ioctl is the same as a sysctl. You allow the user /
sysadmin to toggle the behaviour. Given Linus' love for ioctls, I opted for
the sysctl.

But in principle, Andries is right: There's no reason why userspace can't
handle it, so removing the thing (maybe with a boot param for some time to
allow a smooth transition until all drivers are fixed) is the right thiing
to do.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7eZ6nxmLh6hyYd04RAizVAJ0SOzal+z6dfHYYBwsGrzyd7FqXMQCgsb7D
JBjHJZgDNX/8joDlw244pt8=
=+8oO
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
