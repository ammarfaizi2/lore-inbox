Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266860AbUFXSNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266860AbUFXSNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266863AbUFXSNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:13:38 -0400
Received: from holomorphy.com ([207.189.100.168]:31115 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266860AbUFXSNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:13:31 -0400
Date: Thu, 24 Jun 2004 11:13:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624181311.GJ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
	Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
	discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624173236.GP30687@dualathlon.random> <20040624173827.GH21066@holomorphy.com> <20040624180256.GR30687@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624180256.GR30687@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:02:56PM +0200, Andrea Arcangeli wrote:
> I'm talking to Andrew about this very issue since december 2002, so I
> mostly giveup except for a few reminders like this one today.
> http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=20021206145718.GL1567%40dualathlon.random&prev=/groups%3Fq%3Dlinus%2Bgoogle%2Bfix%2Bmin%2Bwatermarks%26hl%3D
> I'm confident as people starts to run into the zone inbalance with 2.6
> and as google upgrades to 2.6, eventually lowmem_zone_reserve_ratio will
> be forward ported to 2.4.26 to 2.6.  I'm not the guy with >4G of ram
> anyways, so it won't be myself having troubles with this ;).
> Furthermore if you have some swap, the VM can normally relocate the
> stuff (you've to be quite unlucky to be filled by pure ptes in the
> lowmem zone but it can happen too, but certainly not in my or Andrew's
> boxes where we have not more than 2M of ptes anytime allocated).

This sounds like the more precise fix would be enforcing a stricter
fallback criterion for pinned allocations. Pinned userspace would need
zone migration if it's done selectively like this.

Thanks.


-- wli
