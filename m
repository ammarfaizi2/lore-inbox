Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272602AbTHKHXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 03:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272603AbTHKHXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 03:23:52 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:36105 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272602AbTHKHXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 03:23:51 -0400
Date: Mon, 11 Aug 2003 08:23:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1 of 2 - When a partition is claimed, claim the whole device for partitioning.
Message-ID: <20030811082349.B20077@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neilb@cse.unsw.edu.au>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <E19m2XN-0002BP-00@notabene>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19m2XN-0002BP-00@notabene>; from neilb@cse.unsw.edu.au on Mon, Aug 11, 2003 at 12:35:57PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:35:57PM +1000, NeilBrown wrote:
> ### Comments for ChangeSet
> 
> Current devices can be 'claimed' by filesystems (when mounting) or
> md/raid (when being included in an array) or 'raw' or ....
> This stop concurrent access by these systems.
> 
> However it is still possible for one system to claim the whole device
> and a second system to claim one partition, which is not good.
> 
> With this patch, when a partition is claimed, the whole device is 
> claimed for partitioning.  So you cannot have a partition and the
> whole devices claimed at the same time (except if the whole device
> is claimed for partitioning).

Ok, this answers my question in the first mail...

