Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752375AbWCFKpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbWCFKpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 05:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbWCFKpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 05:45:52 -0500
Received: from merlin.artenumerica.net ([80.68.90.14]:35850 "EHLO
	merlin.artenumerica.net") by vger.kernel.org with ESMTP
	id S1752374AbWCFKpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 05:45:52 -0500
Message-ID: <440C12DA.6010302@artenumerica.com>
Date: Mon, 06 Mar 2006 10:45:46 +0000
From: J M Cerqueira Esteves <jmce@artenumerica.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       axboe@suse.de, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
References: <4405D383.5070201@artenumerica.com>	<20060302011735.55851ca2.akpm@osdl.org>	<440865A9.4000102@artenumerica.com>	<4409B8DC.9040404@artenumerica.com>	<20060304161519.6e6fbe2c.akpm@osdl.org>	<440BFEA8.2080103@artenumerica.com> <20060306012854.581423ec.akpm@osdl.org>
In-Reply-To: <20060306012854.581423ec.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA78CF5BA8BD459665528DEBC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA78CF5BA8BD459665528DEBC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> I've not been following the saga of atapi-versus-libata at all closely. 
> Booting with libata.atapi_enabled=1 might make things work.  I think Randy
> should know what happened here?
> 
> You were testing 2.6.16-rc5, yes?  What did you expect to see and what were
> you seeing in earlier kernels (which versions?)  (IOW: what did we break
> this time?)

Yes, this was with 2.6.16-rc5 with the suggested patch.

I haven't tried libata.atapi_enabled=1 yet (I'll do it on the first
reboot after this set of tests with Gaussian).


Under both 2.6.12 (as supplied with Ubuntu Breezy) and 2.6.15 (as
supplied with the current Ubuntu Dapper, incorporating 2.6.15.4) we had:

ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x18F0 irq 14
ata1: dev 0 cfg 49:0f00 82:0218 83:4000 84:4000 85:0218 86:0000 87:4000
88:041f
ata1: dev 0 ATAPI, max UDMA/66
ata1: dev 0 configured for UDMA/33
scsi0 : ata_piix
isa bounce pool size: 16 pages
  Vendor: ASUS      Model: DRW-1608P2S       Rev: 1.37
  Type:   CD-ROM                             ANSI SCSI revision: 05

But we didn't use the drive much until now (mostly just for Linux
installation, without CD reading problems) so I have no additional data
on possible issues with previous kernels...

Best regards
                   J Esteves
-- 
+351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce

--------------enigA78CF5BA8BD459665528DEBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEDBLaesWiVDEbnjYRAtydAJwMntzHJrN9HdmdQCQe9YbtwYH5AgCg1Tg3
T37WOMYGAiHKOaI0ETO+k+0=
=IV9V
-----END PGP SIGNATURE-----

--------------enigA78CF5BA8BD459665528DEBC--
