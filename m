Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287704AbSAABWI>; Mon, 31 Dec 2001 20:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287705AbSAABV5>; Mon, 31 Dec 2001 20:21:57 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:47110 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S287704AbSAABVu>; Mon, 31 Dec 2001 20:21:50 -0500
Date: Mon, 31 Dec 2001 19:21:19 -0600
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20020101012119.GA1303@cadcamlab.org>
In-Reply-To: <E16K1fn-0001Ky-00@the-village.bc.nu> <200112312251.fBVMpNws032221@sleipnir.valparaiso.cl> <20011231205552.A17089@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011231205552.A17089@conectiva.com.br>
User-Agent: Mutt/1.3.24i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    [Alan Cox]
> > > 	find $TOPDIR -name "*.cf" -exec cat {} \; > Configure.help 

  [Horst von Brand]
> >      cat `find $TOPDIR -name "*.cf"` > Configure.help #;-)

[Arnaldo Carvalho de Melo]
> whatever is faster, do you have trustable benchmark numbers? ;)

Fewer forks vs. increased parallelism ... depends on the nature of your
bottlenecks, I guess, and cold vs. hot cache.  Or you could have it
both ways:

	find $TOPDIR -name \*.cf | xargs -n10 cat > Configure.help

...where 10 is tuned by benchmarking. (:

> Yes, its a joke, have a nice 2002 all!

Yeah, same from me..

Peter
