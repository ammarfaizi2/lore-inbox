Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWCFAou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWCFAou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 19:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWCFAou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 19:44:50 -0500
Received: from kanga.kvack.org ([66.96.29.28]:23461 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751151AbWCFAot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 19:44:49 -0500
Date: Sun, 5 Mar 2006 19:39:33 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg KH <gregkh@suse.de>, Nicholas Miell <nmiell@comcast.net>,
       Greg KH <greg@kroah.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060306003933.GE20768@kvack.org>
References: <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org> <20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org> <20060301003452.GG23716@kroah.com> <1141175870.2989.17.camel@entropy> <20060302042455.GB10464@suse.de> <m1fylwc1c8.fsf@ebiederm.dsl.xmission.com> <20060305232326.GC20768@kvack.org> <m1y7zoa0sf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y7zoa0sf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 05:12:48PM -0700, Eric W. Biederman wrote:
> Yes.  But it does sure stick out like a sore thumb in a patch or when
> you try to use it.  Especially if you do something evil like require
> user space to pass in a hash of the kernel code implementing the
> interface.  So even the smallest changes of the implementation break
> user space.

I thought the decree / consensus was that You Can't Do That.  Yes, some 
people want to, but that doesn't mean we should let them.

> I don't know all of the answers.  But if we are going to document something
> is half backed, let have the code behave like the interface is half backed
> and at least try to keep it out of the hands of most applications.

Why should it be merged into base then?  If it's in the mainstream kernel, 
it needs to be reasonably solid (which has always been a precondition for 
merging patches, aiui).

> To a large extent I agree that we should have fully backed interfaces in
> the stable kernel.  Is that always possible?  How often do things not show
> up until they are being used in the real world?  Is it possible to
> find those things out in experimental branches?

There's a big difference between those interfaces that have had a decent 
amount of thought put into them and those which have not.  Take ext2, 
which is a good example as it can still mount a filesystem made back in 
the early '90s today, yet it has undergone a huge amount of change.  What 
was the secret?  The superblock has a few flags for compatible and 
incompatible features.

API design is not rocket science, it just requires effort.  So long as we 
keep beating the drums about how important this is, people will learn and 
we will get better at catching these issues during review.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
