Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265540AbUEZM1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUEZM1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUEZM1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:27:37 -0400
Received: from pdbn-d9bb9e9b.pool.mediaWays.net ([217.187.158.155]:7178 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265540AbUEZM1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:27:12 -0400
Date: Wed, 26 May 2004 14:27:05 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040526122705.GA14320@citd.de>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk> <40B467DA.4070600@yahoo.com.au> <20040526101001.GA13426@citd.de> <40B47278.6090309@yahoo.com.au> <20040526105837.GA13810@citd.de> <40B47D4C.6050206@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B47D4C.6050206@yahoo.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 09:19:40PM +1000, Nick Piggin wrote:
> Matthias Schniedermeyer wrote:
> >On Wed, May 26, 2004 at 08:33:28PM +1000, Nick Piggin wrote:
> >
> >>Matthias Schniedermeyer wrote:
> >>
> 
> >>>In my personal machine i have 3GB of RAM and i regularly create
> >>>DVD-ISO-Images (about 2 per day). After creating an image (reading up to
> >>>4,4GB and writing up to 4,4GB) the cache is 100% trashed(1). With swap
> >>>it would be even more trashed then it is without swap(1).
> >>>
> >>
> >>I don't disagree that you could find a situation where swap
> >>is worse than no swap. I don't understand what you mean by
> >>trashed and more trashed though :)
> >
> >
> >trashed means "everything i need(tm)" is paged out (mozilla/konsole/xine
> >...)
> >
> >with swap the data-part of running programs was swapped out, without
> >swap only the program-part is thrown out of memory as the data-part
> >can't be moved anywhere else.
> >
> >I have a 10KPRM SCSI-HDD, i can here what my system is doing. :-)
> >
> 
> OK, this is obviously bad. Do you get this behaviour with 2.6.5
> or 2.6.6? If so, can you strace the program while it is writing
> an ISO? (just send 20 lines or so). Or tell me what program you
> use to create them and how to create one?

program: mkisofs
kernel: 2.4.4-2.4.25, 2.6.4-2.6.6
(To say it in other words, i never (seen/felt) a difference in 3 years.
So if there is a difference i just didn't realized there is one)
The current kernel is 2.6.5 as 2.6.6 sometimes just "hangs"

Just throw together some lage files (My files are all >= 350MB, the
"typical" case is about 4-5files with 800-1000MB each) and then
mkisofs -J -r -o <image> <source-dir>
I store the image files on another HDD to get best possibel throughput.
My HDDs (these are "normal" IDE-HDDs) are capable of delivering about
35-40MB/s, the last time i measured i got about 70MB/s aggregated
throughput while creating an image-file.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

