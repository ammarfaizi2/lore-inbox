Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSJADqc>; Mon, 30 Sep 2002 23:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbSJADqc>; Mon, 30 Sep 2002 23:46:32 -0400
Received: from packet.digeo.com ([12.110.80.53]:64717 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261472AbSJADqb>;
	Mon, 30 Sep 2002 23:46:31 -0400
Message-ID: <3D991BD4.1191F6C6@digeo.com>
Date: Mon, 30 Sep 2002 20:51:48 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: maneesh@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39-mm1
References: <3D9804E1.76C9D4AE@digeo.com> <3D9896F6.8E584DC5@digeo.com> <200210010346.g913ktfP148022@northrelay01.pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 03:51:51.0744 (UTC) FILETIME=[E035EC00:01C268FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:
> 
> On Mon, 30 Sep 2002 23:55:50 +0530, Andrew Morton wrote:
> 
> > "Martin J. Bligh" wrote:
> >>
> >> Which looks about the same to me? Me slightly confused.
> >
> > I expect that with the node-local allocations you're not getting a lot
> > of benefit from the lock amortisation.  Anton will.
> >
> > It's the lack of improvement of cache-niceness which is irksome. Perhaps
> > the heuristic should be based on recency-of-allocation and not
> > recency-of-freeing.  I'll play with that.
> >
> >> Will try
> >> adding the original hot/cold stuff onto 39-mm1 if you like?
> >
> > Well, it's all in the noise floor, isn't it?  Better off trying broader
> > tests.  I had a play with netperf and the chatroom benchmark.  But the
> > latter varied from 80,000 msgs/sec up to 350,000 between runs. --
> 
> Hello Andrew,
> 
> chatroom benchmark gives more consistent results with some delay
> (sleep 60) between two runs.
> 

oh.  Thanks.  Why?
