Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSLNUR3>; Sat, 14 Dec 2002 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbSLNUR3>; Sat, 14 Dec 2002 15:17:29 -0500
Received: from angband.namesys.com ([212.16.7.85]:16769 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265885AbSLNUR3>; Sat, 14 Dec 2002 15:17:29 -0500
Date: Sat, 14 Dec 2002 23:25:20 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
Message-ID: <20021214232520.A10786@namesys.com>
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com> <20021214162108.A3452@namesys.com> <3DFB7B9E.FC404B6B@digeo.com> <20021214222053.A10506@namesys.com> <3DFB904F.2ADDE2D4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DFB904F.2ADDE2D4@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Dec 14, 2002 at 12:10:55PM -0800, Andrew Morton wrote:
> > Well, 450 bytes is way below 4k (~7 times less if we'd take task struct
> > into account) ;)
> > I can replace that on-stack array with kmalloc, but that probably
> > would be a lot of overhead for no benefit.
> It would be a little overhead.  kmalloc is damn quick, and remember
> that this data has to be copied from userspace and has go to disk
> sometime.   These things will make the kmalloc overhead very small.

Hm. Ok, this can be done.

> > What do you think is safe stack usage limit for a function?
> As little as possible?

reiserfs v3  was traditionally hungry on stack space I think.

> One way of measuring these things is with your trusty linusometer.
> Manfred and I were sent back to the drawing board last week for a
> function which used 400 bytes...

;)

> > (and btw you have not even seen reiser4 stack usage ;) )
> uh-oh.   We need to be very sparing indeed.
> I had a patch once which would print out "maximum stack space
> ever used by this process" on exit, but Alan fumbled it.  I shall
> resurrect it.

We have that for reiser4, that how we learn about all the stack overflows we
have/had ;)

Bye,
    Oleg
