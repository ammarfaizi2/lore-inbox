Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946148AbWBDXvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946148AbWBDXvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWBDXvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:51:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964888AbWBDXu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:50:56 -0500
Date: Sat, 4 Feb 2006 15:49:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 3/5] cpuset memory spread slab cache implementation
Message-Id: <20060204154959.0322e5da.akpm@osdl.org>
In-Reply-To: <20060204071921.10021.83884.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071921.10021.83884.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> +	if (unlikely(cpuset_mem_spread_check() &&
>  +					(cachep->flags & SLAB_MEM_SPREAD) &&
>  +					!in_interrupt())) {
>  +		int nid = cpuset_mem_spread_node();
>  +
>  +		if (nid != numa_node_id())
>  +			return __cache_alloc_node(cachep, flags, nid);
>  +	}

Need a comment here explaining the mysterious !in_interrupt() check.
