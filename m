Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbULAXWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbULAXWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbULAXWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:22:42 -0500
Received: from users.ccur.com ([208.248.32.211]:21510 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261493AbULAXW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:22:27 -0500
Date: Wed, 1 Dec 2004 18:22:04 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: waitid breaks telnet
Message-ID: <20041201232204.GA29829@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20041130202730.6ceab259.akpm@osdl.org> <200412011920.iB1JKlug004542@magilla.sf.frob.com> <20041201114141.7f3347a1.akpm@osdl.org> <20041201223014.GA3271@tsunami.ccur.com> <20041201224906.GA11963@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201224906.GA11963@tsunami.ccur.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 05:49:06PM -0500, Joe Korty wrote:
> On Wed, Dec 01, 2004 at 05:30:14PM -0500, Joe Korty wrote:
> > On Wed, Dec 01, 2004 at 11:41:41AM -0800, Andrew Morton wrote:
> > > Roland McGrath <roland@redhat.com> wrote:
> > > >
> > > > I've had no luck reproducing that, so there isn't much I can do.
> > > 
> > > Did you try bare 2.6.10-rc2?
> > > 
> > > >  The last
> > > > time someone thought the waitid change broke something random, it was the
> > > > perturbation of the compiled code vs the issue that the kernel's assembly
> > > > code doesn't follow the same calling conventions the compiler expects.
> > > 
> > > Could be that, but I was able to reproduce it on 2.6.10-rc2 with
> > > gcc-2.95.4, with which -mregparm is disabled.
> > > 
> > > Still.  It would be interesting if Joe could retest with CONFIG_REGPARM=n?
> > 
> > CONFIG_REGPARM is not set in all of my kernels (just verified).
> 
> More info: I exclusively use CONFIG_SMP and CONFIG_PREEMPT.
> If it is a race either or both of these is likely to
> be involved.

Ok, I rebuilt 2.6.9 with CONFIG_PREEMPT=n and telnet failed
the one time I tried it.

Then I built with CONFIG_PREEMPT=n and CONFIG=SMP=n and
the first telnet attempt succeeded.  I then tried six
more telnet attempts, two of those failed and the rest
succeeded.

Since my earlier testing usually was of only 1 (sometimes
2) telnet attempts per boot, they too may have had some
ratio of success/failure other than 100% or 0%.

Joe
