Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265883AbUFXWze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUFXWze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUFXWzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:55:33 -0400
Received: from holomorphy.com ([207.189.100.168]:27533 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265886AbUFXWvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:51:41 -0400
Date: Thu, 24 Jun 2004 15:51:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, tiwai@suse.de,
       ak@suse.de, ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624225121.GS21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de, ak@muc.de,
	tripperda@nvidia.com, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624220823.GO21066@holomorphy.com> <20040624224529.GA30687@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624224529.GA30687@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 12:45:29AM +0200, Andrea Arcangeli wrote:
> Luckily this problem doesn't fall in this scenario and it's trivial to
> reproduce if you've >= 2G of ram. I still have here the testcase google
> sent me years ago when this problem seen the light during 2.4.1x. They
> used mlock, but it's even simpler to reproduce it with a single malloc +
> bzero (note: no mlock). The few mbytes of lowmem left won't last long if
> you load some big app after that.

Well, there are magic numbers here we need to explain to get a testcase
runnable on more machines than just x86 boxen with exactly 2GB RAM.
Where do the 2GB and 1GB come from? Is it that 1GB is the size of the
upper zone?


-- wli
