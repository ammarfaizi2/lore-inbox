Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUF0DFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUF0DFw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 23:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267243AbUF0DFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 23:05:52 -0400
Received: from [12.177.129.25] ([12.177.129.25]:22211 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S266539AbUF0DFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 23:05:51 -0400
Date: Sat, 26 Jun 2004 23:59:23 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, linux-kernel@vger.kernel.org
Subject: Re: Inclusion of UML in 2.6.8
Message-ID: <20040627035923.GB8842@ccure.user-mode-linux.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it> <20040626130945.190fb199.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626130945.190fb199.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 01:09:45PM -0700, Andrew Morton wrote:
> I have no problem plopping it into -mm, as long as it doesn't cause me too
> much pain.  It did cause patch management pain last time, but probably
> whatever is was interacting with has now been merged up so it'll be OK.

The tty_init patch is gone, so ghash is the only nasty bit outside the arch
tree.

> But for a merge into mainline we do need to get down and do some work on it
> - reintroducing ghash.h would not be welcome (I though Jeff was going to
> eliminate that?) 

Yeah, it will be, but requires a bit of surgery.

> and last time we looked the patch had some blockdev
> drivers in it which were doing antiquated 2.4 things.

Not sure about that.  hch complained about the cow driver last time, which
can disappear until there is something that vaguely works.

> 
> Generally, UML in 2.6 seems to have fallen behind fairly seriously and at
> some stage we need to go through the exercise of splitting the patch up,
> reviewing and fixing all the bits and feeding it in.

Yup.  I've come to the conclusion that I've painted myself into a corner a
bit with BK and my currently style of working.  I'm looking at quilt, and
I'm pondering taking all the changes since the last time Linus merged UML
(2.5.69 or something), and breaking them up into sensible patches.

That'll be a lot of work, but I think it's something that needs doing.

				Jeff
