Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265602AbSJXShU>; Thu, 24 Oct 2002 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSJXShU>; Thu, 24 Oct 2002 14:37:20 -0400
Received: from bg77.anu.edu.au ([150.203.223.77]:32966 "EHLO lassus.himi.org")
	by vger.kernel.org with ESMTP id <S265602AbSJXShS>;
	Thu, 24 Oct 2002 14:37:18 -0400
Date: Fri, 25 Oct 2002 04:43:28 +1000
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024184328.GA5667@himi.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2002 at 07:15:43PM +0200, Manfred Spraul wrote:
> AMD recommends to perform memory copies with backward read operations=20
> instead of prefetch.
>=20
> http://208.15.46.63/events/gdc2002.htm
>=20
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu,=20
> chipset and memory type?
>=20
> Please run 2 or 3 times.
>=20
simon@caccini:~/hacking$ cat /proc/cpuinfo=20
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 553.880
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov =
pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 1104.28

simon@caccini:~/hacking$ ./athlon; ./athlon; ./athlon=20
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 12855 cycles per page
copy_page function '2.4 non MMX'         took 17267 cycles per page
copy_page function '2.4 MMX fallback'    took 14930 cycles per page
copy_page function '2.4 MMX version'     took 10642 cycles per page
copy_page function 'faster_copy'         took 10591 cycles per page
copy_page function 'even_faster'         took 13035 cycles per page
copy_page function 'no_prefetch'         took 11657 cycles per page
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 12871 cycles per page
copy_page function '2.4 non MMX'         took 18482 cycles per page
copy_page function '2.4 MMX fallback'    took 15013 cycles per page
copy_page function '2.4 MMX version'     took 10679 cycles per page
copy_page function 'faster_copy'         took 12268 cycles per page
copy_page function 'even_faster'         took 10789 cycles per page
copy_page function 'no_prefetch'         took 11691 cycles per page
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 13110 cycles per page
copy_page function '2.4 non MMX'         took 14958 cycles per page
copy_page function '2.4 MMX fallback'    took 14952 cycles per page
copy_page function '2.4 MMX version'     took 12864 cycles per page
copy_page function 'faster_copy'         took 10581 cycles per page
copy_page function 'even_faster'         took 10629 cycles per page
copy_page function 'no_prefetch'         took 11607 cycles per page

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9uD9PQPlfmRRKmRwRAvL1AJ9JLD9v51/nuF44T/Q8zvBvwpLNMgCeJkWO
3DrJeKEsMpcA+kM0M6B5wU4=
=n/Gj
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
