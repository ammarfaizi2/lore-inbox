Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263341AbRFMTFR>; Wed, 13 Jun 2001 15:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263943AbRFMTFI>; Wed, 13 Jun 2001 15:05:08 -0400
Received: from [32.97.182.103] ([32.97.182.103]:24988 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263341AbRFMTEv>;
	Wed, 13 Jun 2001 15:04:51 -0400
Importance: Normal
Subject: Re: threading question
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF8B8E165A.F0F1217D-ON85256A6A.0068B1CA@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 13 Jun 2001 15:05:49 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 06/13/2001 03:04:14 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>I got that response too. When I pressed kernel people for details it turns
>out that they think having hundreds of runnable threads/processes (mostly
>the same thing under Linux) is wasteful. The scheduler is just not
optimised
>for that.

Try out the http://lse.sourceforge.net/scheduling  patches. The MQ kernel
scheduler sure can handle this
kind of load :-)

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



bert hubert <ahu@ds9a.nl>@vger.kernel.org on 06/13/2001 01:31:39 PM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   linux-kernel@vger.kernel.org
cc:
Subject:  Re: threading question



On Tue, Jun 12, 2001 at 12:06:40PM -0700, Kip Macy wrote:
> This may sound like flamebait, but its not. Linux threads are basically
> just processes that share the same address space. Their performance is
> measurably worse than it is on most commercial Unixes and FreeBSD.

Thread creation may be a bit slow. But the kludges to provide posix threads
completely from userspace also hurt. Notably, they do not scale over
multiple CPUs.

> They are not, or at least two years ago, were not POSIX compliant
> (they behaved badly with respect to signals). The impoverished

POSIX threads are silly with respect to signals. I do almost all my
programming these days with pthreads and I find that I really do not miss
signals at all.

> from Larry McVoy's home page attributed to Alan Cox illustrates this
> reasonably well: "A computer is a state machine. Threads are for people
> who can't program state machines." Sorry for not being more helpful.

I got that response too. When I pressed kernel people for details it turns
out that they think having hundreds of runnable threads/processes (mostly
the same thing under Linux) is wasteful. The scheduler is just not
optimised
for that.

Regards,

bert

--
http://www.PowerDNS.com      Versatile DNS Services
Trilab                       The Technology People
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



