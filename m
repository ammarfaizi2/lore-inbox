Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312914AbSCZBlV>; Mon, 25 Mar 2002 20:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSCZBlM>; Mon, 25 Mar 2002 20:41:12 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4591
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312914AbSCZBk7>; Mon, 25 Mar 2002 20:40:59 -0500
Date: Mon, 25 Mar 2002 17:42:19 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020326014219.GA3536@matchmail.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	jmerkey@timpanogas.org
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com> <20020320152008.A19978@vger.timpanogas.org> <20020320152504.B19978@vger.timpanogas.org> <3C9935CA.38E6F56F@zip.com.au> <20020320234552.A21740@vger.timpanogas.org> <20020325181645.A17171@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 06:16:45PM -0700, Jeff V. Merkey wrote:
> > > The elevator starvation change went into 2.4.19-pre1 I think.
> > > It shouldn't affect the problem which you've described - that
> > > change improved the situation where tasks were sleeping for
> > > long periods when they want to insert new requests.  But the
> > > problem which you're observing appears to affect already-inserted
> > > requests.
> > > 
> > > "Several minutes" is downright odd.  From your description
> > > it seems that all the requests are writes, but some of the
> > > writes (at a remote end of the disk) are being bypassed far
> > > too many times.
> > > 
> > > The bypass count _is_ tunable.  Although it sounds like the logic
> > > has come unstuck in some manner, it would be interesting if
> > > changing the elevator latency parameters for that queue affected
> > > the situation.
> > > 
> > > Have you experimented with `elvtune -r NNN /dev/foo' and
> > > `elvtune -w NNN /dev/foo'?
> > 
> > No, but I will test this tonight.  I am in tonight working on 
> > this problem until I run it down.
> > 
> > Jeff
> > 
> 
> 
> Andrew,
> 
> I have been running a test run against 2.4.19-pre4 (and later) for 
> over a week non-stop and the elevator problem appears to have been 
> corrected by this fix.  I will update further if the problem 
> resurfaces.
>

That's good news.

Are you still working on the A/B list patch?  I'd imagine that it could make
several problems easier to fix in the block layer.

> :-)
>

:)
