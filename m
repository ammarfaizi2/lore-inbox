Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWBHUz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWBHUz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWBHUz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:55:28 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5817 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751121AbWBHUz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:55:27 -0500
Date: Wed, 8 Feb 2006 12:55:21 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208125521.b9a2aa5e.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602081228260.4335@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0602081037240.3590@schroedinger.engr.sgi.com>
	<20060208105714.15bb4bb2.pj@sgi.com>
	<200602082005.12657.ak@suse.de>
	<20060208122227.3379643e.pj@sgi.com>
	<Pine.LNX.4.62.0602081228260.4335@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone give us a good reason why we shouldn't just remove the oom
killer, entirely?

Christoph wrote:
> If a task has restricted its memory allocation to one node and does 
> excessive allocations then that process needs to die not other processes 
> that are harmlessly running on the node and that may not be allocating 
> memory at the time.

That _exact_ same argument applies to a system that only has one node.

If we want to remove the oom killer, lets just remove the oom killer.


> People are accustomed of having random processes killed? <shudder>

That's what the oom killer does ... well, it makes an honest effort
not to be random.

So, yes, since it has been there a long time, people are used to
it.  Maybe they don't like it, maybe with good reason.  But it
is there.


> OOM killing makes 
> sense for global allocations if the system is really tight on memory and 
> survival is the main goal

If that argument justifies OOM killing on a simple UMA system, then
surely, for -some- critical tasks, it justifies it on a big NUMA system.

Either OOM is useful in some cases or it is not.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
