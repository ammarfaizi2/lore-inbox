Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317885AbSGPQqt>; Tue, 16 Jul 2002 12:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSGPQqs>; Tue, 16 Jul 2002 12:46:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44050 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317885AbSGPQqr>; Tue, 16 Jul 2002 12:46:47 -0400
Date: Tue, 16 Jul 2002 13:49:28 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] loop.c oopses
In-Reply-To: <20020716163636.GW811@suse.de>
Message-ID: <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Jens Axboe wrote:
> On Tue, Jul 16 2002, Rik van Riel wrote:
> > On Tue, 16 Jul 2002, Andrew Morton wrote:
> >
> > > That's maybe wrong - if there are a decent number of pages
> > > under writeback then we should be able to just wait it out.
> > > But it gets tricky with the loop driver...
> >
> > I wonder if it is possible to exhaust the mempool with
> > the loop driver requests before getting around to the
> > requests to the underlying block device(s)...
>
> Given the finite size of the pool and the possibly infinite stacking
> level, yes that is possible. You may just run out of loop minors before
> this happens [1]. Also note that you need more than a simple remapping,
> crypto setup for instance.

Or maybe SMP, with multiple CPUs submitting requests at the
same time ?

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

