Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVCJQaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVCJQaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCJQ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:26:08 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:44247 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262706AbVCJQYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:24:14 -0500
Date: Thu, 10 Mar 2005 11:24:35 -0500
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: tridge@samba.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: make -j4 gets stuck w/ ccache over NFS - solved!
Message-ID: <20050310162435.GE12787@fieldses.org>
References: <20041207022429.GA5295@jupiter.solarsys.private> <16822.44167.836780.288332@samba.org> <20050310054737.GA27656@jupiter.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310054737.GA27656@jupiter.solarsys.private>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 12:47:37AM -0500, Mark M. Hoffman wrote:
> Thanks for the suggestions.  It wasn't very important to me so I didn't
> make time to follow up on it.  I was just playing w/ ccache at the time.
> 
> Finally I noticed this patch from -mm1... and it solves the problem.
> 
> nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
> 
> How I tested: I applied the first 12 patches in 2.6.11-mm1; the above
> mentioned was last - couldn't reproduce the bug.  When I unapplied just
> that one, I saw it again.
> 
> original bug report:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110238645132535&w=3
> 
> Greg: have you considered this one for 2.6.11.x?

That patch depends on 3 of the previous 4 patches.  Taken together I
doubt they meet the criteria for 2.6.11.x.

It's probably possible to write a shorter and more obvious one-off fix
just for that tree, but I'm not sure it's worth it for a bug that, while
it's obviously extremely annoying for some workloads, doesn't quite
reach the level of, say, a root exploit.

--b.
