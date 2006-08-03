Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWHCQqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWHCQqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWHCQqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:46:40 -0400
Received: from xenotime.net ([66.160.160.81]:22948 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964853AbWHCQqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:46:38 -0400
Date: Thu, 3 Aug 2006 09:49:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Theodore Tso <tytso@mit.edu>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net, mchan@broadcom.com
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-Id: <20060803094917.8280f5ff.rdunlap@xenotime.net>
In-Reply-To: <20060803163204.GB20603@thunk.org>
References: <20060803075704.GC27835@thunk.org>
	<E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
	<20060803163204.GB20603@thunk.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 12:32:05 -0400 Theodore Tso wrote:

> On Thu, Aug 03, 2006 at 08:00:35PM +1000, Herbert Xu wrote:
> > Theodore Tso <tytso@mit.edu> wrote:
> > > 
> > > I'm sending this on mostly because it was a bit of a pain to track down,
> > > and hopefully it will save time if anyone else hits this while playing
> > > with the -rt kernel.  It is NOT the right way to fix things, so please
> > > don't even think of applying this patch (unless you need it, in your own
> > > local tree :-).
> > > 
> > > One of these days when we have time to breath we'll look into fixing
> > > this the right way, if someone doesn't beat us to it first.  :-)
> > 
> > You probably should resend the patch to netdev and Michael Chan
> > <mchan@broadcom.com>.  He might have ideas on how this could be
> > avoided.
> 
> This only shows up with the real-time kernel where timer softirq's run
> in their own processes, and a high priority process preempts the timer
> softirq.  I don't really consider this a networking bug, or even
> driver bug, although it does seem unfortunate that Broadcom hardware
> locks up and goes unresponsive if the OS doesn't tickle it every tenth
> of a second or so.  (Definitely a bad idea if the tg3 gets used on any
> laptops, from a power usage perspective.)  But that seems like a
> (lame) hardware bug, not a driver bug....

Interesting.  On my Dell D610 notebook with tg3 and vpn,
I have to ping a server on the vpn to keep it alive, otherwise
it disappears soon and I have to restart the vpn.  Of course,
this could just be the vpn or some other software problem
instead of a tg3 problem.

---
~Randy
