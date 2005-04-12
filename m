Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbVDLXdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVDLXdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVDLXZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:25:51 -0400
Received: from unused.mind.net ([69.9.134.98]:30601 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S263059AbVDLXWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:22:35 -0400
Date: Tue, 12 Apr 2005 16:21:30 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUGs in 2.6.12-rc2-RT-V0.7.45-01
In-Reply-To: <20050412230921.GA22360@elte.hu>
Message-ID: <Pine.LNX.4.58.0504121619470.3023@echo.lysdexia.org>
References: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org>
 <20050412230921.GA22360@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Triggered when running 'yum update', followed by system lockup within 
> > one minute:
> > 
> > BUG: sleeping function called from invalid context python(4302) at kernel/rt.c:1613
> > in_atomic():1 [00000001], irqs_disabled():1
> >  [<c0103dba>] dump_stack+0x23/0x25 (20)
> >  [<c0119ed0>] __might_sleep+0xd8/0xed (36)
> >  [<c0139bbc>] __spin_lock+0x34/0x50 (24)
> >  [<c0139bf5>] _spin_lock+0x1d/0x1f (16)
> >  [<c01465cf>] lock_kprobes+0x17/0x23 (12)
> >  [<c01122c9>] kprobe_handler+0xa9/0x209 (32)
> >  [<c011251c>] kprobe_exceptions_notify+0x48/0x13c (28)
> 
> what are you using kprobes for? Do you get lockups even if you disable 
> kprobes?
> 
> 	Ingo

I'm not using kprobes currently.  I'll recompile and see if the lockups go 
away.

--ww

--
/* William Weston <weston@sysex.net> */
