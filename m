Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291702AbSBHSMy>; Fri, 8 Feb 2002 13:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291701AbSBHSMo>; Fri, 8 Feb 2002 13:12:44 -0500
Received: from nat-pool-hsv.redhat.com ([12.150.234.132]:25613 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S291693AbSBHSMl>; Fri, 8 Feb 2002 13:12:41 -0500
Date: Fri, 8 Feb 2002 12:12:05 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Alexander Viro" <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for duplicate /proc entries
Message-Id: <20020208121205.626d2184.reynolds@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0202081251450.28514-100000@weyl.math.psu.edu>
In-Reply-To: <20020208174730.GA343@mis-mike-wstn>
	<Pine.GSO.4.21.0202081251450.28514-100000@weyl.math.psu.edu>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.0cvs39 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.n3B_4fkLQ1qtJp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.n3B_4fkLQ1qtJp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Uttered "Alexander Viro" <viro@math.psu.edu>, spoke thus:

> 	No point.  Check that file already exist and BUG() if it does.
> Unconditionally.  There's no need to be nice to broken code and yes,
> any code that tries to register existing procfs entry _is_ broken.
> That was never supposed to work.

Al, please confirm that your are asking Brent to reissue this patch with just
the checking and then BUG(). The current code fails but looks to the caller as
if it worked.

-- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- + -- -- -- -- -- -- -- -- -- --
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.n3B_4fkLQ1qtJp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjxkFPkACgkQWEn3bOOMcupagwCdFZq3dyitWrsnMVhH+MmUa7BY
pAkAoJmH+HBrANq3LpJaXp24/VeBX6x2
=QKNV
-----END PGP SIGNATURE-----

--=.n3B_4fkLQ1qtJp--

