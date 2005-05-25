Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVEYTH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVEYTH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVEYTHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 15:07:55 -0400
Received: from tierw.net.avaya.com ([198.152.13.100]:55806 "EHLO
	tierw.net.avaya.com") by vger.kernel.org with ESMTP id S262390AbVEYTHB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 15:07:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
Date: Wed, 25 May 2005 13:06:51 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC07AFE7C1@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
Thread-Index: AcVhVLHZkkrv5mMQT4yBzrlxdYAshgABvHZQ
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Chris Friesen" <cfriesen@nortel.com>, <george@mvista.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Chris Friesen [mailto:cfriesen@nortel.com] 
> Sent: Wednesday, May 25, 2005 12:08 PM
> To: george@mvista.com
> Cc: Davda, Bhavesh P (Bhavesh); linux-kernel@vger.kernel.org
> Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms 
> resolution timers
> 
> George Anzinger wrote:
> > Chris Friesen wrote:
> 
> >> What about telling it to wake up a jiffy earlier, then checking 
> >> whether the scheduling lag was enough to cause it to have 
> waited the 
> >> full specified time.  If not, put it to sleep for another jiffy.
> 
> > The user is, of course, free to do what ever they would like.  
> 
> I actually meant doing this in the kernel.

Ditto.

> 
>  > For a
> > more complete solution you might be interested in HRT (High Res 
> > Timers).  See my signature below.
> 
> Yep.  One more patch to apply and worry about versions and 
> maintenance. 
>   Not enough of a demand for us to be able to use it, at 
> least at this 
> point.
> 
> Chris

Ditto ditto :)

BTW, this reminds me an aweful lot of TH2GT2G, and Deep Thought taking 7.5 million years to come up with the answer "42!"

Me: Hey Deep Thought! What's 20 us converted into jiffies?

Deep Thought: Let's see: after accounting for all kinds of underflow and overflow possibilities, and extending the operands to 64-bit to retain the best precision, and crunching through a few complex macros, the answer you're looking for is... Is... Is... "21!" The real problem is: You didn't ask me the right question. You should have asked me "What's 19 us converted into jiffies?"

On a more serious note: what is a real-time (read SCHED_FIFO/SCHED_RR) task to use to get millisecond accuracy wakeup timing services from the kernel? i.e. what are the alternatives to setitimer() that wake up the task exactly at the interval that is requested of it? You mention high-res timers as a possibility, but in the form of a patch. What's available in mainline unpatched?

Thanks

- Bhavesh



Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234, U.S.A. |
Voice/Fax: (303) 538-4438 | bhavesh@avaya.com 
