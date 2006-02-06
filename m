Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWBFSpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWBFSpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWBFSpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:45:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20194 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932146AbWBFSpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:45:20 -0500
Date: Mon, 6 Feb 2006 10:45:13 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, bharata@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <200602061931.13953.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602061043440.16829@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <200602061912.31508.ak@suse.de>
 <Pine.LNX.4.62.0602061023580.16829@schroedinger.engr.sgi.com>
 <200602061931.13953.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andi Kleen wrote:

> > If node 0 is exhausted then you have an OOM situation.
> 
> No - it could just need to free some cleanable pages first. That's
> a long way before going OOM.

Then node 0 still has memory available. So you suspect zone_reclaim?
  
> > > but with a full free local node that code path is never triggered)
> > 
> > Wamt me to test the OOM path for mbind?
> I already know it oopses - someone else reported that. If you feel
> motivated feel free to fix.

We also have a minor issue with huge pages. If the pools are exhausted 
then the kernel will terminate the application with Bus Error.

