Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265467AbUEZK7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUEZK7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265472AbUEZK7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:59:00 -0400
Received: from pdbn-d9bb9e9b.pool.mediaWays.net ([217.187.158.155]:64009 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265467AbUEZK6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:58:41 -0400
Date: Wed, 26 May 2004 12:58:37 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040526105837.GA13810@citd.de>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk> <40B467DA.4070600@yahoo.com.au> <20040526101001.GA13426@citd.de> <40B47278.6090309@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B47278.6090309@yahoo.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 08:33:28PM +1000, Nick Piggin wrote:
> Matthias Schniedermeyer wrote:
> >On Wed, May 26, 2004 at 07:48:10PM +1000, Nick Piggin wrote:
> >
> >>John Bradford wrote:
> >>
> >>>Quote from Nick Piggin <nickpiggin@yahoo.com.au>:
> >>>
> >>>
> >>>>Even for systems that don't *need* the extra memory space, swap can
> >>>>actually provide performance improvements by allowing unused memory
> >>>>to be replaced with often-used memory.
> >>>
> >>>
> >>>That's true, but it's not a magical property of swap space - extra 
> >>>physical
> >>>RAM would do more or less the same thing.
> >>>
> >>
> >>Well it is a magical property of swap space, because extra RAM
> >>doesn't allow you to replace unused memory with often used memory.
> >>
> >>The theory holds true no matter how much RAM you have. Swap can
> >>improve performance. It can be trivially demonstrated.
> >
> >
> >The other way around can be "demonstrated" equally trivially.
> >
> >In my personal machine i have 3GB of RAM and i regularly create
> >DVD-ISO-Images (about 2 per day). After creating an image (reading up to
> >4,4GB and writing up to 4,4GB) the cache is 100% trashed(1). With swap
> >it would be even more trashed then it is without swap(1).
> >
> 
> I don't disagree that you could find a situation where swap
> is worse than no swap. I don't understand what you mean by
> trashed and more trashed though :)

trashed means "everything i need(tm)" is paged out (mozilla/konsole/xine
...)

with swap the data-part of running programs was swapped out, without
swap only the program-part is thrown out of memory as the data-part
can't be moved anywhere else.

I have a 10KPRM SCSI-HDD, i can here what my system is doing. :-)

> Creating your ISOs makes your system swap a lot when swap
> is enabled?

Transfering up to 8,8GB tends to trash the cache.

> >1: This has "always(tm)" been so since i began burning DVDs 3 years ago.
> >Beginning from kernel 2.4.4-2.4.25 and 2.6.4-2.6.6. Currently i use 2.6.5. 
> >(This is no typo!)
> >
> >I have only tested the "with swap"-case with 2.4.4 as i didn't use swap
> >after 2.4.4 trashed so badly with swap enabled. But i don't think that
> >things have changed so fundamentaly that the "with swap"-case is
> >better(FOR ME!) than the "without swap"-case.
> >
> 
> The 2.6 VM has changed pretty fundamentally. It would be good
> if you could retest.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

