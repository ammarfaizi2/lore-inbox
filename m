Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVB1FMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVB1FMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 00:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVB1FMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 00:12:30 -0500
Received: from dea.vocord.ru ([217.67.177.50]:65408 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261559AbVB1FLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 00:11:54 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <42227AEA.6050002@ak.jp.nec.com>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>
	 <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com>
	 <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com>
	 <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet>
	 <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet>
	 <42227AEA.6050002@ak.jp.nec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pCaTatLiGl3pT+YdyW8k"
Organization: MIPT
Date: Mon, 28 Feb 2005 08:17:31 +0300
Message-Id: <1109567851.28266.5.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 28 Feb 2005 08:11:14 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pCaTatLiGl3pT+YdyW8k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-02-28 at 10:59 +0900, Kaigai Kohei wrote:
> Hello,
>=20
> Marcelo Tosatti wrote:
>  > Yep, the netlink people should be able to help - they known what would=
 be
>  > required for not sending messages in case there is no listener registe=
red.
>  >
>  > Maybe its already possible? I have never used netlink myself.
>=20
> If we notify the fork/exec/exit-events to user-space directly as you said=
,
> I don't think some hackings on netlink is necessary.
> For example, such packets is sent only when /proc/sys/.../process_groupin=
g is set,
> and user-side daemon set this value, and unset when daemon will exit.
> It's not necessary to take too seriously.


Kernel accounting already was discussed in lkml week ago - I'm quite=20
sure Guillaume Thouvenin created exactly that.
His module creates do_fork() hook and broadcasts various process' states
over netlink.

Discussion at http://lkml.org/lkml/2005/2/17/87

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-pCaTatLiGl3pT+YdyW8k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCIqlrIKTPhE+8wY0RAthtAJ0RD3Cp+M7g8KRNKmsk3aDKkssYwgCfaXXF
hDb9HN70L6Uio6XFUIDg+3Y=
=ZWTO
-----END PGP SIGNATURE-----

--=-pCaTatLiGl3pT+YdyW8k--

