Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272464AbRIFMZF>; Thu, 6 Sep 2001 08:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272466AbRIFMYz>; Thu, 6 Sep 2001 08:24:55 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:42758 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272464AbRIFMYk>; Thu, 6 Sep 2001 08:24:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 14:31:32 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109060851020.31200-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109060851020.31200-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010906122459Z16031-32383+3771@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 01:52 pm, Rik van Riel wrote:
> On Tue, 4 Sep 2001, Jan Harkes wrote:
> 
> > To get back on the thread I jumped into, I totally agree with Linus
> > that writeout should be as soon as possible.
> 
> Nice way to destroy read performance.

Blindly delaying all the writes in the name of better read performance isn't 
the right idea either.  Perhaps we should have a good think about some 
sensible mechanism for balancing reads against writes.

> As DaveM noted so
> nicely in his reverse mapping patch (at the end of the
> 2.3 series), dirty pages get moved to the laundry list
> and the washing machine will deal with them when we have
> a full load.
> 
> Lets face it, spinning the washing machine is expensive
> and running less than a full load makes things inefficient ;)

That makes a good sound bite but doesn't stand up to scrutiny.

It's not a washing machine ;-)

--
Daniel
