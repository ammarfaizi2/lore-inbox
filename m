Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTJNIgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTJNIgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:36:43 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:30361
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S262056AbTJNIgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:36:39 -0400
Subject: Re: Circular Convolution scheduler
From: Piet Delaney <piet@www.piet.net>
To: George Anzinger <george@mvista.com>
Cc: Clayton Weaver <cgweav@email.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3F833C06.7000802@mvista.com>
References: <20031006161733.24441.qmail@email.com> 
	<3F833C06.7000802@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Oct 2003 01:37:23 -0700
Message-Id: <1066120643.25020.121.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-07 at 15:19, George Anzinger wrote:
> Ok, I'll admit my ignorance.  What is circular convolution?  Where can 
> I learn more?

circular convolution is used with the Fast Fourier Transform.
The frequency data goes from -N/2 ...0 ,,,, +N/2,
multiplying in the frequency domain is the same as
convolving in the time or space domain. The result of multiplying
a time series by say a filter is the same as convolving it
with the FFT of the filter. Both domains wrap around with the
FFT, so the normal convolution associated with the Fourier
transform is replace with the circular convolution.

Many prediction algorithms are based on digital signal processing.
The Kalman filter for example was used by Harvey for forecasting
financial markets. The kernel likely has lots of time series that
could be used for system identification for predicting how to best
use system resources.

I did a lot of work with them designing Reconstruction algorithms
for Brain Scanners. 

-piet
> 
> -g
> 
> Clayton Weaver wrote:
> > Though the mechanism is doubtless familiar
> > to signal processing and graphics implementers,
> > it's probably not thought of much in a
> > process scheduling contex (although there was
> > the Evolution Scheduler of a few years ago,
> > whose implementer may have had something like
> > circular convolution in mind). It just seems to me
> > (intuition) that the concept of what circular convolution does is akin to what we've been
> > feeling around for with these ad hoc heuristic
> > tweaks to the scheduler to adjust for interactivity
> > and batch behavior, searching for an incremental self-adjusting mechanism that favors interactivity
> > on demand.
> > 
> > I've never implemented a circular convolver in
> > any context, so I was wondering if anyone who
> > has thinks scheduler prioritization would be
> > simpler if implemented directly as a circular convolution.
> > 
> > (If nothing else, it seems to me that the abstract model of what the schedule prioritizer is doing
> > would be more coherent than it is with ad hoc
> > code. This perhaps reduces the risk of unexpected side-effects of incremental tweaks to the scheduler. The behavior of an optimizer that implements
> > an integer approximation of a known mathematical transform when you change its inputs is fairly predictable.)
> > 
> > Regards,
> > 
> > Clayton Weaver
> > <mailto: cgweav@email.com>
> > 
> > 
> 
> -- 
> George Anzinger   george@mvista.com
> High-res-timers:  http://sourceforge.net/projects/high-res-timers/
> Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
piet@www.piet.net

