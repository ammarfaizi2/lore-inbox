Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVGZVsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVGZVsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVGZVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:46:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:23468 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262161AbVGZVpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:45:14 -0400
Subject: Re: Memory pressure handling with iSCSI
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20050726142410.4ff2e56a.akpm@osdl.org>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726111110.6b9db241.akpm@osdl.org>
	 <1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726114824.136d3dad.akpm@osdl.org>
	 <20050726121250.0ba7d744.akpm@osdl.org>
	 <1122412301.6433.54.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726142410.4ff2e56a.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 14:45:00 -0700
Message-Id: <1122414300.6433.57.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 14:24 -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > ext2 is incredibly better. Machine is very responsive. 
> > 
> 
> OK.  Please, always monitor and send /proc/meminfo.  I assume that the
> dirty-memory clamping is working OK with ext2 and that perhaps it'll work
> OK with ext3/data=writeback.

Nope. Dirty is still very high..

# cat /proc/meminfo
MemTotal:      7143628 kB
MemFree:         33248 kB
Buffers:          8368 kB
Cached:        6789932 kB
SwapCached:          0 kB
Active:          51316 kB
Inactive:      6769144 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7143628 kB
LowFree:         33248 kB
SwapTotal:     1048784 kB
SwapFree:      1048780 kB
Dirty:         6605704 kB
Writeback:      168452 kB
Mapped:          49724 kB
Slab:           252200 kB
CommitLimit:   4620596 kB
Committed_AS:   163524 kB
PageTables:       2284 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9888 kB
VmallocChunk: 34359728447 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

Thanks,
Badari

