Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbULOWQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbULOWQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbULOWQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:16:54 -0500
Received: from ozlabs.org ([203.10.76.45]:40159 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262514AbULOWQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:16:51 -0500
Date: Thu, 16 Dec 2004 01:47:30 +1100
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org, jrsantos@austin.ibm.com
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041215144730.GC24000@krispykreme.ozlabs.ibm.com>
References: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com> <50260000.1103061628@flay> <20041215045855.GH27225@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215045855.GH27225@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Given that Brent did lots of benchmarks which didn't show any slowdowns
> I don't think this is really needed (at least as long as nobody
> demonstrates a ireal slowdown from the patch). And having such special
> cases is always ugly, better not have them when not needed.

Id like to see a benchmark that has a large footprint in the hash. A few
connection netperf run isnt going to stress the hash is it?

Also what page size were the runs done with? On x86-64 and ppc64 the 4kB page
size may make a difference to Brents runs.

specSFS (an NFS server benchmarmk) has been very sensitive to TLB issues
for us, it uses all the memory as pagecache and you end up with 10
million+ dentries. Something similar that pounds on the dcache would be
interesting.

Anton
