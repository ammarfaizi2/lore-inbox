Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268720AbUILPEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268720AbUILPEb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 11:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUILPEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 11:04:31 -0400
Received: from jade.spiritone.com ([216.99.193.136]:30366 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268720AbUILPEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 11:04:30 -0400
Date: Sun, 12 Sep 2004 08:03:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@novell.com>, Arjan van de Ven <arjanv@redhat.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <622230000.1095001434@[10.10.2.4]>
In-Reply-To: <20040912141701.GA21626@nocona.random>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <20040912141701.GA21626@nocona.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrea Arcangeli <andrea@novell.com> wrote (on Sunday, September 12, 2004 16:17:01 +0200):

> On Fri, Sep 10, 2004 at 05:34:21PM +0200, Arjan van de Ven wrote:
>> disabling is actually not a bad idea; hard irq handlers run for a very short
> 
> you mean hard irq handlers "should run" for a very short time. There can
> be slow hardware that needs a long time, and fast hardware that needs a
> short time, and in turn it makes perfect sense to allow nesting to give
> low latency to the "fast" onces, like it has always happened so far (not
> only in linux AFIK). Disabling nesting completely sounds a very bad
> idea to me, when "limiting nesting" can be achieved easily as confirmed
> by Alan too.

IIRC, what we did in PTX was have 16 SPL levels, each interrupt was assigned
a prio, and higher prio interrupts could interrupt lower prio ones (but not
the same prio or higher). There's some support for that in the APIC, I think,
something like the high nybble is prio, and the low nybble is just an index.

M.

