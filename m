Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277599AbRKFCmH>; Mon, 5 Nov 2001 21:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277612AbRKFCl5>; Mon, 5 Nov 2001 21:41:57 -0500
Received: from ash.lnxi.com ([207.88.130.242]:43257 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S277599AbRKFClq>;
	Mon, 5 Nov 2001 21:41:46 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre8 Alt-SysRq-[TM] failure during lockup...
In-Reply-To: <m3wv15n5c9.fsf@DLT.linuxnetworx.com> <3BE6DC56.5A0984A4@osdl.org>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 05 Nov 2001 19:41:38 -0700
In-Reply-To: <3BE6DC56.5A0984A4@osdl.org>
Message-ID: <m3pu6waae5.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> "Eric W. Biederman" wrote:
> > 
> > Summary:  I triggered a condition in 2.4.14-pre8 where SysRq triggered
> > but would not print reports.  I managed to unstick the condition but
> > had played to much to determine the root cause.  My guess is that
> > somehow my default loglevel was messed up.  Full information is
> > provided just case I did not muddy the waters too much.
> 
> Do you know what the console loglevel was when you tried
> to use Alt-SysRq-M (show_mem) or Alt-SysRq-T (show tasks ==
> show_state)?  (first value listed in /proc/sys/kernel/printk file)

I was in single user mode so it shouldn't have been changed
from it's default value.  But it might have been.
 
> show_mem() and show_state() don't modify the current value of
> console_loglevel; they depend on the sysrq handler to do that.
> That value could be too low/small.

Right.  That looks to be why I couldn't see my debug information.

There was definentily something hosed at the kernel level
that shouldn't have been.  We should be very careful before
we move 2.4.14-pre8 to 2.4.14.  Hopefully I/someone can find a way
to reproduce a lockup and track it down.


> Aye, sysrq_handle_term sets console_loglevel to 8 and leaves it there.

That is good to know thanks.

Eric


