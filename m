Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTEFIaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTEFIaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:30:08 -0400
Received: from holomorphy.com ([66.224.33.161]:24966 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262456AbTEFIaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:30:06 -0400
Date: Tue, 6 May 2003 01:42:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030506084229.GQ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	"David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
	dipankar@in.ibm.com, linux-kernel@vger.kernel.org
References: <20030505235549.5df75866.akpm@digeo.com> <20030505.225748.35026531.davem@redhat.com> <20030506002229.631a642a.akpm@digeo.com> <20030505.231553.68055974.davem@redhat.com> <20030506003412.45e0949b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506003412.45e0949b.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>> As just pointed out by dipankar the only issue is NUMA...
>> so it has to be something more sophisticated than simply
>> kmalloc()[smp_processor_id];

On Tue, May 06, 2003 at 12:34:12AM -0700, Andrew Morton wrote:
> The proposed patch doesn't do anything about that either.
> +	ptr = alloc_bootmem(PERCPU_POOL_SIZE * NR_CPUS);
> So yes, we need an api which could be extended to use node-affine memory at
> some time in the future.  I think we have that.

IIRC that can be overridden; I wrote something to do node-local per-cpu
areas for i386 for some prior incarnations of per-cpu stuff and even
posted it, and this looks like it bootstraps at the same time (before
free_area_init_core() that is) and has the same override hook.


-- wli
