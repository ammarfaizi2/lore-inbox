Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132407AbRDJQS0>; Tue, 10 Apr 2001 12:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132402AbRDJQSQ>; Tue, 10 Apr 2001 12:18:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43535 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132407AbRDJQSE>;
	Tue, 10 Apr 2001 12:18:04 -0400
Date: Tue, 10 Apr 2001 13:10:10 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: george anzinger <george@mvista.com>
Cc: SodaPop <soda@xirr.com>, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] 2.4.x nice level
In-Reply-To: <3AD27FE6.4987E792@mvista.com>
Message-ID: <Pine.LNX.4.21.0104101308320.11038-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2001, george anzinger wrote:
> SodaPop wrote:
> > 
> > I too have noticed that nicing processes does not work nearly as
> > effectively as I'd like it to.  I run on an underpowered machine,
> > and have had to stop running things such as seti because it steals too
> > much cpu time, even when maximally niced.

> In kernel/sched.c for HZ < 200 an adjustment of nice to tick is set up
> to be nice>>2 (i.e. nice /4).  This gives the ratio of nice to time
> slice.  Adjustments are made to make the MOST nice yield 1 jiffy, so
	[snip 2.4 nice scale is too limited]

I'll try to come up with a recalculation change that will make
this thing behave better, while still retaining the short time
slices for multiple normal-priority tasks and the cache footprint
schedule() and friends currently have...

[I've got some vague ideas ... give me a few hours to put them
into code ;)]

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

