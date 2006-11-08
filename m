Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965711AbWKHM61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965711AbWKHM61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965716AbWKHM60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:58:26 -0500
Received: from lugor.de ([212.112.242.222]:38076 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S965711AbWKHM60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:58:26 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: invalidate/drop filesystem caches & io buffers
Date: Wed, 8 Nov 2006 13:58:25 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <f36b08ee0611080453p5401de04td2fef8bff4d0efb3@mail.gmail.com>
In-Reply-To: <f36b08ee0611080453p5401de04td2fef8bff4d0efb3@mail.gmail.com>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3063529.bODHxDzXyQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611081358.25245.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Wed, 08 Nov 2006 13:58:21 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3063529.bODHxDzXyQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 08 November 2006 13:53, Yakov Lerner wrote:
> I'd like to invalidate/free the filesystem caches and io buffer cache
> How can I do this when I can't unmount the filesystem (and w/o reboot) ?
>
> (I run filesystem I/O test that needs to  start from fresh  cache &
> buffer state -- as emty as possible, like right after mount/boot).
>
> I tried  'mount -o remount' but it didn't make any difference
> on the timing. Apparently 'mount -o remount' did not invalidate
> cases/buffers ? ( The difference between fresh run vs non-fresh
> run timing is x5 times ).

You can do

echo 3 > /proc/sys/vm/drop_caches

Take a look at filesystems/proc.txt for details.
=2D-=20
Regards,
Christian

--nextPart3063529.bODHxDzXyQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFUdRxlZfG2c8gdSURAmwoAKCah0rL0Yk/upucG183bhuqTvZ4ZgCfTQoY
orLxtSWeDZXYFr1HU/cs3Lo=
=SLHS
-----END PGP SIGNATURE-----

--nextPart3063529.bODHxDzXyQ--
