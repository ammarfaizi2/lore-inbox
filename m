Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRA3CuD>; Mon, 29 Jan 2001 21:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRA3Ctn>; Mon, 29 Jan 2001 21:49:43 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:61110 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S129306AbRA3Ctc>;
	Mon, 29 Jan 2001 21:49:32 -0500
Date: Mon, 29 Jan 2001 21:48:40 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.LNX.4.30.0101291621120.31713-100000@age.cs.columbia.edu>
Message-ID: <Pine.GSO.4.30.0101292139170.29307-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Ion Badulescu wrote:

> 11.5kBps, quite consistently.

This gige card is really sick. Are you sure? Please double check.

>
> I've tried it, but I'm not really sure what I can report. ttcp's
> measurements are clearly misleading, so I used Andrew's cyclesoak instead.

The ttcp CPU (times()) measurements are misleading. In particular when
doing sendfile. All they say is how much time ttcp spent in kernel space
vs user space. So all CPU measurement i have posted in the past
should be considered bogus. It is interesting to note, however, that
the trend reported by ttcp's CPU measurements as well as Andrew (and
yourself) are similar;->
But the point is: CPU is not the only measure that is of interest.
Throughput is definetly one of those that is of extreme importance.
100Mbps is not exciting. You seem to have gigE. I think your 11KB looks
suspiciously wrong. Can you double check please?

cheers,
jamal

PS:- another important parameter is latency, but that might not be as
important in file serving (maybe in short file tranfers ala http).


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
