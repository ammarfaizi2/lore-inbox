Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUGYUFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUGYUFp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 16:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUGYUFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 16:05:44 -0400
Received: from opersys.com ([64.40.108.71]:7428 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S264373AbUGYUFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 16:05:39 -0400
Message-ID: <410410F9.5030403@opersys.com>
Date: Sun, 25 Jul 2004 15:58:49 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Robert Wisniewski <bob@watson.ibm.com>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, richardj_moore@uk.ibm.com,
       michel.dagenais@polymtl.ca
Subject: Re: LTT user input
References: <16640.10183.983546.626298@tut.ibm.com> <20040723100101.GA22440@k3.hellgate.ch> <16641.19483.708016.320557@tut.ibm.com> <20040723191900.GA2817@k3.hellgate.ch> <16641.36290.751769.126111@k42.watson.ibm.com> <20040723234502.GA12631@k3.hellgate.ch>
In-Reply-To: <20040723234502.GA12631@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roger Luethi wrote:
> So the question is (again, this is an issue that has been raised at the
> kernel summit as well): Is there some overlap between those various
> frameworks? Or do we really need completely separate frameworks for
> logging time stamps (performance), auditing information, etc.?

Hmm... I was at the kernel summit and OLS this week, and I had taken a
vacation from my laptop, so I haven't had the chance to reply to you
sooner. Nevertheless, let me talk to you about something I've discussed
with some people at OLS and with which most agreed:
The LKML smart-ass effect.

Here's how this works: Whenever you post something to LKML, you have
to assume that there's at least one smart-ass out there that's going to
pick on a tiny fraction of what you said and blow it out of proportion
while using other peoples' past quotes to try to paint you in as tiny
a corner as possible. Of course the more famous (in kernel development
terms) the person being quoted, the more convincing the smart-ass thinks
he is.

Obviously, this is a general rule, and you've got people who are better
at this than others. It can sometimes be funny, other times just anoying,
and others times still outright counter-productive. All in all, I
personally believe that this plays against Linux on the long term because
a lot of people avoid the LKML for that very reason.

So I have a few questions for you:
- Were you at KS?
- Were you at OLS?
- If you were at either events, then why didn't you come and talk to me
face-to-face?
- If you weren't, then how can you judge of the general mood of kernel
developers regarding LTT's adoption?

As to the issue you mention above, I don't remember any of the kernel
developers I've spoken to mentioning the need for merging what you claim
to be overlapping functionalities (not that such a thing is bad, and I
had suggested to the maintainers of some of the other tools you mention
to use LTT because it already existed, and their answer was: we'd gladly
use it if were already part of the kernel.) What was made very clear to
me by quite a few people, and by Andrew in person, was that LTT had a
sales problem (i.e. the LTT development team has to demonstrate that this
is actually needed by real users.) And this criticism is fair enough. We
have indeed negleted to document with real-world scenarios how LTT was
essential at solving problems.

As for DTrace, then its existence and current feature set is only a
testament to the fact that the Linux development model can sometimes have
perverted effects, as in the case of LTT. The only reason some people can
rave and wax about DTrace's capabilities and others, as yourself, drag
LTT through the mud because of not having these features, is because the
DTrace developers did not have to put up with having to be excluded from
their kernel for 5 years. As I had said earlier, we would be eons ahead
if LTT had been integrated into the kernel in one of the multiple attempts
that was made to get it in in the past few years. Lest you think that
DTrace actually got all its features in a single merge iteration ...

No one has summarized what happens to tools like LTT than Andrew in his
keynote to OLS: kernel developers are not always aware of the usefullness
of certain tools and sometimes need to be educated about said usefullness.
I concur with Andrew, and do take part of the blame for not having done
enough to address this issue in the past.

Nevertheless, not all is bad. Andrew and others have made suggestions
to me during KS/OLS and I intend to follow-up on these.

Plus, I've run into a ton of people who have told me that this type of
tool is essential for their day-to-day work. I will stop short of
covering actual names, but you should hear about such things in the near
future.

> DTrace is not a performance monitoring infrastructure, so what's your
> point? -- But let's assume for the sake of argument that LTT, dprobes
> & Co.  provide something comparable to DTrace, and we just disagree on
> what "performance monitoring" means: The chance of getting such a pile
> of complexity into mainline are virtually zero (unless it's called ACPI
> and required to boot some machines :-/).

You may want to be somewhat constructive here. You don't necessarily need
to follow the Modus Operandi of others on this list. The fact of the matter
is that we've been maintaining a very large stack of software components
for the past few years. We didn't do this just for the fun of it. We've
done it because we were asked to make the pieces small, efficient, and as
independent as possible. As a result, you can use crash dump without
tracing, you can use dprobes without LTT, and you can use LTT without
dprobes, etc.

> So what you can push for inclusion is bound to be a subset, and the
> question remains: What does such a subset, which is clearly nothing
> like DTrace, offer?

This kind of sound-bite would be great if this were FOX, but it isn't.
So if the benchmark is going to be DTrace, then you have to look as to
how DTrace came to be. It came to be because its developers did not have
to release a new Solaris patch for every iteration of the Solaris OS for
5 years. Level the playing field for us, and you'll see what comes next.
That's what OSS is about. It's when you see things like DTrace speed pass
projects like LTT/DPRobes/etc. that you begin to understand that the
kernel development model is not fail-safe.

There's absolutely no justification for letting a set of OSS projects
led by motivated people be overtaken by a propriatery product.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

