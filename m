Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUGNDua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUGNDua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUGNDua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:50:30 -0400
Received: from holomorphy.com ([207.189.100.168]:410 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265348AbUGNDu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:50:28 -0400
Date: Tue, 13 Jul 2004 20:50:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040714035023.GC3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Peter Zaitsev <peter@mysql.com>,
	linux-kernel@vger.kernel.org
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714031701.GT974@dualathlon.random>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 05:17:01AM +0200, Andrea Arcangeli wrote:
> this is a well known 2.6 oom-killer problem w/o swap. Not the worst one,
> I mentioned the worst one here just a few weeks ago:
> 	http://groups.google.com/groups?q=g:thl1518647992d&dq=&hl=en&lr=&ie=UTF-8&selm=fa.i50b3kk.p0qsjs%40ifi.uio.no
> the only fix at the moment is to use 2.4 with oom killer disabled (the
> same issue could happen with 2.4 too). even if it would work better than
> the above the oom killer will still get screwed by mlock and it simply
> cannot know how much lowmem is freeable leading to deadlock instead of
> -ENOMEM with syscalls if you fill the whole lowmem zone.
> I fixed everything related to oom in 2.4 some year back, now need to
> port to 2.6.
> workaround is to add swap in 2.6, but in some condition it'll still
> underpeform compared to 2.4 due the lack of the zone-reserve-ratio algo.

Can we try to get a bit more specific? I suspect the reason this stuff
isn't getting much traction is because it's too broad to correlate to
internal kernel problems or the userspace cases that trigger them. I
think once we get that kind of documentation/changelogging we should be
able to get the pieces in.


-- wli
