Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbRFIDJj>; Fri, 8 Jun 2001 23:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbRFIDJ3>; Fri, 8 Jun 2001 23:09:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:2568 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262076AbRFIDJX>;
	Fri, 8 Jun 2001 23:09:23 -0400
Date: Sat, 9 Jun 2001 00:09:14 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Comment on patch to remove nr_async_pages limit
In-Reply-To: <87y9r6yksv.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.21.0106090008110.10415-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Jun 2001, Zlatko Calusic wrote:
> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> [snip]
> > Exactly. And when we reach a low watermark of memory, we start writting
> > out the anonymous memory.
> 
> Hm, my observations are a little bit different. I find that writeouts
> happen sooner than the moment we reach low watermark, and many times
> just in time to interact badly with some read I/O workload that made a
> virtual shortage of memory in the first place.

I have a patch that tries to address this by not reordering
the inactive list whenever we scan through it. I'll post it
right now ...

(yes, I've done some recreational patching while on holidays)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

