Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUEEHP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUEEHP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 03:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUEEHP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 03:15:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:10187 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263173AbUEEHPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 03:15:25 -0400
Date: Wed, 5 May 2004 00:14:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: ashok.raj@intel.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com, jreiser@BitWagon.com, mike@navi.cx,
       pageexec@freemail.hu, colpatch@us.ibm.com, wli@holomorphy.com,
       rusty@rustcorp.com.au, nickpiggin@yahoo.com.au
Subject: Re: various cpu patches [was: (resend) take3: Updated CPU Hotplug
 patches]
Message-Id: <20040505001425.6d4e8562.akpm@osdl.org>
In-Reply-To: <20040505000348.018f88bb.pj@sgi.com>
References: <20040504211755.A13286@unix-os.sc.intel.com>
	<20040504225907.6c2fe459.akpm@osdl.org>
	<20040505000348.018f88bb.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Hmmm .. we're getting backed up here.  Sure glad Andrew's got the job of
> conducting this, not me ...
> 
> The purpose of this message is to list several patches that are
> interacting, and the order that I'm guessing Andrew will end up taking
> them.  I claim no authority, and at best very limited forecasting
> ability.

I try to keep patches in the expected merge-up order.  The patching order
is in the series file - see the `patch-series' symlink in the kerne.org
directory.

> This is just to put a source of possible confusions on the table,
> by running it up the flagpole, and inviting the shooting to begin.
> 
> The following patches are colliding or interacting, listed in the order
> that I'm guessing they will end up going into *-mm, and with my guess of
> their current status:
> 
>   1. Nick Piggin's sched_domains patches (in *-mm now)
>   2. Ashok Raj's CPU Hotplug patches for IA64 (sent back to author for repair)
>   3. Paul Jackson's bitmap/cpumask cleanup (in my workarea ready to submit)
>   4. John Reiser's bssprot (unrelated, except for ia64 friendly fire damage)
>   5. Matthew Dobson's nodemask_t (in Matthew's workarea, ready to submit)
>   6. Andi Kleen's numa placement (being reviewed now, I think)

Planned for shortly after 2.6.6 are:

sched-domains
rmap 7-14		(15-23 probably a week later)
numa api

> Actually, bssprot is independent, once it resolves some ia64 issue, and
> the last two (nodemask and numa) are sufficiently independent to go
> in parallel or reverse order.

I dropped bssprot - it was causing too much grief.

> If you _wanted_, Andrew, to add to your current patch load, I'd be
> delighted to submit my final bitmap/cpumask cleanup now - I'm just
> guessing that you will politely ignore my offer.

I confess to being vaguely stunned that it is possible to generate a ~20
patch series againt the bitmap code.  I'll pay more attention next time it
flies past.
