Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUCNPVV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 10:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUCNPVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 10:21:21 -0500
Received: from ns.suse.de ([195.135.220.2]:44699 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263375AbUCNPVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 10:21:17 -0500
Subject: Re: [PATCH] lockfs patch for 2.6
From: Chris Mason <mason@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <20040314140032.A8901@infradead.org>
References: <1078867885.25075.1458.camel@watt.suse.com>
	 <20040313131447.A25900@infradead.org>
	 <1079191213.4187.243.camel@watt.suse.com>
	 <20040313163346.A27004@infradead.org>  <20040314140032.A8901@infradead.org>
Content-Type: text/plain
Message-Id: <1079277810.4183.249.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Mar 2004 10:23:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-14 at 09:00, Christoph Hellwig wrote:
> On Sat, Mar 13, 2004 at 04:33:46PM +0000, Christoph Hellwig wrote:
> > Here's the reworked patch I have, ignoring dm but converting the xfs-internal
> > interfaces that do freezing.  But without an interface change we still need
> > to do all the flushing a second time inside XFS which I absoutely dislike.
> > 
> > Let me think about how to do this nicer.
> 
> Okay, here's a new patch that basically moves all the XFS freezing
> infrastructure to the VFS, leavin only writing of the log record and some
> transaction count handing inside XFS.
> 
> I've given it some heavy testing with xfs_freeze, dm is still not updated.
> 
> P.S. this patch now kills 16 lines of kernel code summarized :)
> 

It looks good, I'll give it a try.

-chris


