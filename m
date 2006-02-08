Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWBHXy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWBHXy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWBHXy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:54:28 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:202 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422661AbWBHXy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:54:27 -0500
Date: Wed, 8 Feb 2006 15:54:15 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <20060208154332.715d617d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602081547180.5184@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <200602082201.12371.ak@suse.de> <20060208130351.fc1c759c.pj@sgi.com>
 <200602082221.35671.ak@suse.de> <20060208133909.183f19ea.akpm@osdl.org>
 <Pine.LNX.4.62.0602081526060.5184@schroedinger.engr.sgi.com>
 <20060208154332.715d617d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Andrew Morton wrote:

> > If a caller cannot handle NULL then __GFP_NOFAIL has to be set, right?
> 
> That would assume non-buggy code.  I'm talking about the exercising of
> hitherto-unused codepaths.  We've fixed many, many pieces of code which
> simply assumed that kmalloc(GFP_KERNEL) succeeds.  I doubt if many such
> simple bugs still exist, but there will be more subtle ones in there.

We could add __GFP_NOFAIL to kmem_getpages in slab.c to insure that 
kmalloc waits rather than return NULL. Also a too drastic measure right?

