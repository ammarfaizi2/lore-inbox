Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313447AbSDPB15>; Mon, 15 Apr 2002 21:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313451AbSDPB14>; Mon, 15 Apr 2002 21:27:56 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16637
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313447AbSDPB14>; Mon, 15 Apr 2002 21:27:56 -0400
Date: Mon, 15 Apr 2002 18:30:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020416013016.GA23513@matchmail.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com> <Pine.LNX.4.33.0204151415110.15353-100000@penguin.transmeta.com> <20020415232058.GO21206@holomorphy.com> <20020416024458.H26561@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 02:44:58AM +0200, Andrea Arcangeli wrote:
> On Mon, Apr 15, 2002 at 04:20:58PM -0700, William Lee Irwin III wrote:
> > I won't scream too loud, but I think it's pretty much done right as is.
> 
> Regardless if that's the cleaner implementation or not, I don't see much
> the point of merging those cleanups in 2.4 right now: it won't make any
> functional difference to users and it's only a self contained code
> cleanup, while other patches that make a runtime difference aren't
> merged yet.
> 

One set (1 of 3) of you vm patches have already gone into 2.4.19-pre and
IMHO, each set should go into a major release seperately (2.4.19/20/21).
There are so many more people who use the released versions than the -pre
versions of the kernel.

No matter how much someone can go through their own code and say "it's
ready" there's always a good chance there is some bug that will trigger
under testing.  Also, Andrew found a problem with your locking changes when
he split up your patch, and at the time you were saying it is ready and
there were no bug reports against in...

Now I doubt that there is anything to worry about, we are talking about a
stable kernel series here.

Does this patch conflict in any way with your vm patches?  If not they
should be able to co-exist.
