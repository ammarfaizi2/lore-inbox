Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289042AbSAFVhM>; Sun, 6 Jan 2002 16:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289044AbSAFVhD>; Sun, 6 Jan 2002 16:37:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44184 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id <S289042AbSAFVgx>;
	Sun, 6 Jan 2002 16:36:53 -0500
Date: Sun, 6 Jan 2002 22:36:51 +0100
From: Martin Schewe <m@xsms.de>
To: linux-kernel@vger.kernel.org
Subject: Re: In kernel routing table vs. /sbin/ip vs. /sbin/route
Message-ID: <20020106223651.B31958@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.33.0201061211050.2619-100000@tidus.zarzycki.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201061211050.2619-100000@tidus.zarzycki.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Jan 06, 2002 at 12:23:50PM -0800, Dave Zarzycki wrote:
> Using /sbin/route, I can add multiple default routes like so:
>
> /sbin/route add -net default gw 192.168.0.1
> /sbin/route add -net default gw 192.168.0.2
>
> But I cannot do the same with /sbin/ip:
>
> /sbin/ip route add default via 192.168.0.1
> /sbin/ip route add default via 192.168.0.2
> RTNETLINK answers: File exists

$ /sbin/ip route append default via 192.168.0.2

> Given that /sbin/ip is the more powerful and modern tool, I'm lead to
> believe that /sbin/route might be leaving the in kernel routing table
> in a weird state.
>
> My two simple questions are as follows:
>
> 1) Which tool is more correct?

RFC1122 says having several _default_ routes is okay.

> 2) What is the behavior of the kernel when multiple default routes are
> defined?

The kernel will make dead gateway detection to select the right one for
you.

Regards,
		Martin

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE8OMNyvFdT+uCkj6sRAnn9AJwII8SaGc1bRZlHBRG855ySFvKbcQCfXtgz
hwnQ755ng3mqAeFIpCuW+bg=
=4/s5
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
