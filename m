Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278197AbRJWTaY>; Tue, 23 Oct 2001 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278203AbRJWTaO>; Tue, 23 Oct 2001 15:30:14 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:28881 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S278197AbRJWTaF>; Tue, 23 Oct 2001 15:30:05 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: time tells all about kernel VM's
In-Reply-To: <3BD51F02.92B9B7F3@idb.hist.no>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <uzjB7.3848$MX4.655317120@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1003865434 000 192.168.192.240 (Tue, 23 Oct 2001 15:30:34 EDT)
NNTP-Posting-Date: Tue, 23 Oct 2001 15:30:34 EDT
Date: Tue, 23 Oct 2001 19:30:34 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BD51F02.92B9B7F3@idb.hist.no>,
Helge Hafting <helgehaf@idb.hist.no> wrote:

| Any VM with paging _can_ be forced into a trashing situation where
| a keypress takes hours to process.  A better VM will take more pressure
| before it gets there and performance will degrade more gradually.
| But any VM can get into this situation.

So far I agree, and that implies that the VM needs to identify and
correct the situation.

| Swapping out whole processes can help this, but it will merely
| move the point where you get stuck.  A load control system that
| kills processes when response is too slow is possible, but
| the problem here is that you can't get people to agree
| on how bad is too bad.  It is sometimes ok to leave the machine 
| alone crunching a big problem over the weekend.  And sometimes
| you _need_ response much faster.
| 
| And what app to kill in such a situation?
| You had a single memory pig, but it aint necessarily so.

I think the problem is not killing the wrong thing, but not killing
anything... We can argue any old factors for selection, but I would
first argue that the real problem is that nothing was killed because the
problem was not noticed.

One possible way to recognize the problem is to identify the ratio of
page faults to time slice used and assume there is trouble in River City
if that gets high and stays high. I leave it to the VM gurus to define
"high," but processes which continually block for page fault as opposed
to i/o of some kind are an indication of problems, and likely to be a
factor in deciding what to kill.

I think it gives a fair indication of getting things done or not, and I
have said before I like per-process page fault rates as a datam to be
included in VM decisions.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
