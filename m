Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSKDAeJ>; Sun, 3 Nov 2002 19:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbSKDAeJ>; Sun, 3 Nov 2002 19:34:09 -0500
Received: from holomorphy.com ([66.224.33.161]:31633 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263991AbSKDAeI>;
	Sun, 3 Nov 2002 19:34:08 -0500
Date: Sun, 3 Nov 2002 16:39:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hch@lst.de,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: interrupt checks for spinlocks
Message-ID: <20021104003906.GB12891@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	hch@lst.de, Benjamin LaHaise <bcrl@redhat.com>
References: <20021103220816.GY16347@holomorphy.com> <Pine.LNX.4.44.0211031612250.954-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211031612250.954-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, William Lee Irwin III wrote:
[...]
>> The only action taken is printk() and dump_stack(). No arch code has
>> been futzed with to provide irq tainting yet. Looks like a good way
>> to shake out lurking bugs to me (somewhat like may_sleep() etc.).

On Sun, Nov 03, 2002 at 04:15:46PM -0800, Davide Libenzi wrote:
> Wouldn't it be interesting to keep a ( per task ) list of acquired
> spinlocks to be able to diagnose cross locks in case of stall ?
> ( obviously under CONFIG_DEBUG_SPINLOCK )

That would appear to require cycle detection, but it sounds like a
potential breakthrough usage of graph algorithms in the kernel.
(I've always been told graph algorithms would come back to haunt me.)
Or maybe not, deadlock detection has been done before.

A separate patch/feature/whatever for deadlock detection could do that
nicely, though. What I've presented here is meant only to flag far more
trivial errors with interrupt enablement/disablement than the full
deadlock detection problem.


Bill
