Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbUKCJBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUKCJBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUKCJBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:01:22 -0500
Received: from cantor.suse.de ([195.135.220.2]:22978 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261490AbUKCJBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:01:18 -0500
Date: Wed, 3 Nov 2004 10:01:12 +0100
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Brent Casavant <bcasavan@sgi.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <20041103090112.GJ8907@wotan.suse.de>
References: <239530000.1099435919@flay> <Pine.LNX.4.44.0411030826310.6096-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411030826310.6096-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 08:44:32AM +0000, Hugh Dickins wrote:
> On Tue, 2 Nov 2004, Martin J. Bligh wrote:
> > 
> > Another way might be a tmpfs mount option ... I'd prefer that to a sysctl
> > personally, but maybe others wouldn't. Hugh, is that nuts?
> 
> Only nuts if I am, I was going to suggest the same: the sysctl idea seems
> very inadequate; a mount option at least allows the possibility of having
> different tmpfs files allocated with different policies at the same time.
> 
> But I'm not usually qualified to comment on NUMA matters, and my tmpfs
> maintenance shouldn't be allowed to get in the way of progress.  Plus
> I've barely been attending in recent days: back to normality tomorrow.

If you want to go more finegraid then you can always use numactl
or even libnuma in the application.  For a quick policy decision a sysctl 
is fine imho.

-Andi
