Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVLCVEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVLCVEO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVLCVEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:04:14 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:25306 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751186AbVLCVEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:04:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=txh00ht57dHWigL1H3mpQKiuBw9ssudfqbxO3p+2SrEAaQQV/+Wly+duj17FhM+9cyI4oaZII4qvaIQ3Evvw9Yi1+FCfPcmYoL3Oh/d5pluNdI9pPl6YSwttfs9aC45IzND9RuNEn26HhJHbf+A2/iGxIFY8VlWmgTJfmcYCyks=
Message-ID: <f0cc38560512031304w7858aacdja15cfe28bdb675d9@mail.gmail.com>
Date: Sat, 3 Dec 2005 22:04:07 +0100
From: "M." <vo.sinh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Cc: Adrian Bunk <bunk@stusta.de>, Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <1133639835.16836.24.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
	 <1133620264.2171.14.camel@localhost.localdomain>
	 <20051203193538.GM31395@stusta.de>
	 <1133639835.16836.24.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sat, 2005-12-03 at 20:35 +0100, Adrian Bunk wrote:
> >
> > But yes, what I suggest is partially a step back in a way that it
> > doesn't conflict with the current 2.6.17+ development model.
> >
> > Well, if taking the best from the old style development is improving
> > things that isn't something bad.
>
> You seem to be saying that the current development model is unacceptable
> for users for whom older kernel work just fine, and the main risk in
> upgrading is regression.  But the new development model is clearly
> needed for those users whose needs are not met by the old kernel, say
> due to unacceptable soft RT performance or unsupported hardware.
>
> But it's wrong to try to evenly balance the needs of these two classes
> of users, because the first class has another option - they can stick
> with the old kernel that works for them.  The second class of users has
> no other option, so their needs should be given greater weight.
>
> Lee
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Mhhh something much simpler:

Use the current development model between 2.6.N and 2.6.N+1. This
means the current dev model would be used like NOW, BUT changing the
versioning scheme in a way which reflects the 6months release plans.
TRYING TO EXPLAIN THINGS BETTER: You could skip the version scheme
change and do something like:

EXAMPLE:

2.6.14 - ok let's plan 3/4/whatever releases in the next 6 months with
those major new features:
 - A
 - B
 - C

then: .15, .16 like every 2.6 kernel, same dev model, same everything
(erhm not every just like the latest releases, ok)
.18 would be MAINLY stabilization: no device model changes, no
networking change, and so on (but i think it would be ok new drivers
since they cant be disabled or simply not used)

and .19 would come out  months after the .14 release

it's not a stable/devel or 2.6/2.7 or better 2.4/2.5 scheme (even a
2.6/2.7 scheme almost exists with main tree/-mm tree atm) or old stuff
under a different point of view BUT it's the SAME current dev model
applied to every release EXCEPT for the last one BEFORE the 6months
timeline.

what does it means: no one says nothing is unacceptable, it means
things could be better for distros/users/external kernel projects by
doing something that could be called a two-layers model:

--------------------
Linus & co. "hey, let's write down the major features for the next 6
months and plan things a little"
--------------------
Other kernel developers "I would like to get in X, Y and Z. Let's do
it 2.6.x style."
--------------------

The changed versioning scheme just reflects the 6months release ciclye
idea. fullstop.

trying to clarify again:

> What you're suggesting sounds just like going back to the old style of
> development where 2.<even>.x is stable, and 2.<odd>.x is development.
> You might as well just suggest that after 2.6.16, we fork to 2.7.0, and
> 2.6.17+ will be stable increments like we always used to do.

every 2.6.N.x release would be the SAME as a 2.6.x release. The entire
6months cycle puts in some time/features/stability boundaries on top
of the existent model. Finally, those stability boundaries would be
planned every 6months assuring the best fit of the model with
developers, distros and users needs.


hope I clarified,
Michele
