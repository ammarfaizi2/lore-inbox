Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbUKBJ4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUKBJ4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUKBJyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:54:19 -0500
Received: from cantor.suse.de ([195.135.220.2]:7868 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261158AbUKBJvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:51:46 -0500
Date: Tue, 2 Nov 2004 10:13:06 +0100
From: Andi Kleen <ak@suse.de>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hugh@veritas.com,
       ak@suse.de
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <20041102091306.GC21619@wotan.suse.de>
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And now, for your viewing pleasure...

Patch is fine except that I would add a sysctl to enable/disable this.

I can see that some people would like to not have interleave policy
(e.g. when you use tmpfs as a large memory extender on 32bit NUMA
then you probably want local affinity) 

Best if you name it /proc/sys/vm/numa-tmpfs-rr

Default can be set to one for now.

-Andi
