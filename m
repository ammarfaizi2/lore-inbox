Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUCIUtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUCIUty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:49:54 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:40203 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261964AbUCIUtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:49:51 -0500
Message-ID: <404E3118.8020608@techsource.com>
Date: Tue, 09 Mar 2004 16:03:20 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Grigor Gatchev <grigor@serdica.org>
CC: "Theodore Ts'o" <tytso@mit.edu>, Mike Fedyk <mfedyk@matchmail.com>,
       Christer Weinigel <christer@weinigel.se>, linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
References: <Pine.LNX.4.44.0403091953001.32687-100000@lugburz.zadnik.org>
In-Reply-To: <Pine.LNX.4.44.0403091953001.32687-100000@lugburz.zadnik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Grigor Gatchev wrote:
> 
> On Mon, 8 Mar 2004, Theodore Ts'o wrote:
> 
> 
>>On Mon, Mar 08, 2004 at 02:23:43PM +0200, Grigor Gatchev wrote:
>>
>>>Also, does "think API changes, nothing generalised *at all*" mean anything
>>>different from "think code, no design *at all*"? If this is some practical
>>>joke, it is not funny. (I can't believe that a kernel programmer will not
>>>know why design is needed, where is its place in the production of a
>>>software, and how it should and how it should not be done.)
>>
>>So give us a design.  Make a concrete proposal.  Tell us what the
>>API's --- with C function prototypes --- should look like, and how we
>>should migrate what we have to your new beautiful nirvana.
> 
> 
> Aside from the beautiful nirvana irony, that is what I am trying not to
> do. For the following reason:
> 
> When you have to produce a large software, you first design it at a global
> level. Then you design the subsystems. After that, their subsystems. And
> so on, level after level. At last, you design the code itself. Only then
> you write the code actually.
> 
[snip]

As one of the people who has been told "show me the code" before, let me 
try to help you understand what the kernel developers are asking of you.

First of all, they are NOT asking you to do the bottom-up approach that 
you seem to think they're asking for.  They're not asking you to show 
them code which was not the result of careful design.  No.  Indeed, they 
all agree with you that careful planning is always a good idea, in fact 
critical.

Rather, what they are asking you to do is to create the complete 
top-down design _yourself_ and then show it to them.  If you do a 
complete design that is well-though-out and complete, then code (ie. 
function prototypes) will naturally and easily fall out from that. 
Present your design and the resultant code for evaluation.

Only then can kernel developers give you meaningful feedback.  You'll 
notice that the major arguments aren't about your design but rather 
about there being a lack of anything to critique.  If you want feedback, 
you must produce something which CAN be critiqued.

Follow the scientific method:
1) Construct a hypothesis (the document you have already written plus 
more detail).
2) Develop a means to test your hypothesis (write the code that your 
design implies).
3) Test your hypothesis (present your code and design for criticism).
4) If your hypothesis is proven wrong (someone has a valid criticism), 
adjust the hypothesis and then goto step (2).

Perhaps you have not done this because you feel that your "high level" 
design (which you have presented) is not complete.  The problem is that, 
based on what you have presented, no one can help you complete it. 
Therefore, the thing to do is to complete it yourself, right or wrong. 
Only when you have actually done something which is wrong can you 
actually go about doing things correctly.  Actually wrong is better than 
hypothetically correct.

Then, you may be thinking that this will result in more work, because 
you'll create a design and write come code just to find out that it 
needs to be rewritten.  But this would be poor reasoning.  It would be 
extremely unrealistic to think that you could create a design a priori 
that was good and correct, before you've ever done anything to test its 
implications.

Mostly likely, you would go through several iterations of your spec and 
the implied code before it's acceptable to anyone, regardless of how 
good it is to begin with.  Just think about how many iterations Con and 
Nick have gone through for their interativity schedulers; they've had 
countless good ideas, but only experimentation and user criticism could 
tell them what really worked and what didn't.  And these are just the 
schedulers -- you're talking about the architecture of the whole kernel!


