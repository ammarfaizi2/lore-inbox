Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUCAJXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUCAJXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:23:13 -0500
Received: from pat.uio.no ([129.240.130.16]:50618 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261162AbUCAJXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:23:10 -0500
To: Peter Williams <peterw@aurema.com>
Cc: Joachim B Haga <c.j.b.haga@fys.uio.no>,
       Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.ftul5bl.nlk3pr@ifi.uio.no> <fa.cvc8vnj.ahebjd@ifi.uio.no>
From: Joachim B Haga <c.j.b.haga@fys.uio.no>
Date: 01 Mar 2004 10:18:23 +0100
In-Reply-To: <fa.cvc8vnj.ahebjd@ifi.uio.no>
Message-ID: <yydjvflp9b8g.fsf@galizur.uio.no>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <peterw@aurema.com> writes:

>> It seems to me that much of this could be solved if the user *were*
>> allowed to lower nice values (down to 0).
[snip]
>> to 10 (normal) to 20. Negative values could still be root-only.  So
>> why shouldn't this be possible? Because a greedy user in a
>> multi-user system would just run everything at max prio thus
>> defeating the purpose? Sure, that would be annoying but it would
>> have another solution ie. an entitlement based scheduler or
>> something.
 
> More importantly it would allow ordinary users to override root's
> settings e.g. if (for whatever reason) the sysadmin decided to
> renice a task to 19 (say) this modification would allow the owner of
> the task to renice it back to zero.  This is the reason that it
> isn't be allowed.

"You dirty cracker! A renice +19, that'll teach you!"  :-)

Seriously though, the same is true today, it's just a bit more
cumbersome. Restart the task and you're back to 0. If the sysadmin
wants to stop that, he'll renice your shell. In which case you login
again. And so on.

My point is that this is a problem (annoying user) which has better
solutions (ranging from a polite e-mail to deluser) because renice
won't stop him.

And it's not a *security* concern, as long as the lower values are
still reserved.

I would say the benefit is very small (I mean: who has ever relied on
it?) compared to the difficulties created for users.


> Peter

Joachim
