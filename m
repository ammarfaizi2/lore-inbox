Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262403AbSJOBND>; Mon, 14 Oct 2002 21:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbSJOBND>; Mon, 14 Oct 2002 21:13:03 -0400
Received: from franka.aracnet.com ([216.99.193.44]:25555 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262403AbSJOBMz>; Mon, 14 Oct 2002 21:12:55 -0400
Date: Mon, 14 Oct 2002 18:16:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       john stultz <johnstul@us.ibm.com>
cc: Matt <colpatch@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <2007963929.1034619395@[10.10.2.3]>
In-Reply-To: <20021015010859.GM4488@holomorphy.com>
References: <20021015010859.GM4488@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> MAP_NR_DENSE()-based zone-relative pfn to zone->zone_mem_map index
> remapping is designed to handle this (and actually more severe
> situations). The only constraint is that pfn's must be monotonically
> increasing with ->zone_mem_map index. Some non-i386 architectures
> virtually remap physical memory to provide the illusion of contiguity
> of kernel virtual memory, but in a mature port (e.g. i386) there's high
> risk of breaking numerous preexisting drivers.

As long as you don't need a hole between 0 and 896Mb (s/896/
appropriate defines/) I don't see that would be a problem.
I purged direct usage of mem_map already, and made people use the 
macro wrappers.

Basically a "mini config_nonlinear".

M.
