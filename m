Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUKOASg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUKOASg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 19:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUKOASg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 19:18:36 -0500
Received: from ozlabs.org ([203.10.76.45]:61872 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261385AbUKOASY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 19:18:24 -0500
Subject: Re: [PATCH] handle quoted module parameters
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: yiding_wang@agilent.com, doogie@debian.org, arjan@infradead.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41968935.30701@osdl.org>
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F85D4@wcosmb07.cos.agilent.com>
	 <41968935.30701@osdl.org>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 11:18:18 +1100
Message-Id: <1100477898.7381.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-13 at 14:22 -0800, Randy.Dunlap wrote:
> yiding_wang@agilent.com wrote:
> >>There is *no* difference between:
> >>foo="111 222 333"\ 444' 555'
> >>and
> >>foo='111 222 333 444 555'
> >>and
> >>foo="111 222 333 444 555'
> > 
> > 
> > But there is a difference between foo="111 222 333" and "foo=111 222 333". The new patch is changing from former to later.
> 
> Actually the patch allows (or _should allow_) either format for quote
> marks.  I didn't remove the older code, just added support for the
> case of quote marks as "foo=this is a test".

Yes, I have no fundamental problem with the patch, but it'd need
thorough testing (eg. with __setup) since this area has broken before.

> Why is the module param length limit of 1024 a problem?

The 1024 test is there because we want to limit how much we output
through sysfs.  We could up it to PAGE_SIZE-1.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

