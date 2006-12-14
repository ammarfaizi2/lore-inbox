Return-Path: <linux-kernel-owner+w=401wt.eu-S1751772AbWLNFnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWLNFnb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 00:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWLNFnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 00:43:31 -0500
Received: from dvhart.com ([64.146.134.43]:49694 "EHLO dvhart.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbWLNFna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 00:43:30 -0500
Message-ID: <4580E37F.8000305@mbligh.org>
Date: Wed, 13 Dec 2006 21:39:11 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 13 Dec 2006, Greg KH wrote:
>> Numerous kernel developers feel that loading non-GPL drivers into the
>> kernel violates the license of the kernel and their copyright.  Because
>> of this, a one year notice for everyone to address any non-GPL
>> compatible modules has been set.
> 
> Btw, I really think this is shortsighted.
> 
> It will only result in _exactly_ the crap we were just trying to avoid, 
> namely stupid "shell game" drivers that don't actually help anything at 
> all, and move code into user space instead.

I don't think pushing the drivers into userspace is a good idea at all,
that wasn't what I was getting at. Pushing the problem into a different
space doesn't fix it. IMHO, we're not a microkernel, and drivers for
hardware belong in the kernel.

Whether we allow binary kernel modules or not, I don't think we should
allow an API for userspace drivers - obviously that's not my call, it's
yours, but at least I don't want my opinion / intent misinterpreted.

 > What was the point again?
 >
 > Was the point to alienate people by showing how we're less about the
 > technology than about licenses?

The point of banning binary drivers would be to leverage hardware
companies into either releasing open source drivers, or the specs for
someone else to write them. Whether we have that much leverage is
debatable ... I suspect we do in some cases and not in others. It'll
cause some pain, as well as some gain, but I think we'd live through
it pretty well, personally.

The details of the legal minutiae are, I feel, less interesting than
what goal we want to acheive. If we decided to get rid of binary
drivers, we could likely find a way to achieve that. Is it a worthwhile
goal?

I've done both Linux support, where binary drivers are involved, before,
as well as supporting Sequent's Dynix/PTX in the face of a similar
situation with CA Unicenter. It makes life extremely difficult, if not
impossible for a support organisation, for fairly obvious and well known
reasons. When there are two binary drivers from different vendors in
there, any semblence of support becomes farcical.

The Ubuntu feisty fawn mess was a dangerous warning bell of where we're
going. If we don't stand up at some point, and ban binary drivers, we
will, I fear, end up with an unsustainable ecosystem for Linux when
binary drivers become pervasive. I don't want to see Linux destroyed
like that.

I don't think the motive behind what we decide to do should be decided
by legal stuff, though I'm sure we'd have to wade through that to
implement it. It's not about that ... it's about what kind of ecosystem
we want to create, and whether that can be successful or not. Indeed,
there are good arguments both for and against binary drivers on that
basis.

But please can we have the pragmatic argument about what we want to
achieve, and why ... rather than the legal / religious arguments about
licenses? The law is a tool, not an end in itself.

If you don't feel it's legitimate to leverage that tool to achieve a
pragmatic end, fair enough. But please don't assume that the motivation
was legal / religious, at least not on my part.

Perhaps, in the end, we will decide we'd like to ban binary drivers,
but can't. Either for pragmatic reasons (e.g. we don't have enough
leverage to create the hardware support base), or for legal ones
(we don't think it's enforcable). But we seem to be muddled between
those different reasons right now, at least it seems that way to me.

I think allowing binary hardware drivers in userspace hurts our ability
to leverage companies to release hardware specs. The 'grey water' of
binary kernel drivers convinces a lot of them to release stuff, and
Greg and others have pushed that cause, all credit to them. In one way,
it does make the kernel easier to support, but I don't think it really
helps much to make a supportable *system*.

M.
