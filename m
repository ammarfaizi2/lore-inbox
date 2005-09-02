Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVIBQol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVIBQol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 12:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVIBQol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 12:44:41 -0400
Received: from palrel10.hp.com ([156.153.255.245]:54196 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750716AbVIBQok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 12:44:40 -0400
Date: Fri, 2 Sep 2005 09:48:28 -0700
From: Grant Grundler <iod00d@hp.com>
To: Brent Casavant <bcasavan@sgi.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] IOCHK interface for I/O error handling/detecting (for ia64)
Message-ID: <20050902164828.GA10587@esmail.cup.hp.com>
References: <431694DB.90400@jp.fujitsu.com> <20050901172917.I10072@chenjesu.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901172917.I10072@chenjesu.americas.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 05:45:54PM -0500, Brent Casavant wrote:
...
> The first is serialization of all I/O reads and writes.  This will
> be a severe problem on systems with large numbers of PCI buses, the
> very type of system that stands the most to gain in reliability from
> these efforts.  At a minimum any locking should be done on a per-bus
> basis.

The lock could be per "error domain" - that would require some
arch specific support though to define the scope of the "error domain".

> The second is the raw performance penalty from acquiring and dropping
> a lock with every read and write.  This will be a substantial amount
> of activity for any I/O-intensive system, heck even for moderate I/O
> levels.

Sorry - I think this is BS.

Please run mmio_test on your box and share the results.
mmio_test is available here:
	svn co http://svn.gnumonks.org/trunk/mmio_test/

Then we can talk about the cost of spinlocks vs cost of MMIO access.

thanks,
grant
