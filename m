Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVAWWlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVAWWlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 17:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVAWWlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 17:41:39 -0500
Received: from xs4all.vs19.net ([213.84.236.198]:47336 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S261367AbVAWWlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 17:41:36 -0500
Date: Sun, 23 Jan 2005 23:41:33 +0100
From: Jasper Spaans <jasper@vs19.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2 complains badly aboud badness in local_bh_enable
Message-ID: <20050123224133.GA4301@spaans.vs19.net>
References: <20050123120114.GA1348@elf.ucw.cz> <1106492276.9269.14.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1106492276.9269.14.camel@pegasus>
X-Copyright: Copyright 2005 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hoi,

On Sun, Jan 23, 2005 at 03:57:56PM +0100, Marcel Holtmann wrote:

> > -rc1 worked fine here. -rc2 complains a lot:
> >=20
> > Jan 23 12:59:50 amd kernel: Badness in local_bh_enable at kernel/softir=
q.c:140
[snip]

> the problem is the PPP code (not Bluetooth btw.) like others reported so
> far. I also see the same problem with the external MadWiFi driver.

I'm seeing a similar problem on my machine - one that does not know what ppp
is. Main suspect is the network bridging code in combination with iptables;
the first lines of the message:

Jan 23 07:50:56 spaans kernel:  [local_bh_enable+42/109] local_bh_enable+0x=
2a/0x6d
Jan 23 07:50:56 spaans kernel:  [pg0+979444471/1068110848] ipt_do_table+0x2=
db/0x310 [ip_tables]
Jan 23 07:50:56 spaans kernel:  [pg0+942403693/1068110848] ipt_local_out_ho=
ok+0x51/0x58 [iptable_filter]
Jan 23 07:50:56 spaans kernel:  [nf_iterate+64/137] nf_iterate+0x40/0x89
Jan 23 07:50:56 spaans kernel:  [pg0+979631787/1068110848] br_nf_local_out_=
finish+0x0/0x77 [bridge]

(Btw, this kernel is enhanced with hostap and swsusp2 support, if needed I
can compile a vanilla -rc2)


Groet,
--=20
Jasper Spaans                                       http://jsp.vs19.net/
 23:34:43 up 10203 days, 15:21, 0 users, load average: 6.00 6.06 6.20

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB9CgdN+t4ZIsVDPgRAmhFAKDhWSmPt2XzivyxUSe5mR4hnt41TQCfb9w9
w2R8roey0a/cDHhrsd5vHlk=
=n43n
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
