Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTJUUMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbTJUUMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:12:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48518 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263343AbTJUUMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:12:19 -0400
Date: Tue, 21 Oct 2003 16:15:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Circular Convolution scheduler
In-Reply-To: <bn3ur5$htf$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.53.0310211607110.19990@chaos>
References: <20031016015105.27987.qmail@email.com> <bn3ur5$htf$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003, bill davidsen wrote:

> In article <20031016015105.27987.qmail@email.com>,
> Clayton Weaver <cgweav@email.com> wrote:
> |
> | > Ok, but what is "circular convolution scheduling"?
> |
> | It was a vague idea that I had for integrating our current,
> | more-or-less distributed system of priority scaling heuristics into a
> | single state model and applying them all at once to a scheduling
> | decision with a single matrix multiply. The motivation would be to
> | engineer out unexpected interactions between different parts of the
> | heuristic analyses that produce unpredicted (and potentially unwanted)
> | behavior in the scheduler.
> |
> | Ad hoc code is fast, but it depends on implementers being able to model
> | the implied state machine in their imagination, with the implementation
> | of it distributed across various code points in the scheduler. This
> | makes isolated simulation and verification (proof that the scheduler
> | does what we intend it to do) difficult, and we might get farther
> | faster by having an implementation of these scheduling-relevant runtime
> | heuristic analyses that allows us to reliably model scheduler state in
> | the abstract.
> |
> | I'm not saying that can't be done with the present system, it's just a
> | lot harder to be sure that your model really reflects what is happening
> | at runtime when you start with ad hoc code and try to model it than if
> | you start with a model of a set of state transitions that does what you
> | want and then implement/optimize the model.
> |
> | As other people have pointed out, runtime scheduler performance is the
> | trump card, and abstract verifiability that a scheduler (with heuristic
> | priority scaling) meets a specified set of state transition constraints
> | is not much help if you can't implement the model with code that
> | performs at least as well as a scheduler with ad-hoc heuristics pasted
> | in "wherever it looked convenient".
> |
> | (But you are not likely to need to revert stuff very often with a
> | heuristic-enhanced scheduler implemented from a verified formal model,
> | because you aren't guessing what a code change is going to do to the
> | state machine. You already know.)
>
> As I noted elsewhere, this depends on the past being a predictor of the
> future. I don't think we will see a major improvement in behaviour until
> disk, CPU, and VM management are all integrated. Given that the
> implementors don't agree on any one part of this I find that unlikely.
> At least the scheduler folks are all civil and acknowledge the good
> points of all work, resulting in progress even thought they are taking
> different approaches. With that model perhaps integration of all
> resource managers would be possible.
>
> On the other hand... the pissing contest with suspend makes good soap
> opera, but does not seem to have resulted in even one widely functional
> implementation. The phrase "does not play well with others" comes to
> mind.
>

Isn't scheduling something that's supposed to
be deterministic? I think your "nice marketing
name that sounds very technical" scheduler would
put policy in absolutely the wrong place.

We need less heuristics in the kernel, not more.
Already, we don't know anything about the time
necessary to guarantee much of anything. This
impacts data-base programs that are trying to
find safe intervals, guaranteed to be restartable.

Also, the "circular convolution theorem", from
which I would guess the name was scrounged, does
not relate in any imaginable way to kernel scheduling.
The name is a misnomer when used in this context.
That theorem states simply that what can be done
with a DFT can be undone using the same mechanism.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


