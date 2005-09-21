Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVIURMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVIURMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVIURMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:12:25 -0400
Received: from gold.veritas.com ([143.127.12.110]:3611 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751253AbVIURMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:12:24 -0400
Date: Wed, 21 Sep 2005 18:12:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jay Lan <jlan@engr.sgi.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <43319111.1050803@engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 17:12:24.0259 (UTC) FILETIME=[A26E9130:01C5BECF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Jay Lan wrote:
> Hugh Dickins wrote:
> > 
> > 4. If you've noticed a regression, you must be one of the elite that
> > knows
> > what these counters are used for: nothing in the kernel.org tree does.
> > Please add a comment saying what it is that uses them and how, so
> > developers can make better judgements about how best to maintain them.
> > 
> > 5. Please add appropriate CONFIG, dummy macros etc., so that no time
> > is wasted on these updates in all the vanilla systems which have no
> > interest in them - but maybe Christoph already has that well in hand.
> 
> It is used in enhanced system accounting. An obvious CONFIG would be
> CONFIG_BSD_PROCESS_ACCT.
> 
> However, since the CONFIG flag is almost always Yes, people would need
> to turn it off if they do not want system accounting. Would that be
> OK?

Christoph will know the issue better than I.  But I'd say no, that's
not OK.  You have some out of tree "enhanced system accounting" which
has been granted the privilege of hooks within the mainline kernel:
they should be disabled unless a CONFIG option is switched on, which
your accounting patch can do.  And the (mainline) Kconfig help entry
for that CONFIG option should point us to the source of your package.

Hugh
