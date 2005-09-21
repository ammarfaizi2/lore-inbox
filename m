Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVIURFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVIURFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVIURFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:05:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:41448 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751248AbVIURFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:05:14 -0400
Date: Wed, 21 Sep 2005 10:05:09 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <43319111.1050803@engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0509211000470.10480@schroedinger.engr.sgi.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Jay Lan wrote:

> > 5. Please add appropriate CONFIG, dummy macros etc., so that no time
> >    is wasted on these updates in all the vanilla systems which have no
> >    interest in them - but maybe Christoph already has that well in hand.
> 
> It is used in enhanced system accounting. An obvious CONFIG would be
> CONFIG_BSD_PROCESS_ACCT.

Right. Make all the data fields and code dependent on an appropriate 
CONFIG_XXX macro. We talked about that a couple of weeks ago as AFAIK.

I had a look at Frank's patch and it does not seem to touch the critical 
paths. Jay: Can you verify that the changes do not affect critical paths 
and that accounting is still working in the right way?
