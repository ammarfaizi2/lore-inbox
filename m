Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSE2T51>; Wed, 29 May 2002 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSE2T50>; Wed, 29 May 2002 15:57:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51209 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315449AbSE2T50>; Wed, 29 May 2002 15:57:26 -0400
Date: Wed, 29 May 2002 21:57:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        "J.A. Magallon" <jamagallon@able.es>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Cc: hubicka@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020529195727.GC31266@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44.0205260128110.2047-100000@Expansa.sns.it> <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org> <20020526023009.G16102@suse.de> <20020527085301.A38@toy.ucw.cz> <20020529134202.F27463@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > I would be (pleasantly) surprised to see gcc turn a C memcpy into faster
>  > > assembly than our current implementation. And I'll bet
>  > 
>  > gcc has hand-coded assembly inside itself, if gcc compiled memcpy is slower
>  > than hand-optimized one, you found a compiler bug.
> 
> Not at all. gcc compiled memcpy just has no knowledge of things like
> non-temporal stores, and using mmx/sse to move 64 bits at a time

non-temporal stores are bypassing cache? Is it always good idea?

> instead
> of 32 bit registers. (It's only recently it got prefetch abilities
> too).

gcc knows about mmx/sse, and could decide to use it.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
