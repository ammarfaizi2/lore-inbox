Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282705AbRLFTyA>; Thu, 6 Dec 2001 14:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282702AbRLFTxv>; Thu, 6 Dec 2001 14:53:51 -0500
Received: from bitmover.com ([192.132.92.2]:50050 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S282705AbRLFTxk>;
	Thu, 6 Dec 2001 14:53:40 -0500
Date: Thu, 6 Dec 2001 11:53:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
        davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206115338.E27589@work.bitmover.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
	davidel@xmailserver.org, rusty@rustcorp.com.au,
	Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
	lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206135224.12c4b123.rusty@rustcorp.com.au> <20011205.235617.23011309.davem@redhat.com> <20011206000216.B18034@work.bitmover.com> <E16C4PM-0000qu-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16C4PM-0000qu-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Dec 06, 2001 at 08:42:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 08:42:05PM +0100, Daniel Phillips wrote:
> On December 6, 2001 09:02 am, Larry McVoy wrote:
> > On Wed, Dec 05, 2001 at 11:56:17PM -0800, David S. Miller wrote:
> > > These lockless algorithms, instructions like CAS, DCAS, "infinite
> > > consensus number", it's all crap.  You have to seperate out the access
> > > areas amongst different cpus so they don't collide, and none of these
> > > mechanisms do that.
> > 
> > Err, Dave, that's *exactly* the point of the ccCluster stuff.  You get
> > all that seperation for every data structure for free.  Think about
> > it a bit.  Aren't you going to feel a little bit stupid if you do all
> > this work, one object at a time, and someone can come along and do the
> > whole OS in one swoop?  Yeah, I'm spouting crap, it isn't that easy,
> > but it is much easier than the route you are taking.  
> 
> What I don't get after looking at your material, is how you intend to do the 
> locking.  Sharing a mmap across OS instances is fine, but how do processes on 
> the two different OS's avoid stepping on each other when they access the same 
> file?

Exactly the same way they would if they were two processes on a traditional
SMP OS.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
