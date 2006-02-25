Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWBYCQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWBYCQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWBYCQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:16:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:55704 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964856AbWBYCQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:16:23 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
From: MIke Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       kernel@kolivas.org, nickpiggin@yahoo.com.au,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <43FFAFE9.8000206@bigpond.net.au>
References: <1140183903.14128.77.camel@homer>
	 <1140812981.8713.35.camel@homer> <20060224141505.41b1a627.akpm@osdl.org>
	 <43FFAFE9.8000206@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 03:20:02 +0100
Message-Id: <1140834002.7641.20.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 12:16 +1100, Peter Williams wrote:
> Andrew Morton wrote:
> > MIke Galbraith <efault@gmx.de> wrote:
> > 
> >>Not many comments came back, zero actually.
> >>
> > 
> > 
> > That's because everyone's terribly busy chasing down those final bugs so we
> > get a really great 2.6.16 release (heh, I kill me).
> > 
> > I'm a bit reluctant to add changes like this until we get the smpnice stuff
> > settled down and validated.  I guess that means once Ken's run all his
> > performance tests across it.
> > 
> > Of course, if Ken does his testing with just mainline+smpnice then any
> > coupling becomes less of a problem.  But I would like to see some feedback
> > from the other sched developers first.
> 
> Personally, I'd rather see PlugSched merged in and this patch be used to 
> create a new scheduler inside PlugSched.  But I'm biased :-)
> 
> As I see it, the problem that this patch is addressing is caused by the 
> fact that the current scheduler is overly complicated.  This patch just 
> makes it more complicated.

What's complicated about the scheduler?  I see simple/elegant when I
look in there.  Interaction with the user is complex, but interactive
feel is a nebulous thing not restricted to this scheduler.

I really don't think this patch adds complexity, quite the opposite
actually.  It just does a small bit of tweaking to the scheduler's weak
spot, and adds a dirt simple barrier against starvation.  IMO, this
scheduler is not only quite simple, it's one weakness is generally
wonderful for throughput.  It's just that it's sometimes a bit _too_
wonderful ;-)

	-Mike

