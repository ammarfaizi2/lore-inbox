Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVJaBN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVJaBN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJaBN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:13:57 -0500
Received: from cantor.suse.de ([195.135.220.2]:37271 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750754AbVJaBN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:13:57 -0500
From: Andi Kleen <ak@suse.de>
To: Bob Picco <bob.picco@hp.com>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Date: Mon, 31 Oct 2005 03:12:17 +0100
User-Agent: KMail/1.8
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <1130607017.12551.5.camel@localhost> <20051031001727.GC6019@localhost.localdomain>
In-Reply-To: <20051031001727.GC6019@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310312.18395.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 01:17, Bob Picco wrote:

> This is a slightly modified patch I used on x86_64 for EXTREME testing. The
> original 2.6.13-rc1-mhp1 patch didn't apply cleanly against 2.6.14. It will
> apply with this untested patch.  The patch needs to have arch_sparse_init
> which is only active for SPARSEMEM. This patch was just for testing EXTREME
> on x86_64 NUMA and needs review.
>
> I think the bootmem allocator is being used before initialized.  This
> wouldn't have happened before SPARSEMEM_EXTREME became the default.
>
> If you feel my analysis is correct, I'll generate a cleaner patch and
> test on my 4 way.

Ok the question is - why did nobody submit this patch in time? When
sparse was merged I assumed folks would actually test and maintain
it. But that doesn't seem to be the case? Somewhat surprising.

I personally don't care much about sparsemem right now because it doesn't have 
any advantage and if it's unmaintained would consider to mark it 
CONFIG_BROKEN. That's simply because we can't have highly experimental 
CONFIGs in a production kernel that unsuspecting users can just set and break 
their configuration.

Dave, is there someone in charge for sparsemem on x86-64?

-Andi
