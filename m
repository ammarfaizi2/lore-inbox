Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSKJCnh>; Sat, 9 Nov 2002 21:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbSKJCnh>; Sat, 9 Nov 2002 21:43:37 -0500
Received: from [195.223.140.107] ([195.223.140.107]:22661 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S263143AbSKJCnf>;
	Sat, 9 Nov 2002 21:43:35 -0500
Date: Sun, 10 Nov 2002 03:50:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Solved 2.4.20pre11aa1/2.4.20rc1aa1 Agpgart/Radeon crash. [was: Re: 2.4.20pre11aa1]
Message-ID: <20021110025008.GF2544@x30.random>
References: <20021018145204.GG23930@dualathlon.random> <200210260003.06285.harisri@bigpond.com> <200210312147.42836.harisri@bigpond.com> <200211092034.39100.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211092034.39100.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2002 at 08:34:39PM +1100, Srihari Vijayaraghavan wrote:
> Hello Andrea,
> 
> > So I believe either 1* or 2* patches are introducing the issue.
> 
> Got it. The 10_x86-fast-pte2 patch is introducting the instability.

Great job! Many thanks! This reduces the bug a whole lot. I will think
on Monday what could be going wrong with that patch, in the meantime
just try to run (slower ;) with it backed out, to be sure it's really
such one (nevertheless if I had to guess right now I would say this most
certainly is triggering a bug somewhere else, unlikely that such patch
is really containing a bug, the patch is kind of obviously correct and
it is a so much stressed codepath that everybody would reproduce it if
that was the case, one of the reason I could never guess such patch
could be the interesting one for your case without your useful binary
search).

Andrea
