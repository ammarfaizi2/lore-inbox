Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTIYK50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTIYK50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:57:26 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:56081 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261802AbTIYK5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:57:24 -0400
Date: Thu, 25 Sep 2003 12:57:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
Message-ID: <20030925105719.GA21508@win.tue.nl>
References: <20030924235041.GA21416@win.tue.nl> <Pine.LNX.4.44.0309241710380.1688-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309241710380.1688-100000@home.osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 05:18:15PM -0700, Linus Torvalds wrote:

> So? There's a bug, and we'll fix it.

Yes - that is what I was in the process of doing.
Things go wrong, we add a few heuristics and they'll
work right again, most of the time.

> I know you don't want the kernel to partition at all.
> But I don't see your point. 

I did not want to start this particular discussion.

But now that you bring it up, let me say the usual things.
Probably there is no need to answer - there are no new
insights or new proposals here.

Letting mount or the kernel guess the type of the filesystem to mount
is bad. If the kernel or mount guesses wrong the result can be fs
corruption and kernel crash. So the right approach is to always
give a -t option to mount and a rootfstype= boot option to the kernel.

But most people don't, and survive. And I maintain mount and
over time a system of heuristics has been built into mount
to make it rather likely that a guess will be correct.

The partition situation is similar but a bit worse.
We have the second half: likely guesses,
but we lack the first half: correctness with certainty.

What probably will happen as a result of this episode is
that the likelihood of certain guesses is improved a bit.
But I wouldnt mind the option of having certainty
instead of probability. Userspace that tells the kernel,
instead of letting the kernel probe.

Andries

