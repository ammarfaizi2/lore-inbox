Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135792AbRDYDJa>; Tue, 24 Apr 2001 23:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135793AbRDYDJK>; Tue, 24 Apr 2001 23:09:10 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:24563 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135792AbRDYDJG>; Tue, 24 Apr 2001 23:09:06 -0400
Message-ID: <3AE63E5C.678E1329@uow.edu.au>
Date: Tue, 24 Apr 2001 20:02:52 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Event tools, do they exist
In-Reply-To: <3AE61FF2.DF9849BB@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> This is an attempt to look in the wheel locker.
> 
> I need a simple event sub system for use in the kernel.  I envision at
> least two types of events: the history event and the timing event.
> 
> The timing event would keep track of start/stop times by class.  If, for
> example, I wanted to know how much time the kernel spends doing the
> recalc in schedule() I would put and event start in front of it and an
> end at the other end.  The sub system would note the first event time
> and the cumulative time between all starts and stops on the same event.
> When reported by /proc/ it would give the total event time, the elapsed
> time and the % of processor time for each of the possibly several
> classes.

http://www.uow.edu.au/~andrewm/linux/#timepegs  (The patch
against 2.4.1-pre10 still applies!)

> The history event would record each events time, location, data1,
> data2.  It would keep N of these (the last N) and report M (M=<N) via
> /proc/.  This list should also be kept in a format that a simple
> debugger can easily examine.

Linux Trace Toolkit may be able to do this.

-
