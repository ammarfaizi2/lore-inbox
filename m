Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUFXXwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUFXXwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUFXXwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:52:38 -0400
Received: from holomorphy.com ([207.189.100.168]:53133 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265928AbUFXXpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:45:40 -0400
Date: Thu, 24 Jun 2004 16:45:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, tiwai@suse.de,
       ak@suse.de, ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624234520.GU21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de, ak@muc.de,
	tripperda@nvidia.com, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624222150.GZ30687@dualathlon.random> <20040624223750.GP21066@holomorphy.com> <20040624232157.GD30687@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624232157.GD30687@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 01:21:57AM +0200, Andrea Arcangeli wrote:
> what you have to do is this:
> 1) swapoff -a (it must not fail!! it cannot fail if you run it first)
> 2) fill 130000K in pagecache, be very careful, not more than that, every
>    mbyte matters
> 3) run your program and allocate 904000K!!! (not 512M!!!)
> then keep using the machine until it lockups because it cannot reloate
> the anonymous memory from the 900M of lowmem to the 130M of highmem.
> But really I said you need >=2G to have a realistic chance of seeing it.
> So don't be alarmed you cannot reproduce on a 1G box by allocating 512M
> and with swap still enabled, you had none of the conditions that make it
> reproducible.
> I reproduced this dozen of times so I know how to reproduce it very
> well (amittedly not in 2.6 because nobody crashed on this yet).

This resembles the more sophisticated testcase I originally had in mind.
I'll be out for a couple of hours and then I'll fix this up.


-- wli
