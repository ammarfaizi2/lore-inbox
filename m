Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWAJNpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWAJNpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWAJNpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:45:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31039 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750875AbWAJNpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:45:49 -0500
Date: Tue, 10 Jan 2006 14:47:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Byron Stanoszek <gandalf@winds.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110134742.GD3389@suse.de>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601100840400.9511@winds.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Byron Stanoszek wrote:
> On Tue, 10 Jan 2006, Jens Axboe wrote:
> 
> >>yes, i made it totally configurable in 2.4 days: 1:3, 2/2 and 3:1 splits
> >>were possible. It was a larger patch to enable all this across x86, but
> >>the Kconfig portion was removed a bit later because people _frequently_
> >>misconfigured their kernels and then complained about the results.
> >
> >How is this different than all other sorts of misconfigurations? As far
> >as I can tell, the biggest "problem" for some is if they depend on some
> >binary module that will of course break with a different page offset.
> >
> >For simplicity, I didn't add more than the 2/2 split, where we could add
> >even a 3/1 kernel/user or a 0.5/3.5 (I think sles8 had this).
> 
> I prefer setting __PAGE_OFFSET to (0x78000000) on machines with 2GB of RAM.
> This seems to let the kernel use the full 2GB of memory, rather than just
> 1920-1984 MB (at least back in 2.4 days).

That might indeed be a good idea for 2G/2G, in the same sense that
0xC0000000 is a silly default because of the many 1G machines out there.

-- 
Jens Axboe

