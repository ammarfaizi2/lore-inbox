Return-Path: <linux-kernel-owner+w=401wt.eu-S1751207AbWLMVxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWLMVxI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWLMVxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:53:07 -0500
Received: from dvhart.com ([64.146.134.43]:48355 "EHLO dvhart.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbWLMVxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:53:07 -0500
X-Greylist: delayed 1214 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 16:53:06 EST
Message-ID: <45807182.1060408@mbligh.org>
Date: Wed, 13 Dec 2006 13:32:50 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com> <20061213210219.GA9410@suse.de>
In-Reply-To: <20061213210219.GA9410@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Dec 13, 2006 at 12:38:05PM -0800, Michael K. Edwards wrote:
>> Seriously, though, please please pretty please do not allow a facility
>> for "going through a simple interface to get accesses to irqs and
>> memory regions" into the mainline kernel, with or without toy ISA
>> examples.
> 
> Why?  X does it today :)

Umm ... and you're trying to use the current X model for a positive
example of what we should be doing? that's ... interesting.

>> Embedded systems integrators have enough trouble with chip vendors who
>> think that exposing the device registers to userspace constitutes a
>> "driver".
> 
> Yes, and because of this, they create binary only drivers today.  Lots
> of them.  All over the place.  Doing crazy stupid crap in kernelspace.

So let's come out and ban binary modules, rather than pussyfooting
around, if that's what we actually want to do.

It comes down to a question of whether we have enough leverage to push
them into doing what we want, or not - are we prepared to call their
bluff?

The current half-assed solution of chipping slowly away at things by
making them EXPORT_SYMBOL_GPL one by one makes little sense - would
be better if we actually made an affirmative decision one way or the
other. And yes, I know which side of that argument you'd fall on ;-)

> Again, X does this today, and does does lots of other applications.
> This is a way to do it in a sane manner, to keep people who want to do
> floating point out of the kernel, and to make some embedded people much
> happier to use Linux, gets them from being so mad at Linux because we
> keep changing the internal apis, and makes me happier as they stop
> violating my copyright by creating closed drivers in the kernel.

I don't see how this really any different than letting them create
GPL shims to export data to binary modules (aside from all the legal
wanking over minutae details, which really isn't that interesting).

M.

