Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263214AbUJ2KSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbUJ2KSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbUJ2KSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:18:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49117 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263214AbUJ2KR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:17:59 -0400
Date: Fri, 29 Oct 2004 12:17:58 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041029101758.GA7278@atrey.karlin.mff.cuni.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041029024651.1ebadf82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029024651.1ebadf82.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@suse.cz> wrote:
> >
> >    I know about a few people who would like to use some functionality of
> >  the Magic Sysrq but don't want to enable all the functions it provides.
> 
> That's a new one.  Can you tell us more about why people want to do such a
> thing?
  For example in a computer lab at the university the admin don't want
to allow users to Umount/Kill (mainly to make it harder for users to
screw up the computer) but wants to allow SAK/Unraw.
  Another (actually not so legitimate ;) example is that in e.g. SUSE
kernels sysrq is turned off by default (some people are afraid that it
could be a security issue) so most users have it turned off and hence
when the computer deadlocks, there's no debugging output. When you could
allow only debugging outputs then the fear about security would be much
smaller.
  So in general it's mainly to make life a bit easier to
admins/developpers...

> >  So I wrote a patch which should allow them to do so. It allows to
> >  configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
> >  interface is backward compatible). If you think it's useful then use it :)
> >  Andrew, do you think it can go into mainline or it's just an overdesign?
> 
> Patch looks reasonable - we just need to decide whether the requirement
> warrants its inclusion.
> 
> There have been a few changes in the sysrq code since 2.6.9 and there are
> more changes queued up in -mm.  The patch applies OK, but it'll need
> checking and redoing.  There's a new `sysrq-f' command in the pipeline
> which causes a manual oom-killer call.
  OK, I'll rediff it againts latest -mm if we agree that inclusion
would be useful.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
