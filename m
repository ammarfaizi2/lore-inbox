Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268733AbTBYUmJ>; Tue, 25 Feb 2003 15:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268734AbTBYUmJ>; Tue, 25 Feb 2003 15:42:09 -0500
Received: from [195.223.140.107] ([195.223.140.107]:61062 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268733AbTBYUmH>;
	Tue, 25 Feb 2003 15:42:07 -0500
Date: Tue, 25 Feb 2003 21:52:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225205233.GW29467@dualathlon.random>
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random> <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random> <20030225201023.GG10396@holomorphy.com> <20030225202335.GU29467@dualathlon.random> <20030225204616.GH10396@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225204616.GH10396@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 12:46:16PM -0800, William Lee Irwin III wrote:
> On Tue, Feb 25, 2003 at 12:10:23PM -0800, William Lee Irwin III wrote:
> >> I'd just bite the bullet and do the anonymous rework. Building
> >> pte_chains lazily raises the issue of needing to allocate in order to
> 
> On Tue, Feb 25, 2003 at 09:23:35PM +0100, Andrea Arcangeli wrote:
> > note that there is no need of allocate to free.
> 
> I've no longer got any idea what you're talking about, then.

Were we able to release memory w/o rmap: yes.

Can we do it again: yes.

Can we use a bit of the released memory to release further memory more
efficiently with rmap: yes.

I'm not saying it's easy to implement that, but the problem that we'll
need memory to release memory doesn't exit, since it also never existed
before rmap was introduced into the kernel. Sure, the early stage of the
swapping would be more cpu-intensive, but that is the feature.

Andrea
