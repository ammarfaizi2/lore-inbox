Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272369AbRHYAg4>; Fri, 24 Aug 2001 20:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272368AbRHYAgl>; Fri, 24 Aug 2001 20:36:41 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54283 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272365AbRHYAgT>; Fri, 24 Aug 2001 20:36:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sat, 25 Aug 2001 02:42:54 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <Pine.LNX.4.33L.0108242007570.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108242007570.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825003625Z16138-32384+493@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 01:10 am, Rik van Riel wrote:
> On Sat, 25 Aug 2001, Daniel Phillips wrote:
> > On August 24, 2001 09:02 pm, Rik van Riel wrote:
> 
> > > I guess in the long run we should have automatic collapse
> > > of the readahead window when we find that readahead window
> > > thrashing is going on,
> >
> > Yes, and the most effective way to detect that the readahead
> > window is too high is by keeping a history of recently evicted
> > pages.
> 
> I think it could be even easier. We simply count for each
> file how many pages we read-ahead and how many pages we
> read.
> 
> If the number of pages being read-ahead is really a lot
> higher than the pages being read, we know pages get evicted
> before we read them ==> we shrink the readahead window.
> 
> This simpler scheme should also be able to correctly set
> the readahead window for slower data streams to smaller
> than the readahead window size for faster reading data
> streams (which _do_ get to use more of their data before
> it is evicted again).

Yes, this is a good method.

--
Daniel
