Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWCCPuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWCCPuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWCCPuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:50:19 -0500
Received: from 213-205-70-152.net.novis.pt ([213.205.70.152]:37544 "EHLO
	gilgamesh.eufrates.artenumerica.net") by vger.kernel.org with ESMTP
	id S1751240AbWCCPuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:50:18 -0500
Message-ID: <440865A9.4000102@artenumerica.com>
Date: Fri, 03 Mar 2006 15:50:01 +0000
From: J M Cerqueira Esteves <jmce@artenumerica.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: support@artenumerica.com, Nuno Galamba <ngalamba@fc.ul.pt>
Subject: Re: oom-killer: gfp_mask=0xd1  with 2.6.12 on EM64T
References: <4405D383.5070201@artenumerica.com> <20060302011735.55851ca2.akpm@osdl.org>
In-Reply-To: <20060302011735.55851ca2.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1FD2D2267DC6C53D7C9F479E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1FD2D2267DC6C53D7C9F479E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> That's quite an old kernel.  If this is the notorious bio-uses-GFP_DMA bug
> then I'd have expected this kernel to be useless from day one.  Did you
> install it recently?

On this double Xeon, yes.  I had no problems before with 2.6.12 and the
same "heavy" software on dual Opteron and dual dual core Opteron
machines, and this is my first installation on a EM64T.
At first it seemed everything was ok with 2.6.12 here too, but in a
couple of days we started gettings some of those oom killings when
running some Gaussian jobs. In at least a pair of cases the system froze
completely.

> If you're feeling keen you could add this patch which would confirm it:

Added it and already got output for a similar "killing". Since I'm not
sure what could be most relevant among those messages, I refrained from
attaching them all here, and instead put them at
http://jmce.artenumerica.org/tmp/linux-2.6.12-oom_killings/EM64T-kern.log

> And if it's that bug then I'm afraid you'll have to sit tight until 2.6.16.
> We shouldn't release 2.6.16 until this thing is fixed.

Do those call traces suggest that uncorrected bug you mention?
(And if yes, is there any known way to mitigate the problem? Could it
depend on BIOS settings?)
I'll also be able to try a 2.6.15 kernel (eventually with any suggested
patches) later today...

Thanks again and best regards

                    J Esteves
-- 
+351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce

--------------enig1FD2D2267DC6C53D7C9F479E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFECGWwesWiVDEbnjYRAupbAJoCDfdQtdGzIduKczs3AI+MCXOT9wCgg4/g
HF3Cwf57u7EWqP8XqIPmU2M=
=BxLU
-----END PGP SIGNATURE-----

--------------enig1FD2D2267DC6C53D7C9F479E--
