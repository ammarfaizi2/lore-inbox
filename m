Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbTBFPlz>; Thu, 6 Feb 2003 10:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbTBFPlz>; Thu, 6 Feb 2003 10:41:55 -0500
Received: from ns.suse.de ([213.95.15.193]:38669 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267344AbTBFPly>;
	Thu, 6 Feb 2003 10:41:54 -0500
Date: Thu, 6 Feb 2003 16:51:14 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] gcc -O2 vs gcc -Os performance
Message-ID: <20030206155114.GA16390@wotan.suse.de>
References: <336780000.1044313506@flay> <224770000.1044546145@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224770000.1044546145@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All done with gcc-2.95.4 (Debian Woody). These machines (16x NUMA-Q) have 
> 700MHz P3 Xeons with 2Mb L2 cache ... -Os might fare better on celeron 
> with a puny cache if someone wants to try that out.

-Os on 2.95 is not too useful. It only started becomming useful on 3.1+,
even more so on the upcomming 3.3.

e.g. there was one report of ACPI shrinking by >60k by recompiling it
with -Os on 3.1. ACPI is only slow path code so that is completely reasonable.

Best would be of course to use profile feedback to let the compiler
decide where to generate small and where to generate fast&big code.
But that has problems with the maintainability (it will be hard to generate
the same vmlinux as users for debugging/ksymoops reading purposes)

-Andi
