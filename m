Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbUEEHIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUEEHIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 03:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUEEHIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 03:08:06 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:15252 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263271AbUEEHID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 03:08:03 -0400
Date: Wed, 5 May 2004 00:03:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ashok.raj@intel.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com, John Reiser <jreiser@BitWagon.com>,
       mike@navi.cx, pageexec@freemail.hu,
       Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: various cpu patches [was: (resend) take3: Updated CPU Hotplug
 patches]
Message-Id: <20040505000348.018f88bb.pj@sgi.com>
In-Reply-To: <20040504225907.6c2fe459.akpm@osdl.org>
References: <20040504211755.A13286@unix-os.sc.intel.com>
	<20040504225907.6c2fe459.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm .. we're getting backed up here.  Sure glad Andrew's got the job of
conducting this, not me ...

The purpose of this message is to list several patches that are
interacting, and the order that I'm guessing Andrew will end up taking
them.  I claim no authority, and at best very limited forecasting
ability.

This is just to put a source of possible confusions on the table,
by running it up the flagpole, and inviting the shooting to begin.

The following patches are colliding or interacting, listed in the order
that I'm guessing they will end up going into *-mm, and with my guess of
their current status:

  1. Nick Piggin's sched_domains patches (in *-mm now)
  2. Ashok Raj's CPU Hotplug patches for IA64 (sent back to author for repair)
  3. Paul Jackson's bitmap/cpumask cleanup (in my workarea ready to submit)
  4. John Reiser's bssprot (unrelated, except for ia64 friendly fire damage)
  5. Matthew Dobson's nodemask_t (in Matthew's workarea, ready to submit)
  6. Andi Kleen's numa placement (being reviewed now, I think)

Actually, bssprot is independent, once it resolves some ia64 issue, and
the last two (nodemask and numa) are sufficiently independent to go
in parallel or reverse order.

If you _wanted_, Andrew, to add to your current patch load, I'd be
delighted to submit my final bitmap/cpumask cleanup now - I'm just
guessing that you will politely ignore my offer.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
