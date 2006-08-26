Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWHZQJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWHZQJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWHZQJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:09:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27910 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030218AbWHZQJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:09:45 -0400
Date: Sat, 26 Aug 2006 14:36:23 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH 6/6] nfs: Enable swap over NFS
Message-ID: <20060826143622.GA5260@ucw.cz>
References: <20060825153709.24254.28118.sendpatchset@twins> <20060825153812.24254.9718.sendpatchset@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825153812.24254.9718.sendpatchset@twins>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Now that NFS can handle swap cache pages, add a swapfile method to allow
> swapping over NFS.
> 
> NOTE: this dummy method is obviously not enough to make it safe.
> A more complete version of the nfs_swapfile() function will be present
> in the next VM deadlock avoidance patches.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

We probably do not want to enable functionality before it is safe...

Also swsusp interactions will be interesting. (Rafael is working on
swapfile support these days).
						Pavel
-- 
Thanks for all the (sleeping) penguins.
