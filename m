Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSJXXbB>; Thu, 24 Oct 2002 19:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265692AbSJXXbB>; Thu, 24 Oct 2002 19:31:01 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:15233 "EHLO
	completely") by vger.kernel.org with ESMTP id <S265647AbSJXXbA>;
	Thu, 24 Oct 2002 19:31:00 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Date: Thu, 24 Oct 2002 16:37:04 -0700
User-Agent: KMail/1.4.7-cool
Cc: arjanv@redhat.com
References: <3DB82ABF.8030706@colorfullife.com>
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210241637.10056.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On October 24, 2002 10:15, Manfred Spraul wrote:
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu,
> chipset and memory type?
>
> Please run 2 or 3 times.

Athlon XP 1800+, 512MB 133mhz SDRAM, Debian GCC 3.2.1 snapshot.

~$: gcc -march=athlon-xp -O2 athlon.c -o athlon
~$: ./athlon; ./athlon; ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 28161 cycles per page
copy_page function '2.4 non MMX'         took 31398 cycles per page
copy_page function '2.4 MMX fallback'    took 31442 cycles per page
copy_page function '2.4 MMX version'     took 28130 cycles per page
copy_page function 'faster_copy'         took 19112 cycles per page
copy_page function 'even_faster'         took 17413 cycles per page
copy_page function 'no_prefetch'         took 12708 cycles per page
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 28171 cycles per page
copy_page function '2.4 non MMX'         took 31226 cycles per page
copy_page function '2.4 MMX fallback'    took 31178 cycles per page
copy_page function '2.4 MMX version'     took 28055 cycles per page
copy_page function 'faster_copy'         took 17193 cycles per page
copy_page function 'even_faster'         took 17287 cycles per page
copy_page function 'no_prefetch'         took 12711 cycles per page
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 27955 cycles per page
copy_page function '2.4 non MMX'         took 31069 cycles per page
copy_page function '2.4 MMX fallback'    took 33483 cycles per page
copy_page function '2.4 MMX version'     took 27917 cycles per page
copy_page function 'faster_copy'         took 17120 cycles per page
copy_page function 'even_faster'         took 17271 cycles per page
copy_page function 'no_prefetch'         took 12712 cycles per page

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9uIQlLGMzRzbJfbQRApi3AJ9+yQmGMk33Q7Ng1ze7jULIV+cEzACfQ79r
Q82U3yCZkppcUkr//3PXH+8=
=m1sv
-----END PGP SIGNATURE-----
