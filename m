Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTGBVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTGBVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:22:29 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:49545 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264499AbTGBVWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:22:08 -0400
Date: Wed, 2 Jul 2003 14:31:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-Id: <20030702143113.41873743.akpm@digeo.com>
In-Reply-To: <UTC200307022100.h62L06a22118.aeb@smtp.cwi.nl>
References: <UTC200307022100.h62L06a22118.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 21:36:33.0281 (UTC) FILETIME=[01C26710:01C340E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> Now suppose one wants a large dev_t. Some people do.

<thumps table> 2.6 will support a large dev_t.

We need to make this happen.

> Then several steps are needed. One of these steps
> is the addition of the mknod64 system call.
> That is a nice small isolated step - part of the necessary
> user space interface. It can be done independently of any
> other steps. It was submitted, but is not in the present
> kernel. Why not? I do not recall anybody pointing out problems.

This precisely illustrates my point.

mknod64() and several other dev_t patches (ext2 and ext3 support,
especially) have stalled in -mm for months.  The reason why I have not
moved ahead with them is that I am waiting to see the rest of the work.

Because it could be that Al has different ideas, or that someone else gets
down and completes the work and wants to do it differently.  I simply do
not know.

Or it could be that nobody ends up doing the dev_t work at all, in which
case we end up with a pointless syscall sitting there.

> I think some of these large dev_t steps were somewhat urgent, because
> they were prerequisites for glibc changes. But they didnt happen.
> Linus took a bit from me, and you submitted a few steps from me,
> and then nothing. OK.

The patches stopped!

Please, if you want to finish off the dev_t work, send the rest of the
patches.  We'll shake them down, allow Al to be rude about them, break
people's builds with them, crash their kernels, etc.  When it is all settled
down and everyone is sufficiently happy, shoot them across to Linus.

That's why I run -mm, so people can make these large and evolving changes,
have them reviewed and understood without breaking Linus's tree and thereby
impacting everyone.


> Dave compared the patch submission process to TCP/IP.
> I agree, and go into exponential backoff. Try again after two weeks,
> three months, a year and a half.
> But if you want we can restart that particular series of patches.
> Or discuss, if there are things to discuss.

Sounds great, let's do it.  Send patches against the current -mm, copy
Greg, Christoph and Al on them and let's wrap this thing up.

The only problem of which I'm aware is that they seem to still break
devicemapper a bit, but the fixes for that seem to be just a few days away.

