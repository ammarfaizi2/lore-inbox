Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278440AbRJMXVj>; Sat, 13 Oct 2001 19:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278438AbRJMXVT>; Sat, 13 Oct 2001 19:21:19 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:48409 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S278437AbRJMXVN>; Sat, 13 Oct 2001 19:21:13 -0400
Subject: Re: 2.4.10-ac10-preempt lmbench output.
From: Robert Love <rml@ufl.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>, safemode <safemode@speakeasy.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011012132220.B35@toy.ucw.cz>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org>
	<20011010031803.F8384@athlon.random>
	<20011010020935.50DEF1E756@Cantor.suse.de>
	<20011010043003.C726@athlon.random> <1002681480.1044.67.camel@phantasy> 
	<20011012132220.B35@toy.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.12.08.08 (Preview Release)
Date: 13 Oct 2001 19:21:25 -0400
Message-Id: <1003015290.864.70.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-10-12 at 09:22, Pavel Machek wrote:
> Hi!
> 
> > Now dbench (or any task) is in kernel space for too long.  The CPU time
> > xmms needs will of course still be given, but _too late_.  Its just not
> > a cpu resource problem, its a timing problem.  xmms needs x units of CPU
> > every y units of time.  Just getting the x whenever is not enough.
> 
> Yep, with
> 
> x = 60msec
> y = 600msec

How are you arriving at that y?  On what system?

I agree with the x value, though.  However, people have been shouting a
lot of numbers around about the size of audio buffers, the size of DMA
buffers, etc. and they aren't realistic.  If you calculate out the times
that have been quoted, keeping in mind the stereo and all, the buffers
are huge.  We need to find out what the sizes _really_ are, and then
keep in mind that we have multiple channels (plus any other sound output
from X and what not).

Honestly, I don't know what the buffer sizes are.  I do know audio skips
for me, and preempt-kernel patch improves that.

	Robert Love

