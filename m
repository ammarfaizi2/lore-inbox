Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVBBQMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVBBQMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVBBQMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:12:39 -0500
Received: from mail.joq.us ([67.65.12.105]:44264 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262561AbVBBP7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:59:21 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us>
	<20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<874qh3bo1u.fsf@sulphur.joq.us>
	<1106796360.5158.39.camel@npiggin-nld.site>
	<87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu>
	<873bwfo8br.fsf@sulphur.joq.us> <20050202113705.GA25012@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 02 Feb 2005 10:01:20 -0600
In-Reply-To: <20050202113705.GA25012@elte.hu> (Ingo Molnar's message of
 "Wed, 2 Feb 2005 12:37:05 +0100")
Message-ID: <874qgvj6i7.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[trimming the Cc: list]

> * Jack O'Quin <joq@io.com> wrote:
>> Remember when I asked how you handle changes to sizeof(struct rusage)?
>> That was a serious question.  I hope there's a solution. [...]

Ingo Molnar <mingo@elte.hu> writes:
> what does any of what we've talking about have to do with struct rusage? 

Your previous message implied that "userspace" programmers don't
understand binary compatibility...

> you might ask yourself, 'why is this so, and why cannot the Linux guys
> apply pretty much any hack as e.g. userspace code might'

I was just demonstating that I do.

> " > Does getrusage() return anything for this?  How can a field be added
>   > to the rusage struct without breaking binary compatibility?  Can we
>   > assume that no programs ever use sizeof(struct rusage)?
>
>   rlimits are easily extended and there are no binary compatibility
>   worries. The kernel doesnt export the maximum towards userspace.
>   getrusage() will return the value on new kernels and will return 
>   -EINVAL on old kernels, so new userspace can deal with this 
>   accordingly. "
>
> (and here i meant getrlimit(), not getrusage() - getrusage() is not
> affected by the patch at all.)

Well, that was source of my question.

I had asked about rusage.  You said it did return a new value, but
that this was not a problem.  That made no sense to me.  Thank you for
clearing it up.

Certainly getrlimit() works OK.  I understood that already.
-- 
  joq
