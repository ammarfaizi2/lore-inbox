Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268295AbRHAVUz>; Wed, 1 Aug 2001 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268310AbRHAVUr>; Wed, 1 Aug 2001 17:20:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13040 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S268295AbRHAVUg>; Wed, 1 Aug 2001 17:20:36 -0400
Message-ID: <3B68728C.7D23FFBC@mvista.com>
Date: Wed, 01 Aug 2001 14:20:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <3B683AC4.E0F2BF9E@mvista.com> <3B6859B2.F1E2C95B@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> george anzinger wrote:
> 
> > The testing I have done seems to indicate a lower overhead on a lightly
> > loaded system, about the same overhead with some load, and much more
> > overhead with a heavy load.  To me this seems like the wrong thing to
> 
> What about something that tries to get the best of both worlds?  How about a
> tickless system that has a max frequency for how often it will schedule?  This

How would you do this?  Larger time slices?  But _most_ context switches
are not related to end of slice.   Refuse to switch?  This just idles
the cpu.

> would give the tickless advantage for big iron running many lightly loaded
> virtual instances, but have some kind of cap on the overhead under heavy load.
> 
> Does this sound feasable?
> 
I don't think so.  The problem is that the test to see if the system
should use one or the other way of doing things would, it self, eat into
the overhead.

Note that we are talking about 0.12% over head for a ticked system.  Is
it really worth it for what amounts to less than 0.05% (if that much)?

George
