Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTJ2JoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 04:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTJ2JoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 04:44:15 -0500
Received: from gprs198-79.eurotel.cz ([160.218.198.79]:27521 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261941AbTJ2JoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 04:44:11 -0500
Date: Wed, 29 Oct 2003 10:43:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, felipe_alfaro@linuxmail.org,
       mochel@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031029094336.GB757@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <20031028224101.3220e0a6.sfr@canb.auug.org.au> <16286.60534.924753.349385@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16286.60534.924753.349385@wombat.chubb.wattle.id.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Stephen> On Tue, 28 Oct 2003 10:32:33 +0100 Pavel Machek
> Stephen> <pavel@suse.cz> wrote:
> Stephen> We could invent a new signal whose default action is ignore
> Stephen> ... Solaris has SIGFREEZE and SIGTHAW (the comment in the
> Stephen> header file says used by CPR - whatever that is).  SIGSUSPEND
> Stephen> and SIGRESUME?
> 
> CPR -- checkpoint/restart
> 
> POSIX said to use SIGCKPT and SIGCONT (in at least *one* of the draft
> 1003.1m standards -- I've lost access to them recently, and the
> working group stopped working back in 2000)
> 
> Suspend/resume is essentially a system-wide checkpoint+restart.
> 
> Maybe use SIGCKPT and SIGCONT?  Or even SIGSTOP and SIGCONT (after
> all, you're stopping the process, then restarting it)

SIGSTOP/SIGCONT is non-starter; too many apps have problem with that.

I guess Patrick's /sbin/hotplug solution is best; implement it as
kill -SIGSTOP -1 if you want to.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
