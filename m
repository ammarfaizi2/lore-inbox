Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262983AbTCLCqn>; Tue, 11 Mar 2003 21:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262987AbTCLCqn>; Tue, 11 Mar 2003 21:46:43 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:25274 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S262983AbTCLCqm>; Tue, 11 Mar 2003 21:46:42 -0500
Message-ID: <3E6EA224.EA0C3925@attbi.com>
Date: Tue, 11 Mar 2003 21:57:40 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.64bk4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: johnstul@us.ibm.com
CC: george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I like the idea of making the monotonic clock use the same
mechanism as the normal timeofday clock.

When I was doing my alternative Posix timers patch, I modified
your get_offset() mechanism to return nanoseconds and added a
"struct time_spec ytime" which was updated in the same place as
xtime but was never set.

You might have a look at my patch archived here:
  http://marc.theaimsgroup.com/?l=linux-kernel&m=104006731324824&w=2

Look for the function do_gettime_sinceboot_ns().  You don't have to 
keep the monotonic time in cycles.  It
would be nice if the timeofday clock was defined as the monotonic
clock + an offset.

Also, if I had one of those cyclone counters, I would never look at
the PIT again.

Jim Houston - Concurrent Computer Corp.
