Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282654AbRLFTl6>; Thu, 6 Dec 2001 14:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282668AbRLFTls>; Thu, 6 Dec 2001 14:41:48 -0500
Received: from dsl-213-023-038-110.arcor-ip.net ([213.23.38.110]:49669 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282654AbRLFTle>;
	Thu, 6 Dec 2001 14:41:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: SMP/cc Cluster description
Date: Thu, 6 Dec 2001 20:42:05 +0100
X-Mailer: KMail [version 1.3.2]
Cc: davidel@xmailserver.org, rusty@rustcorp.com.au, lm@bitmover.com,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011206135224.12c4b123.rusty@rustcorp.com.au> <20011205.235617.23011309.davem@redhat.com> <20011206000216.B18034@work.bitmover.com>
In-Reply-To: <20011206000216.B18034@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16C4PM-0000qu-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 6, 2001 09:02 am, Larry McVoy wrote:
> On Wed, Dec 05, 2001 at 11:56:17PM -0800, David S. Miller wrote:
> > These lockless algorithms, instructions like CAS, DCAS, "infinite
> > consensus number", it's all crap.  You have to seperate out the access
> > areas amongst different cpus so they don't collide, and none of these
> > mechanisms do that.
> 
> Err, Dave, that's *exactly* the point of the ccCluster stuff.  You get
> all that seperation for every data structure for free.  Think about
> it a bit.  Aren't you going to feel a little bit stupid if you do all
> this work, one object at a time, and someone can come along and do the
> whole OS in one swoop?  Yeah, I'm spouting crap, it isn't that easy,
> but it is much easier than the route you are taking.  

What I don't get after looking at your material, is how you intend to do the 
locking.  Sharing a mmap across OS instances is fine, but how do processes on 
the two different OS's avoid stepping on each other when they access the same 
file?

--
Daniel
