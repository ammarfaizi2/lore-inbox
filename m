Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135952AbREIJmi>; Wed, 9 May 2001 05:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135959AbREIJm3>; Wed, 9 May 2001 05:42:29 -0400
Received: from oxmail2.ox.ac.uk ([163.1.2.1]:7417 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S135952AbREIJmS>;
	Wed, 9 May 2001 05:42:18 -0400
Date: Wed, 9 May 2001 10:42:02 +0100
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Marty Leisner <leisner@rochester.rr.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
Message-ID: <20010509104201.B5475@sable.ox.ac.uk>
In-Reply-To: <lm@bitmover.com> <200105090424.AAA05768@soyata.home> <20010508222210.B14758@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010508222210.B14758@work.bitmover.com>; from lm@bitmover.com on Tue, May 08, 2001 at 10:22:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:
> On Wed, May 09, 2001 at 12:24:25AM -0400, Marty Leisner wrote:
> > My understanding is suns big machines stopped using ecc and they
> 
> The SUN problem was a cache problem and there is no way that I believe
> that SUN would turn of ECC in the cache.  There are good reasons for
> not doing so.  If you think through the end to end argument, you will
> see that you have no way to do checks on the data path into/out of the
> processor.  If that part of the datapath is not checked then no amount
> of checking elsewhere does any good, the processor can be corrupting
> your data and never know it.  If SUN was so stupid as to remove this,
> then it is a dramatically different place.  I heard that there was a
> bug in the cache controller, I never heard that they had removed ECC.

There are issues with error detection/correction/recovery with
different designs of L1 and L2 caches. There's a good paper:

    IBM S/390 storage hierarchy - G5 and G6 performance considerations
    IBM Journal of Research and Development
    Vol 43 No. 5/6
available at
    http://www.research.ibm.com/journal/rd/435/jackson.html

which covers IBM's choice of L1 and L2 design for S/390. The section on
"S/390 reliability and performance implications" is relevant here. In
particular, they use a solution which isn't best from the performance
point of view but ensures you don't discover "too late" about an error.
I heard a rumour (now I get to the unsubstantiated part :-) that Sun
chose a higher-performing design for their cache subsystem but which has
a nastier failure mode in the case of cache errors.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
