Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbULJR5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbULJR5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbULJR5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:57:37 -0500
Received: from holomorphy.com ([207.189.100.168]:43922 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261777AbULJR5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:57:17 -0500
Date: Fri, 10 Dec 2004 09:57:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210175706.GS2714@holomorphy.com>
References: <20041201104820.1.patchmail@tglx> <20041210163247.GM2714@holomorphy.com> <1102697553.3306.91.camel@tglx.tec.linutronix.de> <20041210174938.GX16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210174938.GX16322@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 06:49:38PM +0100, Andrea Arcangeli wrote:
> Your patch was orthogonal to mine, so I didn't merge it. Go figure that
> every time I post something it gets splitted into trivial pieces, so
> it's a waste of time to try to merge any additional patch and post a
> final one since it'll never be final anyway.
> I am about to merge the things together for some other tree (not
> mainline), that is a worthwhile effort but with the split behaviour of
> mainline, for mainline it'd be a waste of time.
> One last thing worth discussing on my side is if we should worry about
> the tiny race between the watermark checks and the entering of the oom
> killing. In theory we could wrap the thing around a semaphore and close
> the race completely, though current code is simpler and as you find
> it works fine in practice.

The easy way to fix that issue is to take the whole diff and break off
pieces, with the remainder always as the last patch. That way the whole
set of changes stays pending and appears intact at the end of the series.

I will personally be held responsible for identifying the causes of
behavioral changes in the OOM killer, and am having to investigate
several instances of bad OOM killer behavior already, so I have to do
this anyway, and so it might as well be done for mainline.


-- wli
