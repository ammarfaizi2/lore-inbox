Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265039AbTFYUJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbTFYUJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:09:20 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:30641 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265039AbTFYUJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:09:09 -0400
Date: Wed, 25 Jun 2003 22:23:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcus Metzler <mocm@metzlerbros.de>
Cc: Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
       Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625202312.GG1770@wohnheim.fh-wedel.de>
References: <20030625181606.A29104@infradead.org> <16121.55873.675690.542574@sheridan.metzler> <20030625182409.A29252@infradead.org> <16121.56382.444838.485646@sheridan.metzler> <20030625185036.C29537@infradead.org> <16121.58735.59911.813354@sheridan.metzler> <20030625191532.A1083@infradead.org> <16121.60747.537424.961385@sheridan.metzler> <20030625194250.GF1770@wohnheim.fh-wedel.de> <16122.379.321217.737557@sheridan.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16122.379.321217.737557@sheridan.metzler>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 June 2003 22:09:31 +0200, Marcus Metzler wrote:
> =?iso-8859-1?Q?J=F6rn?= Engel writes:
>  > On Wed, 25 June 2003 20:43:23 +0200, Marcus Metzler wrote:
>  > > Christoph Hellwig writes:
>  > >  > On Wed, Jun 25, 2003 at 08:09:51PM +0200, Marcus Metzler wrote:
>  > >  > >  > If the structures change incompatibly you're fucked anyway.  Better
>  > >  > > 
>  > >  > > Not necessarily, e.g. changing
>  > >  > > 
>  > >  > > #define AUDIO_SET_ATTRIBUTES       _IOW('o', 17, audio_attributes_t)
>  > >  > > #define AUDIO_SET_KARAOKE          _IOW('o', 18, audio_karaoke_t)
>  > >  > > 
>  > >  > > to 
>  > >  > > 
>  > >  > > #define AUDIO_SET_ATTRIBUTES       _IOW('o', 47, audio_attributes_t)
>  > >  > > #define AUDIO_SET_KARAOKE          _IOW('o', 48, audio_karaoke_t)
>  > >  > > 
>  > >  > > or
>  > >  > 
>  > >  > In that case yes, you are screwed.  Your ABI just changed incompatibly.
>  > > 
>  > > Not if you recompile.
>  > 
>  > Isn't the point of an application _binary_ interface, that you don't
>  > have to recompile?
> 
> You don't need headers for binaries either, so what's your point.

So you don't recompile, but you still changed the magic ioctl numbers
from 17 to 47 and from 18 to 48.  Old binaries don't work any more,
even though the same semantics are still present.  That is an
incompatible change in my book.

Worse if there is a new semantic for 17 or 18, in that case the old
binaries may break randomly, depending on kernel version.

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
