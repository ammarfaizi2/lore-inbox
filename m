Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSA2HLE>; Tue, 29 Jan 2002 02:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSA2HKz>; Tue, 29 Jan 2002 02:10:55 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:57860 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S288830AbSA2HKr>;
	Tue, 29 Jan 2002 02:10:47 -0500
Message-Id: <5.1.0.14.0.20020129173507.01fa2a00@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Jan 2002 18:10:43 +1100
To: <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: A modest proposal -- We need a patch penguin
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rob Landley <landley@trommello.org>
In-Reply-To: <Pine.LNX.4.33.0201282153160.10900-100000@penguin.transmeta
 .com>
In-Reply-To: <200201290446.g0T4kZU31923@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:00 PM 28/01/02 -0800, Linus Torvalds wrote:
>I think it helps a lot to have people pick up patches that nobody else
>wants to maintain, and to gather them up. Andrea does that to some degree.
>But it is _much_ better if you have somebody who is a point-man for
>specific areas.
>
>The problem with an overall guy is that there can't be too many of them.
>The very thing you are _complaining_ about is in fact that there are a
>number of over-all guys without clear focus, which only leads to confusion
>about who handles what.
>
>Clarity is good.

Perhaps what we need is a patch maintenance system? Now I'm not talking 
CVS, I'm talking about something that is, in reality, pretty simple. 
Something that does the following:

  1. People can submit patches, which are given a unique patch ID.
  2. Notifications of patches are passed on to (from a selection or 
automatic detection):
    a. A module maintainer
    b. A section maintainer
    c. A tree maintainer
    d. Linus Torvalds
  3. The patches can be reviewed, and immediately:
    a. Dropped with a canned reject message
    b. Dropped with a custom reject message
    c. Dropped but archived for later review
    d. Suspended/Skipped for later review
    e. Redelegated up/down to a maintainer
    f. Accepted, pending testing
  4. If someone wants to know why their patch is not being accepted:
    a. They can easily look up the current status
    b. There is a common reference place
    c. If their patch is rejected, they can ask for more detail

Yes it's a tiny patch tracking system. The idea is that if we can make the 
thing simple to use, simple to understand, and simple to maintain, people 
will actually use it. Submitting patches by mail in freeform, while 
reasonably simple, leads to overall complication, and may take longer to 
sort through.

It doesn't have to be that involved. A shell script (or perl) could happily 
do the submission job (which could all still be done by mail, however in a 
more formatted approach). It'd also be simple to do some sort of web 
interface if anyone was actually inclined.

Later, maybe, we can have it track possible conflicts (between waiting 
patches) and flag them as such so the maintainer is aware of the fact.

If we can automate some simple, key parts of the kernel maintenance, then 
this could help immensely, and let everyone get on with the job than the 
hassle. Maybe we want to re-invent this wheel, maybe we don't.

PS: Remember this is only a suggestion. I'm not infallible (is anyone?), 
all I can do is give the big guy ideas (even bad ones), so he can make 
better decisions. *grin*


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

