Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWCQGEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWCQGEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbWCQGEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:04:16 -0500
Received: from mail.gmx.de ([213.165.64.20]:45205 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751407AbWCQGEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:04:15 -0500
X-Authenticated: #14349625
Subject: Re: can I bring Linux down by running "renice -20
	cpu_intensive_process"?
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <yw1xbqw69f6j.fsf@agrajag.inprovide.com>
References: <441180DD.3020206@wpkg.org>
	 <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
	 <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
	 <1142135077.25358.47.camel@mindpipe>
	 <yw1xk6azdgae.fsf@agrajag.inprovide.com> <4419D575.4080203@tmr.com>
	 <yw1xbqw69f6j.fsf@agrajag.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 17 Mar 2006 07:05:50 +0100
Message-Id: <1142575550.8868.20.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 22:51 +0000, Måns Rullgård wrote:
> Bill Davidsen <davidsen@tmr.com> writes:
> 
> > Måns Rullgård wrote:
> >> Maybe extending sysrq+n to lower the priority of -20 tasks would be a
> >> good idea.
> >>
> > If it runs before the keyboard thread it doesn't matter...
> 
> Of course not, but that's not generally the case.
> 
> > But why should this hang anything, when there should be enough i/o
> > to get out of the user process. There's a good fix for this, don't
> > give this guy root any more ;-)
> 
> Ever heard of bugs?  Anyone developing a program can make a mistake.
> If the program runs with realtime scheduling a bug that makes it enter
> an infinite loop (or do something else that hogs the CPU) can be
> difficult to find since it rather efficiently locks you out.

Given that someone has already determined that installing a safety valve
for RT tasks was worth while, and given that there is practically no
difference between a nice -20 and the lowest RT priority, seems to me
that extending that safety valve to cover reniced tasks is the
obviously-correct thing to do.  I think you should submit a patch.

	-Mike

