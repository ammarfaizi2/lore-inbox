Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310382AbSCEGeq>; Tue, 5 Mar 2002 01:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310417AbSCEGee>; Tue, 5 Mar 2002 01:34:34 -0500
Received: from zok.SGI.COM ([204.94.215.101]:62886 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S310382AbSCEGeU>;
	Tue, 5 Mar 2002 01:34:20 -0500
Date: Mon, 4 Mar 2002 22:33:47 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Matt Dobson <colpatch@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <795229669.1015278464@[10.10.2.3]>
Message-ID: <Pine.LNX.4.33.0203042221150.12307-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Martin J. Bligh wrote:

> > SGI's CpuMemSets is supposed to do that as well. We are now able to bind a
> > process to a set of memories, and soon we will be able to specify how
> > strict the allocation can be. Right now, if a process is allowed to
> > allocate memory from node 0, 2, and 3, it won't look outside of this set.
> > The memory set granularity is smaller though, because it depends on the
> > process, and the cpu (and thus the node) this process is running on.
> > The CpuMemSets have been tested and are available on the Linux Scalability
> > Effort sourceforge page, if you want to give it a try...
>
> The problem with CpuMemSets is that it's mind-bogglingly
> complex - I think we need something simpler ... at least
> to start with.
Yes, I agree with the fact that it is complex. Right now, you need
to get a good understanding of them in order for them to be useful.
However I think this is the price to pay for something that covers a large
range of cases, from the simplest one to very complex ones. The simpler
implementation you are talking about will be useless as soon as you'll
need to cover more complex cases.
A good thing would be to define an API on top of CpuMemSets to allow
interested people to use them quickly for those simple cases.

Samuel.



