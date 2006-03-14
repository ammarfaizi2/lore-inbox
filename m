Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752051AbWCNKDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWCNKDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWCNKDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:03:51 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:31142 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1752051AbWCNKDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:03:50 -0500
From: Grant Coady <gcoady@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
Date: Tue, 14 Mar 2006 21:03:39 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <kv2d12131e73fjkp0hufomj152un5tbsj1@4ax.com>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com> <1142273212.3023.35.camel@laptopd505.fenrus.org> <20060314062144.GC21493@w.ods.org>
In-Reply-To: <20060314062144.GC21493@w.ods.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006 07:21:44 +0100, Willy Tarreau <willy@w.ods.org> wrote:

>On Mon, Mar 13, 2006 at 07:06:52PM +0100, Arjan van de Ven wrote:
>> On Tue, 2006-03-14 at 05:03 +1100, Grant Coady wrote:
>> > On Mon, 13 Mar 2006 09:17:47 +0100, Arjan van de Ven <arjan@infradead.org> wrote:
>> > 
>> > >2.6 is actively maintained and will be for quite some time :)
>> > 
>> > 2.6 is an experimental, unstable and non-trustworthy file muncher.
>
>Uhh? Grant, you are feeling brave to say this in front of so many
>kernel developpers ! :-)

Hah, I've already offended a maintainer to the point of being 
kill-filed.  So what?  This place is anarchy in action, people 
fight for their ideas -- I been reading lkml since '97...

2.4 series I've used since before Linus slipped the 2.4.0 out 
without fanfare.

2.5 I missed, doing other stuff, take a look at 2.6 for only 
the last year or so, since I think about 2.6.10...

>> that's tripple fud that sounds like a troll ;)
>> Sorry but it does.

That's okay, while I'm no troll, I hold an opinion that a few may share.
>> 
>> 2.6 is very stable for a LOT of people, more so than 2.4 in fact.

Stable in what sense?  Rate of change of code is still accelerating?

2.6.15.5 stable issued with bust NFS 'cos people didn't check their 
bug / security fix patch progress when requested by the stable team?

By stable I mean rate of change of codebase, patch volume per month,  
2.6 is orders of magnitude less stable than 2.4 by that simple measure.

>It depends a lot on what people do with it in fact. For instance, it
>works better in memory-constrained systems, probably thanks to rmap.
>I have one 2.6 running reliably on my web server (hppa) where 2.4
>regularly oopsed because of low memory.

Well, memory is cheap?  Lowest memory box here is 128MB, and I don't 
get my hands on appliance hardware to try the really small stuff.

>However, network performance has significantly dropped, and the
>scheduler is still a big problem. Not only we occasionally see
>people complaining about unfair CPU distribution across processes
>(may be fixed now), but the scheduler still gives a huge boost to
>I/O intensive tasks which do lots of select() with small time-outs,
>which makes it practically unusable in network-intensive environments.

>I've observed systems on which it was nearly impossible to log in via
>SSH because of this, and I could reproduce the problem locally to
>create a local DoS where a single user could prevent anybody from
>logging in. 2.6.15 has improved a lot on this (pauses have reduced
>from 35 seconds to 4 seconds) but it's still not very good.

Yep, but at least running reiserfs3 I can hit reset and not lose 
filesystem when the thing locks itself into thumb-twiddling mode ;)

>It's still the major reason why I haven't switched, and why several
>people I know regularly jump back to 2.4 when they realize that it's
>not their hardware which is slow. On the other side, block I/O seems
>to have improved a lot. Slocate takes far less time in 2.6 than in
>2.4 and runs smoother.

Yes, bulk I/O transfers are faster in 2.6.  I keep going back to 
2.4 when I'm writing simple text files over ssh terminal session.  
2.6 is simply too sluggish on the same hardware.  Thus I stay with 
a dual boot configuration and limit options to the 2.4 kernel set.

No udev, no new features.  Because the overall 2.6 feel is not yet 
there.  Maybe next year?  Who knows.

>The last stability concern is about code stability. It's moving
>very fast, and whatever version you choose, you'll have a hard
>time trying to backport fixes in 1 year. Even for Greg and Chris
>it has been a huge work to maintain fixes for both 2.6.14 and
>2.6.15. I hope things will stabilize. The only real solution right
>now would be to use commercial distros who pay developpers to do
>this painful work.

My distro of choice (Slackware) doesn't, thus I'm terribly annoyed 
at the cowboy developer attitude of 'leave it to the distro to 
stabilise'.  That issue eased a great deal with the 'sucker tree'.

Cheers,
Grant.
