Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965391AbWIRFQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965391AbWIRFQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965392AbWIRFQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:16:46 -0400
Received: from opersys.com ([64.40.108.71]:5138 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S965391AbWIRFQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:16:45 -0400
Message-ID: <450E3099.20409@opersys.com>
Date: Mon, 18 Sep 2006 01:37:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Theodore Tso <tytso@mit.edu>, Nicholas Miell <nmiell@comcast.net>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
References: <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu> <20060918035216.GF9049@thunk.org> <450E1F6F.7040401@opersys.com> <20060918043248.GB19843@elte.hu>
In-Reply-To: <20060918043248.GB19843@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> and now i'm red faced - i was wrong about this fundamental aspect of 
> your position. Please accept my apologies!

Apologies accepted. Hopefully we can tone this thread down and
move on to more constructive implementation discussions.

> so regarding the big picture we are largely on the same page in essence 
> i think - sub-issues non-withstanding :-) As long as LTT comes with a 
> facility that allows the painless moving of a static LTT markup to a 
> SystemTap script, that would come quite a bit closer to being acceptable 
> for upstream acceptance in my opinion.

I don't think there's any impediment for that. In fact, the value
is not in the markup, but in the tools.

> The curious bit is: why doesnt LTT integrate SystemTap yet?

Performance aside, this is due to historic reasons which cannot,
unfortunately, be succinctly explained. The best I can do is refer
you to the topmost parent of this thread, lengthy as it may be. As I
told Ted, if the signal *and* endorsement is that LTT and SystemTap
should be complementary, then that is exactly what will happen.

It doesn't solve the performance problem, but even the SystemTap
folks are concerned by performance and would like to see some form
of static markup, so I think the LTTng and SystemTap efforts are
on the same page here.

> Is it the 
> performance aspect? Some of the extensive hooking you do in LTT could be 
> aleviated to a great degree if you used dynamic probes. For example the 
> syscall entry hackery in LTT looks truly scary. I cannot understand that 
> someone who does tracing doesnt see the fundamental strength of 
> SystemTap - i think that in part must have lead to my mistake of 
> assuming that you opposed SystemTap.

I am not opposed to SystemTap and neither do I fail to see its
fundamental strength. It's just a matter that a decision was made
at some point in time that SystemTap be developed separately *and*
independently from any existing tracing effort. Again, that
decision was based on what appeared to be good reasons for the
people in charge, and there's no point in further highlighting
differences.

I think what is important at this stage is that now that we have
an agreement on the need for some form of static markup, that
the developers of the various teams work together to come up
with an acceptable framework for all to use. And, ideally, this
effort should be spearheaded by someone who has enough knowledge
of the kernel's intricacies as to avoid any obvious pitfalls.
In that regard, you're likely the best person to take charge of
this.

Once markup is in place, much of the mechanics of either of
the existing *mechanisms* can then simply disappear in the
background without *any* impact on the rest of the developers.

Only then will there start to be constructive discussion as
to where best markup should be located and what mechanism
is typically most appropriate for that specific location.

All that being said, I would like to thank you for acknowledging
a misunderstanding on your part. Hopefully we can all set this
aside, and move forward on common goals.

Thanks,

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
