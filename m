Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131401AbRAOUt7>; Mon, 15 Jan 2001 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131485AbRAOUtt>; Mon, 15 Jan 2001 15:49:49 -0500
Received: from www.wen-online.de ([212.223.88.39]:33555 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131483AbRAOUtb>;
	Mon, 15 Jan 2001 15:49:31 -0500
Date: Mon, 15 Jan 2001 21:49:16 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: Vlad Bolkhovitine <vladb@sw.com.sg>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: mmap()/VM problems in 2.4.0
In-Reply-To: <87hf30d0ar.fsf@atlas.iskon.hr>
Message-ID: <Pine.Linu.4.10.10101152142440.772-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2001, Zlatko Calusic wrote:

> "Vlad Bolkhovitine" <vladb@sw.com.sg> writes:
> 
> > Here is updated info for 2.4.1pre3:
> > 
> > Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/sec
> > 
> > with mmap()
> > 
> >  File   Block  Num          Seq Read    Rand Read   Seq Write  Rand Write
> >  Dir    Size   Size    Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> > ------- ------ ------- --- ----------- ----------- ----------- -----------
> >    .     1024   4096    2  1.089 1.24% 0.235 0.45% 1.118 4.11% 0.616 1.41%
> > 
> > without mmap()
> >    
> >  File   Block  Num          Seq Read    Rand Read   Seq Write  Rand Write
> >  Dir    Size   Size    Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> > ------- ------ ------- --- ----------- ----------- ----------- -----------
> >    .     1024   4096    2  28.41 41.0% 0.547 1.15% 13.16 16.1% 0.652 1.46%
> > 
> > 
> > Mmap() performance dropped dramatically down to almost unusable level. Plus,
> > system was unusable during test: "vmstat 1" updated results every 1-2 _MINUTES_!
> > 
> 
> You need Marcelo's patch. Please apply and retest.

My box thinks quite highly of that patch fwiw, but insists that he needs
to apply Jens Axboes' blk patch first ;-)  (Not because of tiobench)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
