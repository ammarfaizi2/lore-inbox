Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312918AbSCZB4X>; Mon, 25 Mar 2002 20:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312923AbSCZB4Q>; Mon, 25 Mar 2002 20:56:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38895
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312918AbSCZB4I>; Mon, 25 Mar 2002 20:56:08 -0500
Date: Mon, 25 Mar 2002 17:57:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020326015745.GB3536@matchmail.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com> <20020320152008.A19978@vger.timpanogas.org> <20020320152504.B19978@vger.timpanogas.org> <3C9935CA.38E6F56F@zip.com.au> <20020320234552.A21740@vger.timpanogas.org> <20020325181645.A17171@vger.timpanogas.org> <20020325174555.A3252@greenhydrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 05:45:55PM -0800, David Rees wrote:
> On Mon, Mar 25, 2002 at 06:16:45PM -0700, Jeff V. Merkey wrote:
> > > > The elevator starvation change went into 2.4.19-pre1 I think.
> > > > It shouldn't affect the problem which you've described - that
> > > > change improved the situation where tasks were sleeping for
> > > > long periods when they want to insert new requests.  But the
> > > > problem which you're observing appears to affect already-inserted
> > > > requests.
> > > > 
> > > > "Several minutes" is downright odd.  From your description
> > > > it seems that all the requests are writes, but some of the
> > > > writes (at a remote end of the disk) are being bypassed far
> > > > too many times.
> > > > 
> > > > The bypass count _is_ tunable.  Although it sounds like the logic
> > > > has come unstuck in some manner, it would be interesting if
> > > > changing the elevator latency parameters for that queue affected
> > > > the situation.
> > > > 
> > > > Have you experimented with `elvtune -r NNN /dev/foo' and
> > > > `elvtune -w NNN /dev/foo'?
> > > 
> > > No, but I will test this tonight.  I am in tonight working on 
> > > this problem until I run it down.
> > 
> > I have been running a test run against 2.4.19-pre4 (and later) for 
> > over a week non-stop and the elevator problem appears to have been 
> > corrected by this fix.  I will update further if the problem 
> > resurfaces.
> 
> Jeff,
> 
> Did upgrading to 2.4.19-pre4 by itself fix your problems, or did you need to
> tweak with elvtune as well?  If so, what values did you find produced
> optimal results?
> 

I'd doubt that Jeff's optimal (magic) elvtune numbers would be much use to
other people, as elvtune should be set for each particular workload.

Now, if we had a small guide that said "these value ranges/combinations have
worked best for $this workload" that would be quite helpful...
