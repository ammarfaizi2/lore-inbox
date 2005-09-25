Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVIYK43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVIYK43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 06:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVIYK43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 06:56:29 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:20184 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S1751256AbVIYK43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 06:56:29 -0400
Date: Sun, 25 Sep 2005 11:56:18 +0100
From: Chris Sykes <chris@sigsegv.plus.com>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-ID: <20050925105618.GA5625@sigsegv.plus.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
References: <20050922163708.GF5898@sigsegv.plus.com> <20050923015719.5eb765a4.akpm@osdl.org> <20050923121932.GA5395@sigsegv.plus.com> <20050923132216.GA5784@sigsegv.plus.com> <20050923121811.2ef1f0be.akpm@osdl.org> <20050924121431.GA5530@sigsegv.plus.com> <20050924142825.GA5158@sigsegv.plus.com> <20050924103946.540d708d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20050924103946.540d708d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 24, 2005 at 10:39:46AM -0700, Andrew Morton wrote:
> >  I'll build a kernel with CONFIG_EXT2_FS_XATTR disabled and see if that
> >  also makes the issue go away.
>=20
> Yup.  I thought I already tested wth your .config?

Hmm.  You said that everything looked OK at your end.  I've dug out a
P4 Xeon & booted an affected kernel on it.  I get the stuck 'rm'
processes there as well.  So it doesn't appear to be IDE chipset
dependant (ICH5 vs ServerWorks).

If nobody else is seeing this then I guess it could be a local
toolchain issue?.  I'm running (and compiling on) Ubuntu Hoary.

Linux cooper 2.6.14-rc2-g6cb2defe #4 SMP PREEMPT Sun Sep 25 10:21:14
BST 2005 i686 GNU/Linux
=20
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.19
reiser4progs           1.0.3
xfsprogs               2.6.20
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   050
Modules Loaded         binfmt_misc cpufreq_userspace cpufreq_stats
freq_table cpufreq_powersave cpufreq_ondemand cpufreq_conservative
video thermal processor fan container button battery ac ipv6 sk98lin
skge snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801
generic hw_random intel_agp agpgart 8250_pnp 8250 serial_core floppy
pcspkr rtc psmouse parport_pc lp parport ide_generic ide_cd cdrom
mousedev tsdev

Anything else I should try?  CONFIG_PREEMPT?  CONFIG_SMP?

--=20

(o-  Chris Sykes
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt
GPG Fingerprint: 5E8E D17F F96C CC08 911D  CAF2 9049 70D8 5143 8090

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDNoJSkElw2FFDgJARAlydAJ9/guz0xcQBUxt9Jh+7o3Rw+wm1vwCg4x4g
bkn+IiykhYqT/UYEBA2vN8o=
=G+CG
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
