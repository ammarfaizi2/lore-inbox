Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUDERkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUDERkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:40:16 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:14801 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262339AbUDERkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:40:11 -0400
Date: Mon, 5 Apr 2004 19:38:35 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk, cpufreq@www.linux.org.uk
Subject: Re: [PATCH 2.6] cpufreq longrun driver fix
Message-ID: <20040405173835.GA7328@dominikbrodowski.de>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@codemonkey.org.uk, cpufreq@www.linux.org.uk
References: <20040405155012.GI2718@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20040405155012.GI2718@deep-space-9.dsnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 05, 2004 at 05:50:12PM +0200, Stelian Pop wrote:
> Hi,
>=20
> My TM5600 Crusoe processor, found inside a Sony Vaio C1VE laptop,
> does not work with the longrun cpufreq driver.
>=20
> Upon investigation, the reason is that trying to set the performance=20
> to 80% in longrun_determine_freqs leaves the performance to 100%.
> The performance level, at least on this particular model, can be lowered
> only in 33% steps. And in order to put the performance to 66%, the
> code should try to set the barrier to 70%.
>=20
> The following patch does even more, it tries every value from 80%
> to 10% in 10% steps, until it succeeds in lowering the performance.
> I'm not sure this is the best way to do it but in any case,=20
> it works for me (and should continue to work for everybody else).

Patch looks good to me -- thanks, Stelian!=20
Dave, could you merge it, please?

Thanks,
	Dominik
=20
--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcZmbZ8MDCHJbN8YRAizlAJ9TiNHW/uSPvoifCulsOaeh17lJrQCgiBPj
E3dQpPIvNLHTI7Kv9L6qs9M=
=DrFa
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
