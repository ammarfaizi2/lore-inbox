Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbSJAD4w>; Mon, 30 Sep 2002 23:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbSJAD4w>; Mon, 30 Sep 2002 23:56:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30627 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261473AbSJAD4v>; Mon, 30 Sep 2002 23:56:51 -0400
Date: Tue, 1 Oct 2002 09:43:58 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39-mm1
Message-ID: <20021001094358.E13877@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <3D9804E1.76C9D4AE@digeo.com> <3D9896F6.8E584DC5@digeo.com> <200210010346.g913ktfP148022@northrelay01.pok.ibm.com> <3D991BD4.1191F6C6@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D991BD4.1191F6C6@digeo.com>; from akpm@digeo.com on Mon, Sep 30, 2002 at 08:51:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 08:51:48PM -0700, Andrew Morton wrote:
> Maneesh Soni wrote:
> > 
> > On Mon, 30 Sep 2002 23:55:50 +0530, Andrew Morton wrote:
> > 
> > > "Martin J. Bligh" wrote:
> > >>
> > >> Which looks about the same to me? Me slightly confused.
> > >
> > > I expect that with the node-local allocations you're not getting a lot
> > > of benefit from the lock amortisation.  Anton will.
> > >
> > > It's the lack of improvement of cache-niceness which is irksome. Perhaps
> > > the heuristic should be based on recency-of-allocation and not
> > > recency-of-freeing.  I'll play with that.
> > >
> > >> Will try
> > >> adding the original hot/cold stuff onto 39-mm1 if you like?
> > >
> > > Well, it's all in the noise floor, isn't it?  Better off trying broader
> > > tests.  I had a play with netperf and the chatroom benchmark.  But the
> > > latter varied from 80,000 msgs/sec up to 350,000 between runs. --
> > 
> > Hello Andrew,
> > 
> > chatroom benchmark gives more consistent results with some delay
> > (sleep 60) between two runs.
> > 
> 
> oh.  Thanks.  Why?

Could be because of sockets not getting closed immediately. I see them in 
TIME_WAIT state right after the run.

Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
