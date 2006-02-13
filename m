Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWBMRVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWBMRVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWBMRVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:21:30 -0500
Received: from silver.veritas.com ([143.127.12.111]:19062 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932127AbWBMRV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:21:29 -0500
Date: Mon, 13 Feb 2006 17:21:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
cc: Ryan Richter <ryan@tau.solarneutrino.net>, Brian King <brking@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, James.Bottomley@steeleye.com,
       rolandd@cisco.com, Kai.Makisara@kolumbus.fi, dougg@torque.net,
       osst@riede.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
In-Reply-To: <200602122229.33244.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0602131713160.8102@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
 <20060211223810.GA12064@tau.solarneutrino.net>
 <Pine.LNX.4.61.0602121838050.15101@goblin.wat.veritas.com>
 <200602122229.33244.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Feb 2006 17:21:10.0297 (UTC) FILETIME=[E1DF5890:01C630C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2006, Andi Kleen wrote:
> On Sunday 12 February 2006 19:57, Hugh Dickins wrote:
> 
> > So I'd like to believe that your x86_64-gart-dma-merge.patch is the
> > final answer to this issue, and see it go forward into 2.6.16-rc -
> > if you feel it's ready now.  Then we can just throw away those driver
> > patches I posted a week ago (including the "ipr" one of this thread).
> 
> Yes, it's probably ready to go. I will submit it later if Andrew doesn't
> beat me.

And you got the fix into 2.6.16-rc3, last on the train: many thanks.
Andrew, please now drop from -mm my unnecessary, driver-complicating

ib-dont-doublefree-pages-from-scatterlist.patch
ipr-dont-doublefree-pages-from-scatterlist.patch
osst-dont-doublefree-pages-from-scatterlist.patch

Thanks,
Hugh
