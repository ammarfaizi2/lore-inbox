Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266781AbUFXRjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266781AbUFXRjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266779AbUFXRjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:39:02 -0400
Received: from holomorphy.com ([207.189.100.168]:12683 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266781AbUFXRiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:38:50 -0400
Date: Thu, 24 Jun 2004 10:38:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624173827.GH21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
	Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
	discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624173236.GP30687@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624173236.GP30687@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 07:32:36PM +0200, Andrea Arcangeli wrote:
> I did quite a few times and it was successfully merged in 2.4. Now I'd
> need to forward port to 2.6.
> I recall I recommended Andrew to merge the lower_zone_reserve_ratio
> at some point during 2.5 or early 2.6 but apparently he implemented this
> other thing called sysctl_lower_zone_protection. Note that now that I
> look more into it, it seems sysctl_lower_zone_protection and
> lower_zone_reserve_ratio have very little in common, I'm glad
> sysctl_lower_zone_protection is disabled.  sysctl_lower_zone_protection
> is just an improvement to the algorithm I dropped from 2.4 when
> lowmem_zone_reserve_ratio was merged.  So in short enabling
> sysctl_lower_zone_protection won't help, sysctl_lower_zone_protection
> should be dropped enterely and replaced with lower_zone_reserve_ratio.

Could you refer me to an online source (e.g. Message-Id or URL) where
the deficiencies in the incremental min and/or lower_zone_protection
that the zone-to-zone watermarks address are described in detail?


-- wli
