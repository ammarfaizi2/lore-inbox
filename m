Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271856AbRHUUcP>; Tue, 21 Aug 2001 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271860AbRHUUcF>; Tue, 21 Aug 2001 16:32:05 -0400
Received: from [209.10.41.242] ([209.10.41.242]:50822 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S271856AbRHUUb4>;
	Tue, 21 Aug 2001 16:31:56 -0400
Date: Tue, 21 Aug 2001 22:29:45 +0200
From: Kurt Garloff <garloff@suse.de>
To: Stephen Satchell <satch@fluent-access.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
Message-ID: <20010821222945.J25547@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Stephen Satchell <satch@fluent-access.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20010821084512.00bdf800@mail.fluent-access.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20010821084512.00bdf800@mail.fluent-access.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2001 at 11:07:54AM -0700, Stephen Satchell wrote:
> This MAY be a kernel issue depending on where I locate the mouse=20
> initialization code.  If it is in the kernel, then there will need to be =
a=20
> patch to allow the mouse to be re-initialized into the mode everyone=20
> expects.

The kernel (2.2.15--2.2.17, 2.4.x--2.4.8) had code to reinitialize a plain
PS2 mouse upon a reconnect event.=20
It caused too many problems on mouses that are not plain PS/2, but eg.
synps2 (Synaptics touchpad). Those are not happy being reinitialized ...

The code has been disabled in 2.2.18/2.4.9 therefore. Use psaux-reconnect
boot param to get the code back.

But normally your mouse driver (gpm or X11) has to do the reinitialization
anyways, because it knows about the specific reinitialization sequence a
mouse needs.=20
The kernel can't handle it, unless you put the whole collection of drivers
there.=20

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7gsS4xmLh6hyYd04RAmlpAKC1S5lAbKgpJgPcnxux2j5kwvITXQCgnzJx
M+RIGt6nEHh2lgKmjwAN95o=
=JH5+
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--
