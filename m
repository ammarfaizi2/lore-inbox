Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbUABPMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 10:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbUABPMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 10:12:15 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:10908 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S265612AbUABPMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 10:12:14 -0500
Date: Fri, 2 Jan 2004 17:12:06 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102151206.GJ1718@actcom.co.il>
References: <3FF56B1C.1040308@conet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
Content-Disposition: inline
In-Reply-To: <3FF56B1C.1040308@conet.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2004 at 01:59:08PM +0100, Libor Vanek wrote:
> Hi,
> I'm writing some project which needs to hijack some syscalls in VFS=20
> layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are=20
> some very nasty ways of doing it - see=20
> http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )

Why do you need to hijack system calls from a module? 99% of the
times, it's the wrong technical solution.=20

> So what is proper (Linus recommanded) way to do such a things? Create=20
> patches for specific syscalls like "if this_module_installed then=20
> call_this_function;" or try to force things like syscalltrack to go into=
=20
> vanilla kernel some time? Because what I've found out there are more=20
> projects which suffer from this restriction.

There is no such Linus recommended way. For 2.6, syscalltrack's hijack
module moved into the kernel and will provide such generic
functionality one day. But I don't anticipate it every going into the
vanilla kernel, due to Linus's well known objections to syscall
hijacking in general and making it convenient in particular.=20

Cheers,
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9YpGKRs727/VN8sRApkVAKCj5atkZGJRyojDuvejJ6g69zmn8ACeMgY2
VkBw4oWKHU5D0cat7dEuqtg=
=FIzf
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--
