Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272472AbRIFMdP>; Thu, 6 Sep 2001 08:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272473AbRIFMcz>; Thu, 6 Sep 2001 08:32:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21510 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272472AbRIFMcr>;
	Thu, 6 Sep 2001 08:32:47 -0400
Date: Thu, 6 Sep 2001 09:32:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010906122459Z16031-32383+3771@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109060930580.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Daniel Phillips wrote:
> On September 6, 2001 01:52 pm, Rik van Riel wrote:
> > On Tue, 4 Sep 2001, Jan Harkes wrote:
> >
> > > To get back on the thread I jumped into, I totally agree with Linus
> > > that writeout should be as soon as possible.
> >
> > Nice way to destroy read performance.
>
> Blindly delaying all the writes in the name of better read performance
> isn't the right idea either.  Perhaps we should have a good think
> about some sensible mechanism for balancing reads against writes.

Absolutely, delaying writes for too long is just as bad,
we need something in-between.

> > Lets face it, spinning the washing machine is expensive
> > and running less than a full load makes things inefficient ;)
>
> That makes a good sound bite but doesn't stand up to scrutiny.
> It's not a washing machine ;-)

Two words:  "IO clustering".

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

