Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUIJQQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUIJQQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIJQP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:15:26 -0400
Received: from the-village.bc.nu ([81.2.110.252]:40881 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267538AbUIJQOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:14:45 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrea Arcangeli <andrea@suse.de>,
       arjanv@redhat.com, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094829125.17464.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 16:12:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 16:07, Hugh Dickins wrote:
> Chris's patch seems eminently sensible to me.  Why should having separate
> interrupt stack depend on whether you're configured for 4K or 8K stacks?

You only have 4K safe to use in all current configurations. Its a case
of simply fixing the sloppy code (and or pushing up compiler versions 
where the compiler is the offender). 

> Wasn't Andrea worried, a couple of months back, about nested interrupts
> overflowing the 4K interrupt stack? 

We've seen no evidence of this and assuming apps could use 4K safely the
interrupt "stack" was about 2.5K before. Limiting it either by size or
by depth is not a big problem at all.

