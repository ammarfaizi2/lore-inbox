Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSE3Kpf>; Thu, 30 May 2002 06:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316575AbSE3Kpe>; Thu, 30 May 2002 06:45:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37136 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316573AbSE3Kpd>; Thu, 30 May 2002 06:45:33 -0400
Date: Thu, 30 May 2002 12:45:34 +0200
From: Jan Hubicka <jh@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jan Hubicka <jh@suse.cz>, Pavel Machek <pavel@suse.cz>,
        Dave Jones <davej@suse.de>,
        Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        "J.A. Magallon" <jamagallon@able.es>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020530104534.GB10672@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020530064048.GJ19308@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0205260128110.2047-100000@Expansa.sns.it> <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org> <20020526023009.G16102@suse.de> <20020527085301.A38@toy.ucw.cz> <20020529134202.F27463@suse.de> <20020529195727.GC31266@atrey.karlin.mff.cuni.cz> <27631.1022754314@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> jh@suse.cz said:
> >  I don't do that at the moment.  I am thinking about teaching it to
> > use SSE moves for moving/clearing 64bit and larger values in memory.
> > (ie for inlining constantly sized string operations)
> 
> Please ensure that we get -mno-implicit-fp and/or -mno-implicit-sse options 
> to GCC _long_ before there's any chance of actually _needing_ to use them 
> to get a correct kernel compile.

I am keeping this in mind.  Unfortunately we are running into command
line options explossion.  We already do have -msse, -msse2,
-mfpamath=sse/i387/sse,i387
all affecting in nontrivial way the compilation.  I would like to
implement SSE based string functions and SSE based integer arithmetics
soon, later we may want to use SSE for complex numbers and
autovectorization.  We may want to use MMX when the register files are
split and 3dNOW as alternative for float arithmetics.

By adding option for each such feature, soon we will run out of
oppurtunities to test them all to be functional :(

Honza
> 
> --
> dwmw2
> 
