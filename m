Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753945AbWKHDEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbWKHDEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 22:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbWKHDEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 22:04:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:65164 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753945AbWKHDEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 22:04:50 -0500
Date: Wed, 8 Nov 2006 14:04:29 +1100
From: David Chinner <dgc@sgi.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
Message-ID: <20061108030429.GQ11034@melbourne.sgi.com>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com> <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 11:36:49PM +0100, Mikulas Patocka wrote:
> >>Does one Linux kernel run on system with 1024 cpus? I guess it
> >>must fry spinlocks... (or even lockup due to spinlock livelocks)
> >
> >The SGI Altix can have 2048 CPUs.
> 
> And does it run one image of Linux? Or more images each on few cpus?

One image.

> How do they solve problem with spinlock livelocks?

By replacing contended spinlocks withsleeping locks, using no-lock
techniques (e.g. per-cpu) or changing the algorithm to remove the
contention point.

w.r.t filesystem locking scalability, you should read this paper:

http://oss.sgi.com/projects/xfs/papers/ols2006/ols-2006-paper.pdf

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
