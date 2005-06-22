Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVFVB5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVFVB5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVFVB5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:57:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:28383 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262510AbVFVB51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:57:27 -0400
Date: Wed, 22 Jun 2005 03:57:24 +0200
From: Andi Kleen <ak@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Andi Kleen <ak@suse.de>, Alexander Lyamin aka FLX <flx@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050622015724.GN14251@wotan.suse.de>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B8C0FF.2010800@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 06:38:07PM -0700, Hans Reiser wrote:
> V4 has a mailing list, and a large number of testers who read the code
> and comment on it.   V4 has been reviewed and tested much more than V3
> was before merging.   Given that we sent it in quite some time ago, your
> suggestion that an additional review by unspecified additional others be
> a requirement for merging seems untimely.  Do you see my point of view
> on this?

The point of the merge review is that people who are familiar with the existing
Linux code double check that the way your code interfacts
with the rest of the kernel is sane, does not have obvious bugs and follows the 
existing good practice. 

Once the code is in mainline it will get maintained and fixed when needed, 
but to make this possible without undue work on the mainline hackers it is needed
to do a full review first. 

AFAIK reiserfs has not gotten such a full review yet.

Also good reviewers are rare so it is not a good idea to be picky here.

> Unspecified others doing a review, well, who knows, I will surely take
> the time to consider what is said by them though..... 
> 
> I would prefer to not get reviews from authors of other filesystems who
> prefer their own code, skim through our code without taking the time to
> grok our philosophy and approach in depth, and then complain that our
> code is different from what they chose to write, and think that our
> changing to be like them should be mandated.  I will not name names here....

Someone qualified to review a new file system for inclusion will have need necessary 
some experience in Linux file systems, and that can be hardly gotten without ever 
having touched one.  So you will have to live with other file system authors 
commenting on your code.

The main philosophy that is of concern here is also the philosophy of the 
core VFS and other kernel interfaces.

> Some of the suggestions on our mailing list are great, some reflect a
> lack of 5 years working with our code, perhaps I should feed our mailing
> list into the linux kernel mailing list so that people on the kernel
> mailing list are more aware that we exist and are active?

Nobody doubts that you are active. Just there are doubts that your
code follows the Linux coding standards enough to not be a undue
mainteance burden in mainline.  A review with the following changes
could probably fix that.

-Andi

