Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278565AbRJZO5X>; Fri, 26 Oct 2001 10:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278567AbRJZO5N>; Fri, 26 Oct 2001 10:57:13 -0400
Received: from inje.iskon.hr ([213.191.128.16]:57293 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S278565AbRJZO5E>;
	Fri, 26 Oct 2001 10:57:04 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com>
	<dnr8rqu30x.fsf@magla.zg.iskon.hr> <20011026163958.C3324@suse.de>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 26 Oct 2001 16:57:32 +0200
In-Reply-To: <20011026163958.C3324@suse.de> (Jens Axboe's message of "Fri, 26 Oct 2001 16:39:58 +0200")
Message-ID: <dnpu7asb37.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Fri, Oct 26 2001, Zlatko Calusic wrote:
> > Linus Torvalds <torvalds@transmeta.com> writes:
> > 
> > > On 25 Oct 2001, Zlatko Calusic wrote:
> > > >
> > > > Yes, I definitely have DMA turned ON. All parameters are OK. :)
> > > 
> > > I suspect it may just be that "queue_nr_requests"/"batch_count" is
> > > different in -ac: what happens if you tweak them to the same values?
> > > 
> > 
> > Next test:
> > 
> > block: 1024 slots per queue, batch=341
> 
> That's way too much, batch should just stay around 32, that is fine.

OK. Anyway, neither configuration works well, so the problem might be
somewhere else.

While at it, could you give short explanation of those two parameters?

> 
> > Still very spiky, and during the write disk is uncapable of doing any
> > reads. IOW, no serious application can be started before writing has
> > finished. Shouldn't we favour reads over writes? Or is it just that
> > the elevator is not doing its job right, so reads suffer?
> 
> You are probably just seeing starvation due to the very long queues.
> 

Is there anything we could do about that? I remember Linux once had a
favoured reads, but I'm not sure if we do that likewise these days.

When I find some time, I'll dig around that code. It is very
interesting part of the kernel, I'm sure, I just didn't have enough
time so far, to spend hacking on that part.
-- 
Zlatko
