Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271320AbRHORTR>; Wed, 15 Aug 2001 13:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271318AbRHORTJ>; Wed, 15 Aug 2001 13:19:09 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:13629 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S271309AbRHORTC>; Wed, 15 Aug 2001 13:19:02 -0400
Date: Wed, 15 Aug 2001 19:19:12 +0200
From: Kurt Garloff <garloff@suse.de>
To: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
Cc: Kurt Garloff <garloff@suse.de>, linux-lvm@sistina.com,
        lvm-devel@sistina.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sistina@sistina.com, mge@sistina.com
Subject: Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
Message-ID: <20010815191912.V3941@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
	linux-lvm@sistina.com, lvm-devel@sistina.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	sistina@sistina.com, mge@sistina.com
In-Reply-To: <20010815175659.A29749@sistina.com> <20010815182548.U3941@gum01m.etpnet.phys.tue.nl> <20010815185005.A32239@sistina.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X6f5cqjOqKjuoPgI"
Content-Disposition: inline
In-Reply-To: <20010815185005.A32239@sistina.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X6f5cqjOqKjuoPgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heinz,

thanks for your reply!

On Wed, Aug 15, 2001 at 06:50:05PM +0200, Heinz J . Mauelshagen wrote:
> On Wed, Aug 15, 2001 at 06:25:48PM +0200, Kurt Garloff wrote:
> > Is there finally a decent way to upgrade from 0.9.1b7?
> > Or is it still required to have multiple versions of the utils installed
> > just in order to be able to update from 0.9.1b7 to b8 (or 1.0)?
>=20
> Well, as explained before on the lists we had an algorithm calculating
> the offset to the first PE in place till 0.9.1 Beta 7.
>=20
> Therefore, we *need* to run the installed version < LVM 0.9.1 Beta 8 to
> retrieve that sector offset for all PVs and change the metadata to hold t=
he
> offset. No known way around this.

What about adding migration code to newer LVM tools?
Make them able to get the offset to the first PE and write them to the new
place in the PV on vgscan, so the upgrade procedure is painless, because
it works automatically and tranparently. The only thing a user has to watch
is to keep kernel and userspace LVM in sync then.

I can't imagine this to be too difficult, honestly. The code is there.
You wanted to get rid of it, apparently, but why can't that be postponed?

Installing different versions of lvm tools in parallel in order to do
the upgrade inside some ramdisk of your installation system with 100%=20
success sounds much more painful to me.
Left alone those people who follow a different upgrade path than the
standard one envisioned by us.

> > If yes, then I'd vote for not updating the kernel until this is fixed!
>=20
> Well, we need to migrate the metadata in the future anyway once we want
> to offer support for enhanced metadata reliability and redundancy.
> We'll provide bidirectional migration tools for that then which will enab=
le
> the user to swicth back and forth between 2 installed LVM versions.

Now, that sounds better.

> Let's keep the ball flat WRT to the migration path here.
> We've got mails with positive LVM 0.9.1 Beta 8 upgrade reports and
> no complaints TTBOMK.

Because most people just refused to upgrade given the difficulties.
Nobody wants to put his data at risk.
As it stands, I guess, SuSE will also need to refuse :-(

This is a pain, because decoupling would be bad for both sides:=20
People (our customers) can't profit from your improvements and bugfixes any
longer and you'll get bug reports for old versions instead of testing of
your recent version.=20

To be honest, I'd personally be disappointed if this happens:
SuSE has supported the usage of LVM and offers support for it in the
installation tool; I seriously suspect that the majority of LVM-users
is using SuSE Linux.=20
Now, leaving them alone WRT upgrade is not very nice.=20
You'll get decoupled from your user base.

Let's try to avoid that, please!

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--X6f5cqjOqKjuoPgI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7eq8QxmLh6hyYd04RAtO6AJ9sNIw/8vDrYb3+8IPKCzDIOkprmQCeJaG0
lEd+fW+vLl+GaQa02XfrNj4=
=fcdU
-----END PGP SIGNATURE-----

--X6f5cqjOqKjuoPgI--
