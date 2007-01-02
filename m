Return-Path: <linux-kernel-owner+w=401wt.eu-S1755254AbXABEYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbXABEYJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 23:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbXABEYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 23:24:09 -0500
Received: from THUNK.ORG ([69.25.196.29]:57080 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254AbXABEYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 23:24:08 -0500
Date: Mon, 1 Jan 2007 23:24:04 -0500
From: Theodore Tso <tytso@mit.edu>
To: * * <richardvoigt@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Message-ID: <20070102042404.GA15718@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	* * <richardvoigt@gmail.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org> <2e59e6970612292119o38d96583ie245cb140adaafba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e59e6970612292119o38d96583ie245cb140adaafba@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 11:19:49PM -0600, * * wrote:
> Was this patch tested?
> 
> > static inline void show_node(struct zone *zone)
> > {
> >        if (NUMA_BUILD)
> >-               printk("Node %d ", zone_to_nid(zone));
> >+               printk(KERN_INFO, "Node %d ", zone_to_nid(zone));
> 
> Here there is a comma after KERN_INFO, which does not occur elsewhere.

Thanks for noticing the typo.  Yes, it's been tested and in my tree
for a while, but not on a NUMA system, so I didn't notice the problem.  :-)

						- Ted
