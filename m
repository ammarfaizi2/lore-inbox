Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVFQKgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVFQKgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 06:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVFQKgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 06:36:07 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:61108 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261937AbVFQKgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 06:36:00 -0400
Date: Fri, 17 Jun 2005 20:35:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6 missing commit(s) in cpufreq?
Message-Id: <20050617203549.4ecf5670.sfr@canb.auug.org.au>
In-Reply-To: <20050617122155.0d8190c2.lista1@telia.com>
References: <20050617122155.0d8190c2.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__17_Jun_2005_20_35_49_+1000_wTWDh2mXoSn7JLQY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__17_Jun_2005_20_35_49_+1000_wTWDh2mXoSn7JLQY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jun 2005 12:21:55 +0200 Voluspa <lista1@telia.com> wrote:
>
> commit 1206aaac285904e3e3995eecbf4129b6555a8973
> Author: Dave Jones <davej@redhat.com>
> Date:   Tue May 31 19:03:48 2005 -0700
>=20
>     [CPUFREQ] Allow ondemand stepping to be changed by user.
>=20
> And when I look at:
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/davej/cpufreq.git;a=3Dcom=
mit;h=3D1206aaac285904e3e3995eecbf4129b6555a8973
>=20
> There are changes in the diff like:
>=20
> --- drivers/cpufreq/cpufreq_ondemand.c
> +++ drivers/cpufreq/cpufreq_ondemand.c
> @@ -79,6 +79,7 @@ struct dbs_tuners {
> unsigned int up_threshold;
> unsigned int down_threshold;
> unsigned int ignore_nice;
> + unsigned int freq_step;
> };
>=20
> Problem is that neither a clean 2.6.11 patched with patch-2.6.12-rc6 nor
> a full linux-2.6.12-rc6.tar.bz (I just downloaded it) contain that
> commit.
>=20
> The first example from above looks like:
>=20
> struct dbs_tuners {
>         unsigned int            sampling_rate;
>         unsigned int            sampling_down_factor;
>         unsigned int            up_threshold;
>         unsigned int            ignore_nice;
> };

Commit c29f1403098135bdef75b190a5037db514701031 removes that element of
struct dbs_tuners again.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__17_Jun_2005_20_35_49_+1000_wTWDh2mXoSn7JLQY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCsqeL4CJfqux9a+8RAqPXAKCW9Bfr2VZ1mBlA3BkkST4TidaGWwCgigWH
0eX2UypZEiwlGai8A5+HGbc=
=aYaC
-----END PGP SIGNATURE-----

--Signature=_Fri__17_Jun_2005_20_35_49_+1000_wTWDh2mXoSn7JLQY--
