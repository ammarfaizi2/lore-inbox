Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264733AbUD2VIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbUD2VIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264644AbUD2UrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:47:01 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:30090 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264981AbUD2UmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:42:01 -0400
Date: Thu, 29 Apr 2004 13:36:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: nickpiggin@yahoo.com.au, jgarzik@pobox.com, akpm@osdl.org,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429133613.791f9f9b.pj@sgi.com>
In-Reply-To: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How on earth is the kernel supposed to know that for this one particular
> job you don't care if it takes 3 hours instead of 10 minutes,

I'd pay ten bucks (yeah, I'm a cheapskate) for an option that I could
twiddle that would mark my nightly updatedb and backup jobs as ones to
use reduced memory footprint (both for file caching and backing user
virtual address space), even if it took much longer.

So, rather than protest in mock outrage that it's impossible for the
kernel to know this, instead answer the question as stated in all
seriousness ... well ... how _could_ the kernel know, and what _could_
the kernel do if it knew.  What mechanism(s) would be needed so that
the kernel could restrict a jobs memory usage?

Heh - indeed perhaps the answer is closer than I realize.  For SGI's big
NUMA boxes, managing memory placement is sufficiently critical that we
are inventing or encouraging ways (such as Andi Kleen's numa stuff) to
control memory placement per node per job.  Perhaps this needs to be
extended to portions of a node (this job can only use 1 Gb of the memory
on that 2 Gb node) and to other memory uses (file cache, not just user
space memory).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
