Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTDVQsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTDVQsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:48:13 -0400
Received: from holomorphy.com ([66.224.33.161]:5020 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263225AbTDVQrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:47:21 -0400
Date: Tue, 22 Apr 2003 09:58:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Andrea Arcangeli <andrea@suse.de>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422165842.GG8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030422154248.GI8978@holomorphy.com> <Pine.LNX.4.44.0304221152500.10400-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304221152500.10400-100000@devserv.devel.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 11:55:00AM -0400, Ingo Molnar wrote:
> well, i have myself reproduced 30+ secs worth of pid-alloc related lockups
> on my box, so it's was definitely not a fata morgana, and the
> pid-allocation code was definitely quadratic near the PID-space saturation
> point.
> There might be something else still biting your system, i'd really be
> interested in hearing more about it. What workload are you using to
> trigger it?

ISTR it being something on the order of running 32 instances of top(1),
one per cpu, and then trying to fork().

I think this is one of those that needs num_cpus_online() >= 32, and
possibly in combination with strong NUMA effects. I'm willing to accept
large delays with respect to addressing this unless my employer/funding
source makes equipment more readily available.

Seriously -- if those who could need and/or fund the fix don't see it
as a large enough problem to invest in a fix for, I see no need to
impose on the Linux kernel community to do so.

Otherwise, given sufficient hardware access, I'd be more than willing
to run regular tests on whatever patches you care to send me. As of now
I'm not even able to do so, regardless of willingness.

(e.g. access to 64GB hw, even while in-house, has been extremely limited)


-- wli
