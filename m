Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284899AbSADVAY>; Fri, 4 Jan 2002 16:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbSADVAP>; Fri, 4 Jan 2002 16:00:15 -0500
Received: from t2.redhat.com ([199.183.24.243]:56817 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S284933AbSADVAC>; Fri, 4 Jan 2002 16:00:02 -0500
Date: Fri, 4 Jan 2002 14:59:49 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Steffen Persvold" <sp@scali.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Short question about the mmap method
Message-Id: <20020104145949.682d51c4.reynolds@redhat.com>
In-Reply-To: <3C360FD5.91285F5D@scali.no>
In-Reply-To: <3C360FD5.91285F5D@scali.no>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.6cvs17 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.bEa.B5jokgb3,D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.bEa.B5jokgb3,D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Uttered "Steffen Persvold" <sp@scali.no>, spoke thus:

> Hi lkml readers,
> 
> I have a question regarding drivers implementing the mmap and nopage methods.
> In some references I've read that pages in kernel allocated memory (either
> allocated with kmalloc, vmalloc or__get_free_pages) should be set to reserved
> (mem_map_reserve or set_bit(PG_reserved, page->flags) before they can be
> mmap'ed to guarantee that they can't be swapped out. Is this true ?

[kv]malloc memory is _never_ subject to paging and can be mmap'ed with a
vengeance without resorting to mucking about with marking pages or the like.

You're working too hard ;-)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- + -- -- -- -- -- -- -- -- -- --
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.bEa.B5jokgb3,D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjw2F8kACgkQWEn3bOOMcur7ogCfc0lTICsWiXKgrFHEDjrIkCPJ
YFIAoLCUpzPKgkDHPLoDmxeIGF5mGGIu
=vKSN
-----END PGP SIGNATURE-----

--=.bEa.B5jokgb3,D--

