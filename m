Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288355AbSAHVZi>; Tue, 8 Jan 2002 16:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288393AbSAHVY2>; Tue, 8 Jan 2002 16:24:28 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:14098 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288394AbSAHVYR>;
	Tue, 8 Jan 2002 16:24:17 -0500
Date: Tue, 8 Jan 2002 19:24:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Robert Love <rml@tech9.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <1010524532.3383.106.camel@phantasy>
Message-ID: <Pine.LNX.4.33L.0201081920130.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2002, Robert Love wrote:
> On Tue, 2002-01-08 at 16:08, Rik van Riel wrote:
>
> > The preemptible kernel ALSO has to wait for a scheduling point
> > to roll around, since it cannot preempt with spinlocks held.
> >
> > Considering this, I don't see much of an advantage to adding
> > kernel preemption.
>
> It only has to wait if locks are held and then only until the locks are
> dropped.  Otherwise it will preempt on the next return from interrupt.

So what exactly _is_ the difference between an explicit
preemption point and a place where we need to explicitly
drop a spinlock ?

>From what I can see, there really isn't a difference.

> Future work would be to look into long-held locks and see what we can
> do.

One thing we could do is download Andrew Morton's patch ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

