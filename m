Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263739AbTDNVe3 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTDNVe3 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:34:29 -0400
Received: from ns.suse.de ([213.95.15.193]:16135 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263739AbTDNVe0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:34:26 -0400
Date: Mon, 14 Apr 2003 23:46:08 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blockgroup_lock: hashed spinlocks for ext2 and ext3
Message-ID: <20030414214608.GA3392@wotan.suse.de>
References: <200304131113.h3DBDvj2004773@hera.kernel.org> <1050350782.7912.400.camel@averell> <20030414143813.329609a6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414143813.329609a6.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> per_cpu data is statically allocated, at compile-time.  And it doesn't work
> for modules.
> 
> These hashed locks need to be dynamically allocated (one per filesystem) and
> they need to work from modules.

Ok.

> 
> And this hashed lock is not a per-cpu thing.  (No locks are!) It just uses
> NR_CPUS to decide how big the hash should be.

Isn't that what the IBM kmalloc_per_cpu() was for ? (I think the patch
was from Dipankar) 

-Andi
