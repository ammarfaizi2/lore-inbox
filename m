Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVABPNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVABPNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVABPNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:13:14 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:39295 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261258AbVABPNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:13:04 -0500
Date: Sun, 2 Jan 2005 16:11:47 +0100
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20050102151147.GA1930@suse.de>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com> <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com> <20041225190710.GZ771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225190710.GZ771@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25 2004, William Lee Irwin III wrote:
> On Sat, 25 Dec 2004, Andrea Arcangeli wrote:
> >> the first place? If that happens it means you're under a lowmem
> >> shortage, something you apparently ruled out when you said
> >> lowmem_reserve couldn't help your workload.
> 
> On Sat, Dec 25, 2004 at 12:59:10PM -0500, Rik van Riel wrote:
> > Let me explain a 3rd time:
> [...]
> > If you have any more questions as to why the bug happens, don't
> > hesitate to ask and I'll explain you why this problem happens.
> 
> This is an old and well-known problem.
> 
> Lifting the artificial lowmem restrictions on blockdev mappings
> (thereby nuking mapping->gfp_mask altogether) would resolve a number of
> problems, not that anything making that much sense could ever happen.

It should be lifted for block devices, it doesn't make any sense.
mapping->gfp_mask is still needed for things like loop though, so it
cannot be nuked.

-- 
Jens Axboe

