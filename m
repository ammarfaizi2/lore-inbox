Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287750AbSAIQH0>; Wed, 9 Jan 2002 11:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287756AbSAIQHK>; Wed, 9 Jan 2002 11:07:10 -0500
Received: from nat-pool-hsv.redhat.com ([12.150.234.132]:5885 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S287750AbSAIQGu>; Wed, 9 Jan 2002 11:06:50 -0500
Date: Wed, 9 Jan 2002 10:06:12 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: salvador@inti.gov.ar
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
        t.sailer@alumni.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97 entry  for es1371 driver
Message-Id: <20020109100612.66cffd84.reynolds@redhat.com>
In-Reply-To: <3C3C658B.1DDBFA69@inti.gov.ar>
In-Reply-To: <3C3C658B.1DDBFA69@inti.gov.ar>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.r)?Tca/pnqP0/n"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.r)?Tca/pnqP0/n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Uttered "salvador" <salvador@inti.gov.ar>, spoke thus:

> Doubts:
> 1) This adds something like: /proc/driver/es1371/00:03.00/ac97 I took the
> idea from emu10k1.c module. My doubt is about the `:' it looks wrong in a
> file name, specially when that's usually used to separate file names/paths.
> Should we pass it by a small routine that converts : into something like _?

I wouldn't change it.  In fact, Linux allows _any_ character except a NULL in a
filename, although POSIX doesn't.  (Well, I wouldn't use a '/' in a filename
even if I escaped it out the wazoo!)

> 2) I used a buffer of fixed length as in other modules, but I don't feel
> really good doing it. What solutions are recommended? (if any)

The kernel stack is really small and doesn't grow, so a buffer allocated on the
stack could cause "load-dependent instability".  Using a "vmalloc" and a "vfree"
is fast, cheap and easy.

-- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- + -- -- -- -- -- -- -- -- -- --
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.r)?Tca/pnqP0/n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjw8angACgkQWEn3bOOMcupuJQCaAxZvRfqn6McFx+ruovh9nNjm
GIQAn1XKe+BAlkcGJS2IsK1iX6+ryqmE
=Rqj2
-----END PGP SIGNATURE-----

--=.r)?Tca/pnqP0/n--

