Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277711AbRJRNhi>; Thu, 18 Oct 2001 09:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277714AbRJRNh2>; Thu, 18 Oct 2001 09:37:28 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:43789 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S277711AbRJRNhP>; Thu, 18 Oct 2001 09:37:15 -0400
Date: Thu, 18 Oct 2001 15:37:38 +0200
From: Cliff Albert <cliff@oisec.net>
To: Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Kernel Link Problems
Message-ID: <20011018153738.A9582@oisec.net>
Mail-Followup-To: Bill Huey <billh@gnuppy.monkey.org>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20011017162941.A32145@gnuppy> <20011018152516.A9089@oisec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018152516.A9089@oisec.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 03:25:16PM +0200, Cliff Albert wrote:

> > I'm running the 2.4.12-ac3 and I get this while linking vmlinuz:
> > 
> > 	ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
> > 	ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
> > 	ld: final link failed: Bad value
> > 
> 
> Same thing happening here on 2.4.12-ac{2,3}, 2.4.12-ac1 will link correctly
> 
> ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
> ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
> ld: final link failed: Bad value
> 
> Distribution is Debian/unstable (apt-get dist-upgraded just before compile)
> 
> Linux neve 2.4.12-ac1 #7 Fri Oct 12 21:27:50 CEST 2001 i686 unknown
>  
>  Gnu C                  2.95.4
>  Gnu make               3.79.1
>  util-linux             2.11l
>  mount                  2.11l
>  modutils               2.4.10
>  e2fsprogs              1.25
>  reiserfsprogs          3.x.0j
>  Linux C Library        2.2.4
>  Dynamic linker (ldd)   2.2.4
>  Procps                 2.0.7
>  Net-tools              1.60
>  Kbd                    1.06
>  Sh-utils               2.0.11

Some more investigation pointed me that this maybe a flaw in some package in debian-unstable. As 2.4.12-ac2 compiled on my laptop (which was not uptodate) and i've had reports that ac3 compiled just fine on machines running debian-stable.

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
