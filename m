Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280960AbRLIBJz>; Sat, 8 Dec 2001 20:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRLIBJh>; Sat, 8 Dec 2001 20:09:37 -0500
Received: from web10001.mail.yahoo.com ([216.136.130.37]:16472 "HELO
	web10001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280970AbRLIBJe>; Sat, 8 Dec 2001 20:09:34 -0500
Message-ID: <20011209010933.64484.qmail@web10001.mail.yahoo.com>
Date: Sun, 9 Dec 2001 01:09:33 +0000 (GMT)
From: "=?iso-8859-1?q?Quim=20K.=20Holland?=" <qkholland@yahoo.com>
Subject: Required Swap for recent 2.4 kernels?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that in early days of 2.4.x, the total
usable VM used to be not close to sum of the
physical RAM and swap.  Is this still true for
post 2.4.10 kernels?

Back in January 2001, in response to a question
about ``recommended swap for 2.4.x'', Rik van Riel
answered (quotes '>' are from the messagey by
alex@foogod.com):

   It has. We now leave dirty pages swapcached,
   which means that for certain workloads Linux
   2.4 eats up much more swap space than Linux
   2.2.

   On the other hand, if you almost never used
   swap under Linux 2.2, you probably won't be
   using it under 2.4 either.

   > 2) Subtract the amount of RAM you have
   >    (believe it or not, the more RAM you have,
   >    the less swap you need.  Imagine that).

   For Linux 2.4, it may be better to substract a
   bit less, because of the issue above.

   If you have a very swap-intensive workload, you
   may end up with 90% of your memory being
   "duplicated" in swap, in which case this rule
   doesn't work.

My understanding is that this answer is not
applicable to post 2.4.10 kernels, but if so then
would the total usable VM be <physical RAM> +
<swap> - <kernel itself> - <kernel overhead that
is not proportional to the VM workload>?


________________________________________________________________
Nokia 5510 looks weird sounds great. 
Go to http://uk.promotions.yahoo.com/nokia/ discover and win it! 
The competition ends 16 th of December 2001.
