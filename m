Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbSJVRQj>; Tue, 22 Oct 2002 13:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264777AbSJVRQj>; Tue, 22 Oct 2002 13:16:39 -0400
Received: from netrealtor.ca ([216.209.85.42]:14852 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261755AbSJVRQi>;
	Tue, 22 Oct 2002 13:16:38 -0400
Date: Tue, 22 Oct 2002 13:22:44 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "Charles 'Buck' Krasic" <krasic@acm.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021022172244.GA1314@mark.mielke.cc>
References: <20021018185528.GC13876@mark.mielke.cc> <Pine.LNX.4.44.0210181209510.1537-100000@blue1.dev.mcafeelabs.com> <20021019065624.GA17553@mark.mielke.cc> <xu4y98utnn7.fsf@brittany.cse.ogi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xu4y98utnn7.fsf@brittany.cse.ogi.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 09:10:52AM -0700, Charles 'Buck' Krasic wrote:
> Mark Mielke <mark@mark.mielke.cc> writes:
> > They still represent an excessive complicated model that attempts to
> > implement /dev/epoll the same way that one would implement poll()/select().
> epoll is about fixing one aspect of an otherwise well established api.
> That is, fixing the scalability of poll()/select() for applications
> based on non-blocking sockets.

epoll is not a poll()/select() enhancement (unless it is used in
conjuction with poll()/select()). It is a poll()/select()
replacement.

Meaning... purposefully creating an API that is designed the way one
would design a poll()/select() loop is purposefully limiting the benefits
of /dev/epoll.

It's like inventing a power drill to replace the common screw driver,
but rather than plugging the power drill in, manually turning the
drill as if it was a socket wrench for the drill bit.

I find it an excercise in self defeat... except that /dev/epoll used the
same way one would use poll()/select() happens to perform better even
when it is crippled.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

