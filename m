Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUKWRzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUKWRzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbUKWRx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:53:29 -0500
Received: from farley.sventech.com ([69.36.241.87]:47559 "EHLO
	farley.sventech.com") by vger.kernel.org with ESMTP id S261420AbUKWRwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:52:47 -0500
Date: Tue, 23 Nov 2004 09:52:46 -0800
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration) query support
Message-ID: <20041123175246.GD4217@sventech.com>
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com> <20041122713.g6bh6aqdXIN4RJYR@topspin.com> <20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com> <20041123064120.GB22493@kroah.com> <52hdnh83jy.fsf@topspin.com> <20041123072944.GA22786@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123072944.GA22786@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004, Greg KH <greg@kroah.com> wrote:
> On Mon, Nov 22, 2004 at 10:47:29PM -0800, Roland Dreier wrote:
> >     Greg> One comment, the file drivers/infiniband/core/cache.c has a
> >     Greg> license that is illegal due to the contents of the file.
> >     Greg> Please change the license of the file to GPL only.
> > 
> > ?? Can you explain this?  What makes that file special?
> 
> You are using a specific data structure that is only licensed to be used
> in GPL code.  By using it in code that has a non-GPL license (like the
> dual license you have) you are violating the license of that code, and
> open yourself up to lawsuits by the holder of that code.

I don't understand this. You seem to be assuming that everyone who
compiles this will be compiling it with the GPL version of the RCU code.
It seems to me that only the resulting object file must be licensed
under the GPL because of the fact it uses other GPL-only code (the RCU
code in the kernel)

As a standalone piece of code, wouldn't it be freely licensed however
the author wishes?

> There, can I be vague enough?  :)

Maybe it's the fact that you're being vague that is leading to my
confusion.

> To be straightforward, either drop the RCU code completely, or change
> the license of your code.  

Or compile against non-GPL RCU code, right?

> Hm, because of the fact that you are linking in GPL only code into this
> code (because of the .h files you are using) how could you ever expect
> to use a BSD-like license for this collected work?
> 
> Aren't licenses fun...

I don't mean to be nitpicking here, but I'm trying to figure out why you
interpreted the GPL like you did. I'd be venturing to guess that pretty
much everyone will be compiling against the GPL-only RCU code.

Just because the possibility exists that code can be compiled against
GPL-only code, doesn't necessarily mean that it too requires a GPL-only
license.

It seems like pretty much any code would fall into that category.

JE

