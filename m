Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278493AbRJZOjn>; Fri, 26 Oct 2001 10:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278494AbRJZOje>; Fri, 26 Oct 2001 10:39:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36358 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S278493AbRJZOjY>;
	Fri, 26 Oct 2001 10:39:24 -0400
Date: Fri, 26 Oct 2001 16:39:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
Message-ID: <20011026163958.C3324@suse.de>
In-Reply-To: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com> <dnr8rqu30x.fsf@magla.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dnr8rqu30x.fsf@magla.zg.iskon.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26 2001, Zlatko Calusic wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > On 25 Oct 2001, Zlatko Calusic wrote:
> > >
> > > Yes, I definitely have DMA turned ON. All parameters are OK. :)
> > 
> > I suspect it may just be that "queue_nr_requests"/"batch_count" is
> > different in -ac: what happens if you tweak them to the same values?
> > 
> 
> Next test:
> 
> block: 1024 slots per queue, batch=341

That's way too much, batch should just stay around 32, that is fine.

> Still very spiky, and during the write disk is uncapable of doing any
> reads. IOW, no serious application can be started before writing has
> finished. Shouldn't we favour reads over writes? Or is it just that
> the elevator is not doing its job right, so reads suffer?

You are probably just seeing starvation due to the very long queues.

-- 
Jens Axboe

