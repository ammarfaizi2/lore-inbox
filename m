Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUCXXYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbUCXXYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:24:16 -0500
Received: from gprs214-165.eurotel.cz ([160.218.214.165]:61315 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262153AbUCXXYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:24:01 -0500
Date: Thu, 25 Mar 2004 00:23:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040324232338.GE290@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <1080081653.22670.15.camel@calvin.wpcb.org.au> <20040323234449.GM364@elf.ucw.cz> <opr5ci61g54evsfm@smtp.pacific.net.th> <20040324101704.GA512@elf.ucw.cz> <opr5d1jave4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <opr5d1jave4evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 25-03-04 06:46:12, Michael Frank wrote:
> May I request that you leave the authors headers intact when quoting. Thank 
> you.

As you wish.

> On Wed, 24 Mar 2004 11:17:04 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> 
> >>>>So why aren't you arguing against bootsplash too? That definitely
> >>>>obscures such an error :> Of course we could argue that such an error
> >>>>shouldn't happen and/or will be obvious via other means (assuming it
> >>>>indicates hardware failure).
> >>>
> >>>Of course I *am* against bootsplash. Unfortunately I've probably lost
> >>>that war already. But at least it is not in -linus tree (and that's
> >>>what I use anyway) => I gave up with bootsplash-equivalents, as long
> >>>as they don't come to linus.
> >>>
> >>>[And I believe Linus would shoot down bootsplash-like code, anyway.]
> 
> Why? Joe consumer wants it.
> As to the ever growing size of the kernel, there could be a official 
> addons/tools
> tree with non-core functions maintained by a seperate maintainer. Things 
> like
> debuggers, profiling or (swsusp) debug support could go there as
> well...

Yes, having -nice patch with bootsplashes, translated kernel messages,
and swsusp eye-candy would work for me. Feel free to maintain it.

> >>Solution: Auto switch to non-swsusp VT on error showing the error message.
> >
> >Hmm, at that point you loose context, like now you know what error
> >happened, but do not know at which phase of suspend. That's pretty bad
> >too.
> 
> Right, Good idea!  Just  print always "ugly" swsusp context on a text VT - 
> plus any
> error messages  - and switch over to this VT in printk when not in interrupt
> context. 10 lines of code or so in printk ;)

You see, 10 lines in printk is probably good enough reason not to
include that patch in kernel, because its "too ugly". Plus it does not
work if printk _was_ from interrupt context.

swsusp really should not have patch any code outside kernel/power.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
