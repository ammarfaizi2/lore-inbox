Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270130AbRHGHv2>; Tue, 7 Aug 2001 03:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270134AbRHGHvU>; Tue, 7 Aug 2001 03:51:20 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:54418 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S270130AbRHGHvO>;
	Tue, 7 Aug 2001 03:51:14 -0400
Date: Tue, 7 Aug 2001 09:51:12 +0200
From: David Weinehall <tao@acc.umu.se>
To: Jeremy Linton <jlinton@interactivesi.com>
Cc: Stephen Satchell <satch@fluent-access.com>, linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
Message-ID: <20010807095112.Q6387@khan.acc.umu.se>
In-Reply-To: <007801c11c67$87d55980$b6562341@cfl.rr.com> <4.3.2.7.2.20010803225855.00bc2a60@mail.fluent-access.com> <02a101c11e96$45db1d40$bef7020a@mammon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <02a101c11e96$45db1d40$bef7020a@mammon>; from jlinton@interactivesi.com on Mon, Aug 06, 2001 at 11:37:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 11:37:53AM -0500, Jeremy Linton wrote:
> From: "Stephen Satchell" <satch@fluent-access.com>
> > At 07:08 PM 8/3/01 -0300, you wrote:
> > >On Fri, 3 Aug 2001, Mike Black wrote:
> > >
> > > > Couldn't kswapd just gracefully back-off when it doesn't make any
> > > > progress? In my case (with ext3/raid5 and a tiobench test) kswapd
> > > > NEVER actually swaps anything out. It just chews CPU time.
> > >
> > > > So...if kswapd just said "didn't make any progress...*2 last sleep" so
> > > > it would degrade itself.
> > >
> > >It wouldn't just degrade itself.
> > >
> > >It would also prevent other programs in the system
> > >from allocating memory, effectively halting anybody
> > >wanting to allocate memory.
> Big snip...
> 
> > To the rest of the kernel list:  apologies for taking up so much space
> with
> > a userland issue.  The thing is, in the months I've seen the VM problem
> > discussed, and the "zillionth person to complain about it," I haven't seen
> > any pointer to any discussion about how userland programs can insulate
> > themselves from being killed when they try to use up too much
> > RAM.  Commercial quality programs, and programs wanting to use as much of
> > the resources as possible to minimize run times, need to monitor what they
> > are doing to the system and pull back when they tread toward suicide.
> >
> > Put another way, people should NOT use safety nets as the only means of
> > breaking a fall.
>     AIX, also allows something similar to linux's over commit. Right before
> its OOM killer fires it sends the target process(es) a non standard signal
> (can't remember what its called) which indicates that if the process
> continues to allocate memory it runs the risk of being killed.

SIGDANGER

> I'm not advocating this idea, only presenting it as a solution other people
> have implemented to work around broken VM issues.

I consider SIGDANGER to work very well.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
