Return-Path: <linux-kernel-owner+w=401wt.eu-S1751615AbXACE5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbXACE5X (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 23:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbXACE5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 23:57:23 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49906
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752356AbXACE5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 23:57:22 -0500
Date: Tue, 02 Jan 2007 20:57:21 -0800 (PST)
Message-Id: <20070102.205721.98552646.davem@davemloft.net>
To: dan@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Contents of core dumps
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070103020228.GA28762@nevyn.them.org>
References: <20060406.153518.60508780.davem@davemloft.net>
	<20060406.221807.114721185.davem@davemloft.net>
	<20070103020228.GA28762@nevyn.them.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jacobowitz <dan@debian.org>
Date: Tue, 2 Jan 2007 21:02:28 -0500

> On Thu, Apr 06, 2006 at 10:18:07PM -0700, David S. Miller wrote:
> > How about something like the following patch?  If it's executable
> > and not written to, skip it.  This would skip the main executable
> > image and all text segments of the shared libraries mapped in.
> 
> I've been going through GDB test failures (... again...) and I'm down
> to a respectably small number on x86_64, but this is one of the
> remaining ones.  I don't suppose there's been any change since we
> discussed this in April?

Not to my knowledge.

> Does Linux need knobs for this?

I don't think so.

The current behavior is very non-intuitive.

As a person who hacks gdb, the kernel, and the interactions between
them extensively, it took even me quite a while to track down this
problem.

Imagine some less skilled person trying to analyze a core dump
expecting the necessary information to be there and being unable
to figure out why?

So I'd say we should just put this change in, as-is.  It fixes bugs,
and in all the time that has passed since my initial posting there
has not been any serious dissent.
