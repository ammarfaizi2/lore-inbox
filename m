Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTGBUpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTGBUpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:45:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:17070 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264490AbTGBUpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:45:44 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 2 Jul 2003 23:00:06 +0200 (MEST)
Message-Id: <UTC200307022100.h62L06a22118.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: Re: [PATCH] cryptoloop
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From Andrew.Morton@digeo.com  Wed Jul  2 22:03:49 2003

    > (Usually I plan a track and submit individual steps.
    > When they get applied I continue.
    > If not, there is no need to waste time on the rest.)

    As someone who is on the receiving end of this process I must say that it
    is not comfortable.

    It really helps to be able to see the whole thing laid out all at the same
    time.  So we can see that it works, so that we can see that the end result
    is the right one, etc.

    Whereas receiving a long drawn out trickle of patches is quite confusing. 
    One doesn't know where it is leading, nor where it will end, nor when to
    get down and actually start testing it, etc.  Nor whether this ongoing
    churn is stomping on someone else's development effort.

    And there is the risk that you get halfway through and then suddenly "no
    way, we don't want to do that".  Then what?  Argue?  Revert?

No, the point of such a series is that each patch does something
clearly defined, is an improvement even when the author dies the
next day so that all further work is lost.

You should never accept a patch that makes things worse and is only
justified by a future one.

    So for everyone except the guy who's writing the code it is best to have
    all the work in place and reviewable at the same time.

No. Some changes are too large for that.

    For the author, yes, there is a risk that more code than necessary will be
    tossed away.  We can minimise that by discussing things beforehand, getting
    understanding and agreement from the relevant people on the intended
    direction.  I think we have done that for cryptoloop.  We still have not
    really done it for 64-bit dev_t.

Yes, now that you remind me, that is also an interesting topic.
About discussing beforehand - search the archives and you'll see
immense amounts of discussion on large dev_t.
You'll always find me willing to discuss details.

Now suppose one wants a large dev_t. Some people do.
Then several steps are needed. One of these steps
is the addition of the mknod64 system call.
That is a nice small isolated step - part of the necessary
user space interface. It can be done independently of any
other steps. It was submitted, but is not in the present
kernel. Why not? I do not recall anybody pointing out problems.

I think some of these large dev_t steps were somewhat urgent, because
they were prerequisites for glibc changes. But they didnt happen.
Linus took a bit from me, and you submitted a few steps from me,
and then nothing. OK.

Dave compared the patch submission process to TCP/IP.
I agree, and go into exponential backoff. Try again after two weeks,
three months, a year and a half.
But if you want we can restart that particular series of patches.
Or discuss, if there are things to discuss.

Andries
