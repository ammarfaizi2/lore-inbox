Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTLBSDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTLBSDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:03:00 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:10464 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262566AbTLBSC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:02:57 -0500
Subject: Re: XFS for 2.4
From: Russell Cattelan <cattelan@xfs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0312021346530.13692-100000@logos.cnet>
References: <Pine.LNX.4.44.0312021346530.13692-100000@logos.cnet>
Content-Type: text/plain
Message-Id: <1070388083.3060.19.camel@naboo.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-1mdk 
Date: Tue, 02 Dec 2003 12:01:23 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-02 at 09:50, Marcelo Tosatti wrote:
> On Tue, 2 Dec 2003, Russell Cattelan wrote:
> 
> > On Tue, 2003-12-02 at 05:18, Marcelo Tosatti wrote:
> > [snip] 
> > > Also I'm not completly sure if the generic changes are fine and I dont
> > > like the XFS code in general.
> > Ahh so the real truth comes out.
> > 
> > 
> > Is there a reason for your sudden dislike of the XFS code?
> 
> I always disliked the XFS code. 
> 
> > or is this just an arbitrary general dislike for unknown or unstated
> > reasons?
> 
> I dont like the style of the code. Thats a personal issue, though, and 
> shouldnt matter.
True... so are you basing your decision to not include it on some thing
technical or just your personal feeling? which in your words "shouldn't
matter" 
> 
> The bigger point is that XFS touches generic code and I'm not sure if that 
> can break something.
We have taken great pain to make sure the generic code changes do not
logically change any code paths.
Everything is either new code paths only used by XFS or very careful
conditionals on flags only set by XFS.
Some of the changes that were made to generic code was done because it
was the right way to it. It would certainly would be possible pull many
of the needed changes back into fs/xfs but then there would be
duplicated  code that could potentially be wrong if somebody changes the
generic routines. (core locking differences in different kernels have
bitten us in the past, RedHat kernel are good at this)

If you really have issues with any of the core changes please make some
suggestions it's possible things could be done differently.


> 
> Why it matters so much for you to have XFS in 2.4 ? 
Well if you follow that logic then why did any of the other filesystems
go in? in fact why would any new subsystems go in?
Everybody maintaining a large pile of patches should be sufficient to
call something linux?

Take anybody list of reasons for inclusion into core.
Acceptance
Larger audience, possible exposure in other projects that won't look
at XFS due the extra work of merging their patches with ours
Ease the support work needed to integrate with all the different distro
More feed back for interfaces




