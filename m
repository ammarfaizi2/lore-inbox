Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbULNXd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbULNXd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbULNX27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:28:59 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16515 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261776AbULNXYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:24:14 -0500
Date: Tue, 14 Dec 2004 17:24:02 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
In-Reply-To: <19030000.1103054924@flay>
Message-ID: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com>
 <9250000.1103050790@flay> <20041214191348.GA27225@wotan.suse.de>
 <19030000.1103054924@flay>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Martin J. Bligh wrote:

> --On Tuesday, December 14, 2004 20:13:48 +0100 Andi Kleen <ak@suse.de> wrote:
> 
> > I originally was a bit worried about the TLB usage, but it doesn't
> > seem to be a too big issue (hopefully the benchmarks weren't too
> > micro though)
> 
> Well, as long as we stripe on large page boundaries, it should be fine,
> I'd think. On PPC64, it'll screw the SLB, but ... tough ;-) We can either
> turn it off, or only do it on things larger than the segment size, and
> just round-robin the rest, or allocate from node with most free.

Is there a reasonably easy-to-use existing infrastructure to do this?
I didn't find anything in my examination of vmalloc itself, so I gave
up on the idea.

And just to clarify, are you saying you want to see this before inclusion
in mainline kernels, or that it would be nice to have but not necessary?

Thanks,
Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
