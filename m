Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSCRLbJ>; Mon, 18 Mar 2002 06:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSCRLbB>; Mon, 18 Mar 2002 06:31:01 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:36142 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S292982AbSCRLan>; Mon, 18 Mar 2002 06:30:43 -0500
Date: Mon, 18 Mar 2002 12:30:39 +0100
From: Kurt Garloff <garloff@suse.de>
To: Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org, Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: SCSI-Problem with AM53C974
Message-ID: <20020318123038.B19273@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>,
	linux-kernel@vger.kernel.org,
	Linux SCSI list <linux-scsi@vger.kernel.org>
In-Reply-To: <200203171439.g2HEdwX00738@orion.steiner.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marion,

On Sun, Mar 17, 2002 at 03:39:58PM +0100, Marion Steiner wrote:
> There is a problem with the AM53C974 Scsi-driver (Revision 0.5,=20
> kernel 2.4.x) and the DawiControl DC-2974.
>=20
> The driver finds an AM53C97 based Scsi-Board but it can't initialise it a=
nd
> so hangs the computer. Here what's written in /var/log/messages while try=
ing
> to modprobe AM53C97:

Can you try the attached patch please? Patch is against 2.4.18.

It makes the AM53C974 driver register its IO-space and will make detection
fail, if there are no adapters found with available IO-space.

The tmscsim driver (which I maintain) does already register its IO space
correctly, so this patch should make sure that not both of them try to drive
the same piece of hardware.

Please report back, whether it works, so I can ask Marcelo to include it.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8lc/exmLh6hyYd04RAoWCAJ9dxFYK371RFqf5LU00e5l73MBrvQCfZkXz
YYc+bsSwX2FX25PuVLktKfI=
=Weld
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
