Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSFCTWp>; Mon, 3 Jun 2002 15:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317460AbSFCTWp>; Mon, 3 Jun 2002 15:22:45 -0400
Received: from mx1.afara.com ([63.113.218.20]:29011 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S315431AbSFCTWn>;
	Mon, 3 Jun 2002 15:22:43 -0400
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, release 3.0 is
	available
From: Thomas Duffy <tduffy@directvinternet.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Kbuild Devel <kbuild-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <27953.1023071705@kao2.melbourne.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Jun 2002 12:22:18 -0700
Message-Id: <1023132138.25501.6.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 03 Jun 2002 19:22:35.0254 (UTC) FILETIME=[03F75160:01C20B34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-02 at 19:35, Keith Owens wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Content-Type: text/plain; charset=us-ascii
> 
> Release 3.0 of kernel build for kernel 2.5 (kbuild 2.5) is available.
> http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
> release 3.0.
> 
> kbuild-2.5-core-15
>   Changes from core-14.
> 
>     Replace mdbm with kbuild specific database engine to increase
>     performance.
> 
>     Remove CML2 support, Dominik Brodowski, Keith Owens.
> 
>     Remove the restriction on symlinked sources and targets.  Aegis
>     users should be able to use kbuild 2.5 now.

I get this error now on sparc64:

tduffy@curie:/build2/tduffy/linux_kbuild$ make -f Makefile-2.5 oldconfig
Using ARCH='sparc64' AS='as' LD='ld' CC='sparc64-linux-gcc' CPP='sparc64-linux-gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
make: *** [phase1] Error 139

tduffy@curie:/build2/tduffy/linux_kbuild$ make -f Makefile-2.5 oldconfig
Using ARCH='sparc64' AS='as' LD='ld' CC='sparc64-linux-gcc' CPP='sparc64-linux-gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
pp_makefile1: Attempt to fetch invalid key s(0x73)-9473
make: *** [phase1] Error 134

more verbose (PP_MAKEFILE1_FLAGS=-v) output:

...
Generating global Makefile
  phase 1 (find all inputs)
pp_makefile1 verbose 1
    scan_trees   0 /build2/tduffy/linux_kbuild/
make: *** [phase1] Error 139


-tduffy

