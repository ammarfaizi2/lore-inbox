Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUFYCji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUFYCji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 22:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbUFYCji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 22:39:38 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58528
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266169AbUFYCjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 22:39:32 -0400
Date: Fri, 25 Jun 2004 04:39:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, nickpiggin@yahoo.com.au,
       tiwai@suse.de, ak@suse.de, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040625023936.GG30687@dualathlon.random>
References: <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624220823.GO21066@holomorphy.com> <20040624224529.GA30687@dualathlon.random> <20040624225121.GS21066@holomorphy.com> <20040624160945.69185c46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624160945.69185c46.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 04:09:45PM -0700, Andrew Morton wrote:
> this sort of thing, simply because nobody seems to be hitting the problems.

nobody is hitting the problems because if this problem triggers the
machine starts slowly swapping and shrinking the vfs and it eventually
relocate the highmem. the crpilling down of the vfs caches as well isn't
a good thing and it will not be noticeable by anybody.

If they would be truly running without swap they would be hitting these
problems very fast. But everybody has swap.
