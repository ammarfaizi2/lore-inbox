Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313328AbSDOWqR>; Mon, 15 Apr 2002 18:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313336AbSDOWqQ>; Mon, 15 Apr 2002 18:46:16 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:12304 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313328AbSDOWqP>; Mon, 15 Apr 2002 18:46:15 -0400
Message-ID: <3CBB582D.75BEA8F6@zip.com.au>
Date: Mon, 15 Apr 2002 15:46:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] writeback daemons
In-Reply-To: <3CB3DE1E.5F811D77@zip.com.au> <20020408203839.C540@toy.ucw.cz> <3CBB3A41.8E94C8A@zip.com.au> <20020415223230.GC3406@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > > > The number of threads is dynamically managed by a simple
> > > > demand-driven algorithm.
> > >
> > > So... when we are low on free memory, we try to create more threads... Possible
> > > deadlock?
> >
> > Nope.  The number of threads is never allowed to fall below two,
> > for this very reason.
> 
> I thought this was the case. BTW do you need *two* threads for
> reliable operation, or is one enough?

I chose two because we used to have two - kupdate and bdflush.
But yes, surely one is sufficient.  Added to the todo file.

-
