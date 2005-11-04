Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbVKDQEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbVKDQEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbVKDQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:04:24 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:48477 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161159AbVKDQEX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:04:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r8Y6M8BsS/WPDXx0Lk17mhRJ0vk9VwFD/DMSeBsIm+SeHRK8j1P0PxQ/iEkibeeJPxf4mIbfk+We7zi8Gjz5mR3Ehqg9MBp8TeBV+0MM/4Hih21XLybDF/2E0JEqXaVJI/z9Q53X96MCVvdV/RM/XnrQERyT4Ts9/bCIrz6V3JQ=
Message-ID: <569d37b00511040804y7289d623ocd13dd86a9c22082@mail.gmail.com>
Date: Fri, 4 Nov 2005 11:04:21 -0500
From: Trevor Woerner <twoerner.k@gmail.com>
To: Carlos Antunes <cmantunes@gmail.com>
Subject: Re: latency report
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cb2ad8b50511040717k61bb560dsbe31a5c25f394bba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <569d37b00511032306y27519a8am69f2385fdbd4b81f@mail.gmail.com>
	 <cb2ad8b50511040717k61bb560dsbe31a5c25f394bba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Carlos Antunes <cmantunes@gmail.com> wrote:
> rt2 was seriously screwed up (I posted about the problems in here).
> rt3 solved the problems. You might want to repeat your testing with at
> least rt3.

-rt3 lasted for all of, what, 30 minutes before -rt4 came out? :-)

I tested -rt5 last night and still have problems. I'm trying out -rt6
now. I was trying to isolate the problem but I haven't had any luck
yet.

If I boot a machine with 2.6.14-rt5 running either preemption k3 or
k4, simply running my "dolots.sh" script (which uses my "drone"
program, both of which are in the project package) will cause an OOM
problem after about 15 minutes or so. Running preemption setting k1
all night I found it was still happily running (and quite responsive
even with a loadavg of ~70) this morning.

Increasing the load to upwards to a loadavg of 200 with 2.6.14-rt5 k1
doesn't seem to have any problems.

I was anxious to get my results "out there" and since -rt5 was still
showing problems I decided to publish with -rt2 anyway (since most of
that work was already done). I made a note of the problems I
experience with these two settings in the report.
