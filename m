Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbULOXiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbULOXiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbULOXhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:37:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55769 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262509AbULOXhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:37:33 -0500
Date: Wed, 15 Dec 2004 17:37:10 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Anton Blanchard <anton@samba.org>
cc: Andi Kleen <ak@suse.de>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, jrsantos@austin.ibm.com
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
In-Reply-To: <20041215144730.GC24000@krispykreme.ozlabs.ibm.com>
Message-ID: <Pine.SGI.4.61.0412151725040.24052@kzerza.americas.sgi.com>
References: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com>
 <50260000.1103061628@flay> <20041215045855.GH27225@wotan.suse.de>
 <20041215144730.GC24000@krispykreme.ozlabs.ibm.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Anton Blanchard wrote:

> Id like to see a benchmark that has a large footprint in the hash. A few
> connection netperf run isnt going to stress the hash is it?

Not as well as I'd like, I'll admit.  I really couldn't find any
standard benchmark that would push the TCP hashes hard.

> Also what page size were the runs done with? On x86-64 and ppc64 the 4kB page
> size may make a difference to Brents runs.

16K pages on IA64.  As the patch currently stands x86-64 and ppc64
would not be a concern, as we still use the old behavior by default
for those architectures.  Only IA64 NUMA kernel configurations will
have this on by default.  Additionally, this only affects NUMA machines,
and I'm not aware of any x86-64 architectures of that nature (please
educate me if I'm mistaken).

> specSFS (an NFS server benchmarmk) has been very sensitive to TLB issues
> for us, it uses all the memory as pagecache and you end up with 10
> million+ dentries. Something similar that pounds on the dcache would be
> interesting.

I'll look into running that, but have my doubts as to whether I
can scare up appropriate quantities/types of hardware.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
