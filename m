Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWCFAOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWCFAOP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 19:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWCFAOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 19:14:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51139 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750700AbWCFAOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 19:14:15 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Greg KH <gregkh@suse.de>, Nicholas Miell <nmiell@comcast.net>,
       Greg KH <greg@kroah.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
References: <20060227190150.GA9121@kroah.com>
	<20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de>
	<Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
	<20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org>
	<20060301003452.GG23716@kroah.com> <1141175870.2989.17.camel@entropy>
	<20060302042455.GB10464@suse.de>
	<m1fylwc1c8.fsf@ebiederm.dsl.xmission.com>
	<20060305232326.GC20768@kvack.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 05 Mar 2006 17:12:48 -0700
In-Reply-To: <20060305232326.GC20768@kvack.org> (Benjamin LaHaise's message
 of "Sun, 5 Mar 2006 18:23:26 -0500")
Message-ID: <m1y7zoa0sf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Sun, Mar 05, 2006 at 09:17:59AM -0700, Eric W. Biederman wrote:
>> So if we go down this path can we make this functional Documentation?
>> 
>> In particular can we have per process/per interface kinds of flags that
>> allow access to experimental subsystems?
>
> Sounds fragile.  It doesn't help the real problem that APIs need to be well 
> designed.

Yes.  But it does sure stick out like a sore thumb in a patch or when
you try to use it.  Especially if you do something evil like require
user space to pass in a hash of the kernel code implementing the
interface.  So even the smallest changes of the implementation break
user space.

>> If the developer has to jump through an extra hoop to use an interface
>> we have clearly documented this is unsupported and will change in the
>> future.  Anything else can be easy to miss.
>
> At this point if it ends up anywhere near the tools people need to use on 
> a regular basis, it will not have accomplished anything.  APIs should be 
> reasonably stable, often extensible, by the time they hit the kernel.  The 
> problem with any sort of 'experimental' API is that it probably means the 
> code is not ready to be in the kernel.  Wrapping it up in flags doesn't 
> stop people from using it and tieing code to the interface; not shipping 
> code that isn't fully baked does.

I don't know all of the answers.  But if we are going to document something
is half backed, let have the code behave like the interface is half backed
and at least try to keep it out of the hands of most applications.

To a large extent I agree that we should have fully backed interfaces in
the stable kernel.  Is that always possible?  How often do things not show
up until they are being used in the real world?  Is it possible to
find those things out in experimental branches?

Eric
