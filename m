Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWA0CRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWA0CRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 21:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWA0CRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 21:17:40 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:60173 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1030213AbWA0CRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 21:17:39 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <hyc@symas.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Thu, 26 Jan 2006 18:16:22 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEBHJLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <43D930C6.40201@symas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 26 Jan 2006 18:13:18 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 26 Jan 2006 18:13:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:

> > First, there's the as-if issue. You cannot write a program
> > that can print
> > "non-compliant" with the behavior you claim is non-compliant that is
> > guaranteed not to do so by the standard because there is no way
> > to know that
> > another thread is blocked on the mutex (except for PI mutexes).

> The exception here demolishes this argument, IMO.

	You're saying the authors of the standard intended that clause to be read
in light of the possibility of PI mutexes?! That's just nuts.

> Moreover, if the
> unlocker was a lower priority thread and there are higher priority
> threads blocked on the mutex, you really want the higher priority thread
> to run.

	Yes, I agree.

> > 	Second, there's the plain langauge of the standard. It says
> > "If X is so at
> > time T, then Y". This does not require Y to happen at time T. It is X
> > happening at time T that requires Y, but the time for Y is not
> specified.

> > 	If a law says, for example, "if there are two or more bids
> > with the same
> > price lower than all other bids at the close of bidding, the
> > first such bid
> > to be received shall be accepted". The phrase "at the close of bidding"
> > refers to the time the rule is deteremined to apply to the
> > situation, not
> > the time at which the decision as to which bid to accept is made.

> The time at which the decision takes effect is immaterial; the point is
> that the decision can only be made from the set of options available at
> time T.
>
> Per your analogy, if a new bid comes in at time T+1, it can't have any
> effect on which of the bids shall be accepted.

	Only because of the specifics of this analogy. If the rule said "if there
are two or more such bids with the same price at the close of bidding, the
winning bad shall be determined by the board of directors policy", nothing
prevents the board of directors from having a policy of going back to the
bidders and asking if they can lower their bids further.

	Nothing prevents them from rebidding the project if they want. In other
words, it doesn't place any restrictions on what the board can do.

> > 	Third, there's the ambiguity of the standard. It says the "sceduling
> > policy" shall decide, not that the scheduler shall decide. If
> > the policy is
> > to make a conditional or delayed decision, that is still perfectly valid
> > policy. "Whichever thread requests it first" is a valid
> > scheduler policy.

> I am not debating what the policy can decide. Merely the set of choices
> from which it may decide.

	Which is a restriction not found in the standard. A "policy" is a way of
deciding, not a decision. Scheduling policy can be to let whoever asks first
get it.

	DS


