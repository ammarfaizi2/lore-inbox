Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWBHTHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWBHTHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWBHTHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:07:42 -0500
Received: from ns1.suse.de ([195.135.220.2]:28085 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030521AbWBHTHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:07:41 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation
Date: Wed, 8 Feb 2006 20:05:12 +0100
User-Agent: KMail/1.8.2
Cc: Christoph Lameter <clameter@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com> <Pine.LNX.4.62.0602081037240.3590@schroedinger.engr.sgi.com> <20060208105714.15bb4bb2.pj@sgi.com>
In-Reply-To: <20060208105714.15bb4bb2.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602082005.12657.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 19:57, Paul Jackson wrote:
> > No it only disables the oom killer for constrained allocations.
> 
> But on many big numa systems, the way they are administered,
> that affectively disables the oom killer.

I guess it won't matter because they are administrated with appropiate ulimits
I guess. And to be honest the OOM killer never really worked all that
well, so it's not a big loss.

[still often wish we had that "global virtual memory ulimit for uid"]


> I've yet to be convinced that the oom killer is our friend,
> and half of me (not seriously) is almost wishing it were
> gone.

It's more than half of me near seriously agreeing with you.

> Would another option be to continue to fine tune the heuristics
> that the oom killer uses to pick its next victim?
> 
> What situation did you hit that motivated this change?

It's a long known design bug of the NUMA policy, but it recently 
hit with some test program again.


-Andi
