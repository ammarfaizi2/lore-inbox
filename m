Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbTATRCH>; Mon, 20 Jan 2003 12:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266678AbTATRCH>; Mon, 20 Jan 2003 12:02:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:25022 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266675AbTATRCE>; Mon, 20 Jan 2003 12:02:04 -0500
Date: Mon, 20 Jan 2003 09:10:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, anton@samba.org
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <1382810000.1043082649@titus>
In-Reply-To: <Pine.LNX.4.44.0301201802300.11746-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301201802300.11746-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> or as Arjan points out, like the IBM x440 boxes ...

;-)
 
> i think we want to handle SMT on a different level, ie. via the
> shared-runqueue approach, so it's not a genuine new level of caching, it's
> rather a new concept of multiple logical cores per physical core. (which
> needs is own code in the scheduler.)

Do you have that code working already (presumably needs locking changes)? 
I seem to recall something like that existing already, but I don't recall 
if it was ever fully working or not ...

I think the large PPC64 boxes have multilevel NUMA as well - two real
phys cores on one die, sharing some cache (L2 but not L1? Anton?).
And SGI have multilevel nodes too I think ... so we'll still need 
multilevel NUMA at some point ... but maybe not right now.

M.


