Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270227AbRIFMwP>; Thu, 6 Sep 2001 08:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269779AbRIFMwG>; Thu, 6 Sep 2001 08:52:06 -0400
Received: from ns.ithnet.com ([217.64.64.10]:17682 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S270227AbRIFMvz>;
	Thu, 6 Sep 2001 08:51:55 -0400
Date: Thu, 6 Sep 2001 14:51:52 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: _deepfire@mail.ru, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: page pre-swapping + moving it on cache-list
Message-Id: <20010906145152.5b229174.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33L.0109060828420.31200-100000@imladris.rielhome.conectiva>
In-Reply-To: <200109060519.f865Ja106488@vegae.deep.net>
	<Pine.LNX.4.33L.0109060828420.31200-100000@imladris.rielhome.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001 08:29:03 -0300 (BRST) Rik van Riel <riel@conectiva.com.br>
wrote:

> On Thu, 6 Sep 2001, Samium Gromoff wrote:
> 
> >        Here is an idea i think i stole from Matthew Dillon`s paper.
> >
> >     Actually it sound more like we take some pages from the near 0
> >   age and swapping them out but not throwing them away, but moving them
> >   from active list to cache. So that we can always throw them away
> >   at near null cost while shrinking the cache. This is like a
> >   replacement for swap-cache if i`m right here...
> 
> This is called the "inactive_clean" list in Linux terminology. ;)

What's the use of an inactive_clean list anyway, or the effective difference
between its members and the members of memfree (I suspect such a list from the
output of /proc/meminfo)?
Besides the fact, that the splitting in two lists prevents proper
defragmentation (if you have pages in two lists you are not driven to defrag at
the point where you put them together in one).

Regards,
Stephan

