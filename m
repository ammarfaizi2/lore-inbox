Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284456AbRLEPDR>; Wed, 5 Dec 2001 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284453AbRLEPDH>; Wed, 5 Dec 2001 10:03:07 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54948 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284452AbRLEPCx>; Wed, 5 Dec 2001 10:02:53 -0500
Importance: Normal
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
To: kiran@linux.ibm.com
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF29EF801E.F851F18D-ON85256B19.00510775@raleigh.ibm.com>
From: "Niels Christiansen" <nchr@us.ibm.com>
Date: Wed, 5 Dec 2001 10:02:33 -0500
X-MIMETrack: Serialize by Router on D04NM104/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 12/05/2001 10:02:41 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Kiran,

> Statistics counters are used in many places in the Linux kernel,
including
> storage, network I/O subsystems etc.  These counters are not atomic since

> accuracy is not so important. Nevertheless, frequent updation of these
> counters result in cacheline bouncing among various cpus in a multi
processor
> environment. This patch introduces a new set of interfaces, which should
> improve performance of such counters in MP environment.  This
implementation
> switches to code that is devoid of overheads for SMP if these interfaces
> are used with a UP kernel.
>
> Comments are welcome :)
>
>Regards,
>Kiran

I'm wondering about the scope of this.  My Ethernet adapter with, maybe, 20
counter fields would have 20 counters allocated for each of my 16
processors.
The only way to get the total would be to use statctr_read() to merge them.
Same for the who knows how many IP counters etc., etc.

How many and which counters were converted for the test you refer to?

I do like the idea of a uniform access mechanism, though.  It is well in
line
with my thoughts about an architected interface for topology and
instrumentation
so I'll definitely get back to you as I try to collect requirements.

Niels

