Return-Path: <linux-kernel-owner+w=401wt.eu-S1751778AbXAOCCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXAOCCX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 21:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXAOCCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 21:02:23 -0500
Received: from iucha.net ([209.98.146.184]:44790 "EHLO mail.iucha.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbXAOCCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 21:02:22 -0500
Date: Sun, 14 Jan 2007 20:02:21 -0600
To: Jiri Kosina <jikos@jikos.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       Alan Stern <stern@rowland.harvard.edu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: heavy nfs[4]] causes fs badness Was: 2.6.20-rc4: known unfixed regressions (v2)
Message-ID: <20070115020221.GC6053@iucha.net>
References: <20070109214431.GH24369@iucha.net> <Pine.LNX.4.44L0.0701101052310.3289-100000@iolanthe.rowland.org> <20070114225701.GA6053@iucha.net> <20070114235816.GB6053@iucha.net> <Pine.LNX.4.64.0701150109190.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701150109190.16747@twin.jikos.cz>
X-GPG-Key: http://iucha.net/florin_iucha.gpg
X-GPG-Fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.13 (2006-08-11)
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jiri and Trond,

On Mon, Jan 15, 2007 at 01:14:09AM +0100, Jiri Kosina wrote:
> On Sun, 14 Jan 2007, Florin Iucha wrote:
>=20
> > All the testing was done via a ssh into the workstation.  The console=
=20
> > was left as booted into, with the gdm running.  The remote nfs4=20
> > directory was mounted on "/mnt". After copying the 60+ GB and testing=
=20
> > that the keyboard was still functioning, I did not reboot but stayed in=
=20
> > the same kernel and pulled the latest git then started bisecting. =20
>=20
> Hi Florin,
>=20
> thanks a lot for the testing. Just to verify - what kernel is 'the same=
=20
> kernel' mentioned above? (just to isolate whether the problem is really=
=20
> somewhere between 2.6.19 and 2.6.20-rc2, as you stated in previous posts,=
=20
> or the situation has changed).

This happened with 2.6.19.  It worked last time, but I wanted to test
again, to make sure.  This time, it bombed, but half an hour after the=20
transfer finished.

> > After recompiling, I moved over to the workstation to reboot it, but th=
e=20
> > keyboard was not functioning ;(
>=20
> So this time the hang occured when the system was idle, not during the=20
> transfers, right?

Yes it was idle.  Immediately after the transfer finished, the keyboard was
still functioning.  It "hang" minutes later, after the first bisected kernel
was compiled and installed.

> > I ran "lsusb" and it displayed all the devices. "dmesg" did not show
> > any oops, anything for that matter.  I have unplugged the keyboard and
> > run "lsusb" again, but it hang.  I ran "ls /mnt" and it hang as well.
> > Stracing "lsusb" showed it hang (entered the kernel) at opening the dev=
ice
> > that used to be the keyboard.  Stracing "ls /mnt" showed that it
> > hang at "stat(/mnt)".  Both processes were in "D" state.  "ls /root"
> > worked without problem, so it appears that crossing mountpoints causes
> > some hang in the kernel.
>=20
> Could you please do alt-sysrq-t (or "echo t > /proc/sysrq-trigger" via=20
> ssh, when your keyboard is dead) to see the calltraces of the processes=
=20
> which are stuck inside kernel?
>=20
> You will probably get a lot of output after the sysrq, so please either=
=20
> put it somewhere on the web if possible, or just extract the interesting=
=20
> processes out of it (mainly the ones which are stuck).

Will do.

florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFquCtND0rFCN2b1sRApWgAJkB4zfUgar+51iBoAEgWRaAv2hX4wCdEGCb
d2OsmV7GxSBTjF1WvksFfpk=
=fO6R
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
