Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271318AbRHTPwk>; Mon, 20 Aug 2001 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271319AbRHTPwb>; Mon, 20 Aug 2001 11:52:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3319 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S271318AbRHTPwO>; Mon, 20 Aug 2001 11:52:14 -0400
Message-ID: <3B81321E.1081D49C@mvista.com>
Date: Mon, 20 Aug 2001 08:51:58 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chuckw@ieee.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Question on coding style in networking code
In-Reply-To: <20010819124442.G2388@ieee.org> <Pine.GSO.4.21.0108200046580.1313-100000@weyl.math.psu.edu> <20010819131131.I2388@ieee.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chuckw@ieee.org wrote:
> 
>         Thank you for the reply.
> 
>         I absolutely agree that it is much easier to read and figure out what is
> going on.  You don't have to keep going back to the struct declaration to
> find out what the fields are.
> 
> Thanks again,
> Chuck
> 
> On Mon, Aug 20, 2001 at 12:56:53AM -0400, Alexander Viro wrote:
> >
> >
> > On Sun, 19 Aug 2001 chuckw@ieee.org wrote:
> >
> > >     struct x y = {
> > >             member1: x,
> > >             member2: y,
> > >             member3: z
> > >     };
> > >
> > > What is the deal with this?  Does the second way have any advantage over the previous?
> >
> > _Much_ easier to grep for. Less pain in the ass when fields are added/removed/
> > reordered.
> >
> > For anything with many fields (usually method tables) it's more convenient.
> > And no, it's not just networking - filesystem-related code, etc. uses it
> > all over the place.
> >
For large structures it is a pure joy to work with.  Check out sched.h
and the "task_struct" where many of the fields come and go with "CONFIG"
options.

George
