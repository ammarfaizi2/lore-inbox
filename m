Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVCGNCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVCGNCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVCGNCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:02:34 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56863
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261157AbVCGNC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:02:28 -0500
Date: Mon, 7 Mar 2005 14:02:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/5] setup_per_zone_lowmem_reserve() oops fix
Message-ID: <20050307130227.GQ8880@opteron.random>
References: <200503042117.j24LHGrx017967@shell0.pdx.osdl.net> <422C0C5D.3060404@yahoo.com.au> <20050307002048.51aac96b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307002048.51aac96b.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 12:20:48AM -0800, Andrew Morton wrote:
> I haven't thought about it yet, but there must be some way to avoid leaving
> huge amounts of lowmem free.  It should be OK to allow lowmem to be fully
> used, as long as there's sufficent reclaimable stuff in there - slab,
> blockdev pagecache, etc.  (Assuming nothing sane mmaps blockdevs.  INND
> does).  Dunno....

Then mlock will have to unmap and migrate the cache, it's just much more
complicated, but it's certainly doable.
