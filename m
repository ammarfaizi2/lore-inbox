Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268102AbUGWWHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbUGWWHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 18:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUGWWHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 18:07:51 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:28149 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S268108AbUGWWHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 18:07:35 -0400
Date: Sat, 24 Jul 2004 00:06:31 +0200
From: Roger Luethi <rl@hellgate.ch>
To: zanussi@us.ibm.com
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, richardj_moore@uk.ibm.com,
       bob@watson.ibm.com, michel.dagenais@polymtl.ca
Subject: Re: LTT user input
Message-ID: <20040723220631.GD8495@k3.hellgate.ch>
Mail-Followup-To: zanussi@us.ibm.com, linux-kernel@vger.kernel.org,
	karim@opersys.com, richardj_moore@uk.ibm.com, bob@watson.ibm.com,
	michel.dagenais@polymtl.ca
References: <16640.10183.983546.626298@tut.ibm.com> <20040723100101.GA22440@k3.hellgate.ch> <16641.19483.708016.320557@tut.ibm.com> <20040723191900.GA2817@k3.hellgate.ch> <16641.30883.655066.942277@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16641.30883.655066.942277@tut.ibm.com>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004 15:44:19 -0500, zanussi@us.ibm.com wrote:
> I didn't know the auditing framework was a tracing framework.  It
> certainly doesn't seem light-weight enough for real system tracing,
> which was the question.  Are there other frameworks we should consider
> tracing on top of?

I haven't looked at any of these frameworks closely enough to answer
that. My comments were largely based on the observation that there are
several interesting projects that instrument the kernel (typically system
calls) to log information: auditing, performance, or something else.

All of them seem useful, but we can't keep adding hooks for each purpose.
It's like what we had before LSM (in a different area).

>  > What is important to me is irrelevant. Both Linus and Andrew have stated
>  > that demonstrated usefulness for many people is one key criteria for
>  > merging new stuff.
> 
> And where was the 'demonstrated usefulness for many people' of the
> auditing framework?

Well, it's _one_ key criteria. I suspect in this case the decisive
factor was rather the desire to please certain institutions that won't
consider an OS if it can't spy on its users <g>. But I'm making this up,
I'm sure someone remembers the real answer.

Quite frankly, I couldn't care less about auditing. I am much more
interested in tools that help me track down problems. Dprobes and LTT
do look promising. Then again, so did devfs.

>  > That's your problem right there. Nobody cares if LTT is happy. It is
>  > people who matter. LTT users.
> 
> Right, so LTT is the only potential user of the framework that would
> care about performance.  I guess we and anyone else who does can't use
> it then.

No reason to be sarcastic. I didn't say nobody uses it. But those users
aren't exactly highly visible, either.

If you want a textbook example of how to spectacularly fail on this
very issue, recall the LKCD flame war (a couple of years ago?).

> Well, this is what DTrace does too and in almost exactly the same way,
> using an in-kernel interpreter similar to a stripped-down JVM where
> nothing malicious can get out and alter the system.  It's basically
> where all the 'magic' of DTrace happens.  I know, trying to get
> something like this into mainline would be a hard sell, but if you
> know of anything less scary that would let us do thing as exciting as
> DTrace does, let me know...

Heh, that's your job :-). Given that a Java/FORTH/whatever interpreter
is unlikely to be merged into mainline anytime soon, what excitement
can we still offer with the complex stuff living in user space?

Even if your goal is to beat DTrace eventually, you need to sell patches
on their own merits, not based on what we could do in some unlikely or
distant future. DTrace is a red herring, more interesting is what we
can do with, say, basic LTT infrastructure, or dprobes, etc.

Roger
