Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbTJUSy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTJUSy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:54:57 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20499 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263232AbTJUSyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:54:55 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Circular Convolution scheduler
Date: 21 Oct 2003 18:44:53 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn3ur5$htf$1@gatekeeper.tmr.com>
References: <20031016015105.27987.qmail@email.com>
X-Trace: gatekeeper.tmr.com 1066761893 18351 192.168.12.62 (21 Oct 2003 18:44:53 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031016015105.27987.qmail@email.com>,
Clayton Weaver <cgweav@email.com> wrote:
| 
| > Ok, but what is "circular convolution scheduling"?
| 
| It was a vague idea that I had for integrating our current,
| more-or-less distributed system of priority scaling heuristics into a
| single state model and applying them all at once to a scheduling
| decision with a single matrix multiply. The motivation would be to
| engineer out unexpected interactions between different parts of the
| heuristic analyses that produce unpredicted (and potentially unwanted)
| behavior in the scheduler.
| 
| Ad hoc code is fast, but it depends on implementers being able to model
| the implied state machine in their imagination, with the implementation
| of it distributed across various code points in the scheduler. This
| makes isolated simulation and verification (proof that the scheduler
| does what we intend it to do) difficult, and we might get farther
| faster by having an implementation of these scheduling-relevant runtime
| heuristic analyses that allows us to reliably model scheduler state in
| the abstract.
| 
| I'm not saying that can't be done with the present system, it's just a
| lot harder to be sure that your model really reflects what is happening
| at runtime when you start with ad hoc code and try to model it than if
| you start with a model of a set of state transitions that does what you
| want and then implement/optimize the model.
| 
| As other people have pointed out, runtime scheduler performance is the
| trump card, and abstract verifiability that a scheduler (with heuristic
| priority scaling) meets a specified set of state transition constraints
| is not much help if you can't implement the model with code that
| performs at least as well as a scheduler with ad-hoc heuristics pasted
| in "wherever it looked convenient".
| 
| (But you are not likely to need to revert stuff very often with a
| heuristic-enhanced scheduler implemented from a verified formal model,
| because you aren't guessing what a code change is going to do to the
| state machine. You already know.)

As I noted elsewhere, this depends on the past being a predictor of the
future. I don't think we will see a major improvement in behaviour until
disk, CPU, and VM management are all integrated. Given that the
implementors don't agree on any one part of this I find that unlikely.
At least the scheduler folks are all civil and acknowledge the good
points of all work, resulting in progress even thought they are taking
different approaches. With that model perhaps integration of all
resource managers would be possible.

On the other hand... the pissing contest with suspend makes good soap
opera, but does not seem to have resulted in even one widely functional
implementation. The phrase "does not play well with others" comes to
mind.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
