Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbRA2Xsd>; Mon, 29 Jan 2001 18:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131249AbRA2XsX>; Mon, 29 Jan 2001 18:48:23 -0500
Received: from phoenix.nanospace.com ([209.213.199.19]:267 "HELO
	phoenix.nanospace.com") by vger.kernel.org with SMTP
	id <S130599AbRA2XsH>; Mon, 29 Jan 2001 18:48:07 -0500
Date: Mon, 29 Jan 2001 15:45:22 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
Message-ID: <20010129154521.J17481@thune.yy.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com> <Pine.LNX.4.10.10101291452120.31258-100000@clueserver.org> <20010129152335.H11411@draco.foogod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <20010129152335.H11411@draco.foogod.com>; from alex@foogod.com on Mon, Jan 29, 2001 at 03:23:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 03:23:35PM -0800, alex@foogod.com wrote:
> On Mon, Jan 29, 2001 at 02:57:44PM -0800, Alan Olsen wrote:
> > The standard rule is usually memory x 2.  (But that is more a Solaris
> > superstition than anything else.)
> 
> This always struck me as the most stupid rule of thumb I'd ever heard of.  
> With this metric, systems which precisely need swap the most (low-RAM systems) 
> get the least of it, and those that need it the least (those with gigs of RAM) 
> get tons of swap they don't need.  I don't know how this keeps perpetuating, 
> as it should be plainly brain damaged to anybody who thinks about it for a 
> couple of seconds, but somehow it does.

Because it used to be necessary.

Early VM systems *required* at least one page of swap for every page of
physical ram.  In theory, the entire contents of physical ram would be
copied at any time onto swap, and whenever it was necessary to free up a
page to bring in a new one, it would already be on backing store and could
easily be freed up.

This was prior to things like being able to page in binaries from file
systems on demand, so your programs had to be swapped back out as well.

So, basically, your totally usable paging area was the sum of swap space.
Not the sum of swap space + physical memory.

Now, granted, this is no longer the case for most (all?) VM based systems,
the rule of thumb has such strong momentum behind it that it's difficult to
stop.
 
 
Now, personally, I tend to throw on a few meg of swap onto each disk and
stripe swap across them for performance.  If I find I ever run out of
memory under normal use, I'll up it.  But I've never had that happen.  Swap
space depends on how you use it.  Set up some stuff, and monitor with free
every once in a while.  If you never hit swap, then reduce it or eliminate
it.  If you are constantly running over 1/3 of it or so, might consider
upping it a little bit.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
