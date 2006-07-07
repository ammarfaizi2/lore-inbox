Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWGGMBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWGGMBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWGGMBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:01:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5965 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932137AbWGGMBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:01:14 -0400
Date: Fri, 7 Jul 2006 14:03:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
Subject: Re: splice/tee bugs?
Message-ID: <20060707120333.GR4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707114235.243260@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Michael Kerrisk wrote:
> > > c) Occasionally the command line just hangs, producing no output.
> > >    In this case I can't kill it with ^C or ^\.  This is a 
> > >    hard-to-reproduce behaviour on my (x86) system, but I have 
> > >    seen it several times by now.
> > 
> > aka local DoS.  Please capture sysrq-T output next time.
> 
> I don't have sysrq configured in the kernel that I'm testing at 
> the moment (I'll build again with sysrq), but have just got 
> the error again.  For what it's worth, "ps l" says:
> 
> F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
> 0  1000  7099   630  16   0      0     0 -      D+   pts/30     0:00 [ktee]

Try ps -eo cmd,wchan, it should give you a little more at least. But
sysrq-t is the best, of course.

I'll see about reproducing locally.

-- 
Jens Axboe

