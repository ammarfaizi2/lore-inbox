Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWHVBhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWHVBhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 21:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHVBhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 21:37:39 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:56813
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751090AbWHVBhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 21:37:38 -0400
Date: Mon, 21 Aug 2006 18:37:22 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060822013722.GA628@gnuppy.monkey.org>
References: <20060810021835.GB12769@gnuppy.monkey.org> <20060811010646.GA24434@gnuppy.monkey.org> <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com> <20060811211857.GA32185@gnuppy.monkey.org> <20060811221054.GA32459@gnuppy.monkey.org> <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com> <20060814234423.GA31230@gnuppy.monkey.org> <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com> <20060818115934.GA29919@gnuppy.monkey.org> <e6babb600608211721g739c5518sa14427d1e9f2334@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600608211721g739c5518sa14427d1e9f2334@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 05:21:35PM -0700, Robert Crocombe wrote:
> On 8/18/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> >Patch attached:
> 
> The problem still appears to happen, but now I get no trace at all,
> just a single line reported to the machine's console (and not on the
> serial console):
> 
> pdflush/314[CPU#2]: BUG in debug_rt_mutex_unlock at 
> kernel/rt_mutex_debug.c:471
> 
> i.e., a standard statement, except at pdflush instead of swapper this time.

Thanks for testing. I appreciate this and I'm more than just plain willing
to help out. Any thing goes to get this patch solid. :)

I'll come up with a patch tomorrow to try and get a clean stack trace. I've
made some change to the bug dump output to make it more preemption aware,
but, as you can, some tweeking is needed.

However, I don't think this is going to be a simple atomic violation problem
that I've seen numerous times before. That's what the previous patch tried to
address. It's seriously pointing to a problem with the rtmutex and/or how it's
used, maybe a corner case it's missing.

I'll start to look at it either tonight or tomorrow and see what's going on.
It's going to take me a bit so be patient. I'll definitely get back to you
on this. I've got a number of weeks to blow exclusively on -rt development,
so I'll be around for a little while longer, hopefully longer.

bill

