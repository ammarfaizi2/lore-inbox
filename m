Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269154AbRHHUA4>; Wed, 8 Aug 2001 16:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269018AbRHHUAq>; Wed, 8 Aug 2001 16:00:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22675 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269115AbRHHUAa>;
	Wed, 8 Aug 2001 16:00:30 -0400
Importance: Normal
Subject: Re: [RFC][PATCH] Scalable Scheduling
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFF2ABD376.4C6290F7-ON85256AA2.006DAFE3@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 8 Aug 2001 16:02:12 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/08/2001 04:00:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Obviously not. Take a look at the presentation from Ottawa Linux Symposium.
We ran this on 2-way for various applications from kernel builds to TPC-H
apps
and it actually slightly improved performance.
It has detailed overviews of lock contention and wait times.

start at http://lse.sourceforge.net/scheduling/ols2001/img41.htm if you are
lazy, but
the MQ description really is a good overview and describes some of the data
structures

At 2-ways we see it at worst to be a wash for the benchmarks we used.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Victor Yodaiken <yodaiken@fsmlabs.com> on 08/08/2001 03:51:43 PM

To:   Hubertus Franke/Watson/IBM@IBMUS
cc:   Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject:  Re: [RFC][PATCH] Scalable Scheduling



On Wed, Aug 08, 2001 at 03:40:00PM -0400, Hubertus Franke wrote:
>
> We did not modify the UP code at all. There will be NO effects (positive
> nor negative) what so ever.

Cool. So the obvious next question is
     How does it compare on a dual to the current Linux scheduler?

Obviously:
     Performance sucks on two processors but scales well

would not be a good thing.


>
> Hubertus Franke
> Enterprise Linux Group (Mgr),  Linux Technology Center (Member
Scalability)
> , OS-PIC (Chair)
> email: frankeh@us.ibm.com
> (w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003
>
>
>
> Victor Yodaiken <yodaiken@fsmlabs.com> on 08/08/2001 03:27:55 PM
>
> To:   Mike Kravetz <mkravetz@sequent.com>
> cc:   Linus Torvalds <torvalds@transmeta.com>, Hubertus
>       Franke/Watson/IBM@IBMUS, linux-kernel@vger.kernel.org
> Subject:  Re: [RFC][PATCH] Scalable Scheduling
>
>
>
> On Wed, Aug 08, 2001 at 11:28:00AM -0700, Mike Kravetz wrote:
> > One challenge will be maintaining the same level of performance
> > for UP as in the current code.  The current code has #ifdefs to
>
> How does the "current code" compare to the current Linux UP code?
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



