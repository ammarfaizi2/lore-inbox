Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSE2LmF>; Wed, 29 May 2002 07:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSE2LmF>; Wed, 29 May 2002 07:42:05 -0400
Received: from ns.suse.de ([213.95.15.193]:57614 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315119AbSE2LmD>;
	Wed, 29 May 2002 07:42:03 -0400
Date: Wed, 29 May 2002 13:42:02 +0200
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        "J.A. Magallon" <jamagallon@able.es>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020529134202.F27463@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@suse.cz>,
	Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
	Luigi Genoni <kernel@Expansa.sns.it>,
	"J.A. Magallon" <jamagallon@able.es>,
	Luca Barbieri <ldb@ldb.ods.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205260128110.2047-100000@Expansa.sns.it> <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org> <20020526023009.G16102@suse.de> <20020527085301.A38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 08:53:02AM +0000, Pavel Machek wrote:
 > Hi!
 > 
 > > I would be (pleasantly) surprised to see gcc turn a C memcpy into faster
 > > assembly than our current implementation. And I'll bet
 > 
 > gcc has hand-coded assembly inside itself, if gcc compiled memcpy is slower
 > than hand-optimized one, you found a compiler bug.

Not at all. gcc compiled memcpy just has no knowledge of things like
non-temporal stores, and using mmx/sse to move 64 bits at a time instead
of 32 bit registers. (It's only recently it got prefetch abilities too).

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
