Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265018AbUD2Wsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265018AbUD2Wsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbUD2Wsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:48:46 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:37826 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265018AbUD2Wsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:48:43 -0400
Date: Thu, 29 Apr 2004 15:46:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Timothy Miller <miller@techsource.com>
Cc: vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       akpm@osdl.org, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429154632.4ca07cf9.pj@sgi.com>
In-Reply-To: <40917F1E.8040106@techsource.com>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<409175CF.9040608@techsource.com>
	<20040429144737.3b0c736b.pj@sgi.com>
	<40917F1E.8040106@techsource.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy wrote:
> Linux kernel developers seem to be of the mind that you cannot trust 
> what applications tell you about themselves, so it's better to use 
> heuristics to GUESS how to schedule something, rather than to add YET 
> ANOTHER property to it.

Both are needed.  The thing has to work pretty well, for most people,
most of the time, without human intervention.

And there needs to be knobs to optimize performance.  Even with no
conscious end-user administration, a knob on the cron job that runs
updatedb, setup by the distribution packager, could have wide spread
impact on the responsiveness of a system, when the user sits down with
the first cup of coffee to scan the morning headlines and incoming
email er eh spam.

As to whether it's two nice calls, or one with dual affect, let's not
confuse the kernel API with that seen by the user.  The kernel should
provide a minimum spanning set of orthogonal mechanisms, and not be
second guessing whether the user is out of their ever loving mind to be
asking for a hot cpu, cold io, job.

In other words, I wouldn't agree with your take that it's a matter of
not trusting the application, better to GUESS.  Rather I would say that
there is a preference, and a good one at that, to not use an excessive
number of knobs as a cop-out to avoid working hard to get the widest
practical range of cases to behave reasonably, without intervention, and
a preference to keep what knobs that are there short, sweet and
minimally interacting.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
