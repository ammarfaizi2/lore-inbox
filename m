Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbTGLW2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268676AbTGLW2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:28:17 -0400
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:8066 "EHLO gnuppy")
	by vger.kernel.org with ESMTP id S268674AbTGLW2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:28:16 -0400
Date: Sat, 12 Jul 2003 15:42:46 -0700
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
Message-ID: <20030712224246.GA5354@gnuppy.monkey.org>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com> <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 08:59:18AM -0700, Davide Libenzi wrote:
> On Sat, 12 Jul 2003, Jamie Lokier wrote:
> 
> > Davide Libenzi wrote:
> > > With the current patch you do not need any special support if you are
> > > already asking for SCHED_RR policy. If you are not root you will be
> > > automatically downgraded to SCHED_SOFTRR ;)
> >
> > Cool.  What happens if you run two SCHED_SOFTRR tasks and they both
> > use 50% of the CPU - will that starve all the other tasks?  Or is the
> > CPU usage of all SOFTRR tasks bounded collectively?
> 
> Nope :) They will run their timeslice entirely and then they will try to
> get some more. Looking at their last recharge timestamp, Dad scheduler
> will put them in bed and will give other tasks a chance to run. But don't
> worry, I am very sure there're other exploit available. I just didn't have
> enough time to think about it. It is amazing how limited are things that
> you can do in one hour :)

Hey,

Have any of you folks seen this ?

	http://www.linuxdevices.com/articles/AT6078481804.html
	http://research.microsoft.com/~mbj/papers/tr-99-59_abstract.html

Neat stuff. This with a fully preemptive kernel is one of Linux kernel
dreams for multimedia.

bill

