Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266151AbTGLQGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbTGLQGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:06:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:59539 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266151AbTGLQFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:05:47 -0400
Date: Sat, 12 Jul 2003 17:20:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
Message-ID: <20030712162029.GE9547@mail.jlokier.co.uk>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com> <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > Cool.  What happens if you run two SCHED_SOFTRR tasks and they both
> > use 50% of the CPU - will that starve all the other tasks?  Or is the
> > CPU usage of all SOFTRR tasks bounded collectively?
> 
> Nope :) They will run their timeslice entirely and then they will try to
> get some more. Looking at their last recharge timestamp, Dad scheduler
> will put them in bed and will give other tasks a chance to run.

Nice, but answer to wrong question, possibly :)

I'm wondering what happens if the tasks are both good, early to bed
without a fuss.  Neither runs their entire timeslice.

Or to illustrate: say xine uses 10% of my CPU.  What happens when I
open 11 xine windows?

-- Jamie
