Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbUKOWLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUKOWLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKOWJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:09:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57243 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261466AbUKOWHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:07:53 -0500
Date: Mon, 15 Nov 2004 16:07:29 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       "Adam J. Richter" <adam@yggdrasil.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <Pine.LNX.4.44.0411111929370.2939-300000@localhost.localdomain>
Message-ID: <Pine.SGI.4.58.0411151604580.20302@kzerza.americas.sgi.com>
References: <Pine.LNX.4.44.0411111929370.2939-300000@localhost.localdomain>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004, Hugh Dickins wrote:

> The first (against 2.6.10-rc1-mm5) being my reversion of NULL sbinfo
> in shmem.c, to make it easier for others to add things into sbinfo
> without having to worry about NULL cases.  So that goes back to
> allocating an sbinfo even for the internal mount: I've rounded up to
> L1_CACHE_BYTES to avoid false sharing, but even so, please test it out
> on your 512-way to make sure I haven't screwed up the scalability we
> got before - thanks.  If you find it okay, I'll send to akpm soonish.

OK, tried it at 508P (the last 4P had a hardware problem).  The
performance results are all in line with what we'd accomplished
with NULL sbinfo, so the patch is good by me.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
