Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUG1VX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUG1VX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUG1VXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:23:07 -0400
Received: from opersys.com ([64.40.108.71]:20996 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S264097AbUG1VWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:22:21 -0400
Message-ID: <41081771.1010307@opersys.com>
Date: Wed, 28 Jul 2004 17:15:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Scott Wood <scott@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       Philippe Gerum <rpm@xenomai.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IRQ threads
References: <20040727225040.GA4370@yoda.timesys>	 <4107CA18.4060204@opersys.com> <1091039327.747.26.camel@mindpipe>	 <4107FA93.3030801@opersys.com> <1091043218.766.10.camel@mindpipe>	 <41080540.9040401@opersys.com> <1091046954.791.27.camel@mindpipe>
In-Reply-To: <1091046954.791.27.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell wrote:
> No, of course not.  But please be more specific than 'everything I've
> seen from TimeSys is crap, I have talked to some of their clients who
> had $FOO problem'.  Your complaint was so general as to not be
> refutable.

I didn't say their stuff was crap. I said that "__My__ experience with
clients ...". IOW, I'm talking about cases where I was called on by
customers of mine who were using "stuff" (i.e. threaded int handlers
and mutexed-locks), and in practice I have found that the only entity
who could service this was the one that provided my clients with said
kernel. And from my point of view, this is indeed "abysmal" because
the whole point of using Linux is to be able to service your car at
any retailer.

You are correct in stating that the lack of details made the argument
hard to defend against, but I had a very nasty choice in writing this:
a) Either give enough detail, in which case my clients' confidentiality
would be in question.
b) Or shut up and let this go unanswered on the LKML.

> I could not agree more.  Your original post had a strong ad hominem
> flavor, which was my objection.  Of course you are free to attack
> anything at any time, on its technical merits, this is what engineers
> do.
> 
> I am interested in RT as well, I did not mean to imply that I don't find
> it a valid topic for discussion on LKML, but you have to admit that your
> post bordered on a troll.

I can see that it could be intrepreted as such. But keep in mind that I
was replying to Scott's _public_ posting of TimeSys' patch. IOW, there's
no way that I could claim that there would be lock-in in the future if
the patch did indeed make it in the kernel. The past tense was used on
purpose, and TimeSys have been very up-front about their intent of
getting this into the mainline.

My real argument was best summarized in the second paragraph, and what
I'm saying is that these approaches make the kernel's dynamic behavior
extremely complicated. And while they do contribute to making the
kernel's response time faster, they do not provided hard-rt, which is
what everyone is trying to get in the end anyway (either intentionally
or unintentionally.)

With that, let me respond to Bill's discussion on signle vs. N kernels
as that thread is the most likely to be fruitfull. I hope you'll agree.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

