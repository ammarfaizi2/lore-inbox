Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274427AbRJJDXx>; Tue, 9 Oct 2001 23:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274456AbRJJDXp>; Tue, 9 Oct 2001 23:23:45 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:47657 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274427AbRJJDXd>; Tue, 9 Oct 2001 23:23:33 -0400
Subject: Re: 2.4.10-ac10-preempt lmbench output.
From: Robert Love <rml@ufl.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011010050630.E726@athlon.random>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org>
	<20011010031803.F8384@athlon.random>
	<20011010020935.50DEF1E756@Cantor.suse.de>
	<20011010043003.C726@athlon.random> <1002681480.1044.67.camel@phantasy> 
	<20011010050630.E726@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 23:24:36 -0400
Message-Id: <1002684288.862.123.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 23:06, Andrea Arcangeli wrote:
> [...]
> I think the issue you raise is that dbench gets a 10msec more of cpu
> time and xmms starts running 10msec later than expected (because of the
> scheduler latency peak worst case of 10msec).
> 
> But that doesn't matter. The scheduler isn't perfect anyways. The
> resolution of the scheduler is 10msec too, so you can easily lose 10msec
> anywhere else no matter of whatever scheduler latency of 10msec. [...]

I agree with generally everything you say.

I think, however,  you are making two assumptions:

(a) xmms has a very large leeway in the timing of its execution

(b) the maximum time a process sits in kernel space is 10ms.

While I agree (a) is true, it may not be so in all scenerios. 
Furthermore, the specified leeway does not exist for all timing-critical
tasks.  Not all of these tasks are specialized real-time applications,
either.

Most importantly, however, the maximum latency of the system is not
10ms.  Even _with_ preemption, we have observed greater latencies (due
to long held locks).

This is why I believe the a preemptible kernel benefits more than just
real-time signal processing.

	Robert Love

