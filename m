Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbTIXVzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbTIXVzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:55:32 -0400
Received: from hera.kernel.org ([63.209.29.2]:43184 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261587AbTIXVz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:55:27 -0400
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rfc: test whether a device has a partition table
Date: Wed, 24 Sep 2003 14:54:21 -0700
Organization: OSDL
Message-ID: <bkt3qe$imh$1@build.pdx.osdl.net>
References: <UTC200309242029.h8OKTo008219.aeb@smtp.cwi.nl>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: build.pdx.osdl.net 1064440462 19153 172.20.1.2 (24 Sep 2003 21:54:22 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 24 Sep 2003 21:54:22 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> As everyone knows it is a bad idea to let the kernel guess
> whether there is a partition table on a given block device,
> and if so, of what type.

So you say, and so you've said for a long time, but claiming that "everybody
knows it" is clearly not true.

In particular, I think that a kernel that doesn't do partitioning is quite
fundamentally broken. I'm sure others will agree.

If you have unusual cases (and let's face it, they don't much happen - we
have traditionally had _very_ few problems with getting things partitioned)
then you should be able to override them from user space and have user space
be able to tell the kernel about special partitions. 

And hey, surprise surprise, you can do exactly that.

Also, surprise surprise, pretty much nobody actually does it. Because the
defaults are so sane.

Repeat after me: make the defaults so sane that most people don't even
have to think about it.

In short, I think your first sentence (upon which the rest of the argument
depends) is just quite _fundamentally_ flawed.

                Linus
