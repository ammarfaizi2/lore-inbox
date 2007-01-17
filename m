Return-Path: <linux-kernel-owner+w=401wt.eu-S1751482AbXAQXjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXAQXjX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 18:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXAQXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 18:39:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40112 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbXAQXjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 18:39:22 -0500
Subject: Re: [PATCH: 2.6.20-rc4-mm1] JFS: Avoid deadlock introduced by
	explicit  I/O plugging
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20070117231847.GH3508@kernel.dk>
References: <1169074549.10560.10.camel@kleikamp.austin.ibm.com>
	 <20070117231847.GH3508@kernel.dk>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 17:39:17 -0600
Message-Id: <1169077157.10560.16.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 10:18 +1100, Jens Axboe wrote:

> Can you try io_schedule() and verify that things just work?

I actually did do that in the first place, but wondered if it was the
right thing to introduce the accounting changes that came with that.
I'll change it back to io_schedule() and test it again, just to make
sure.

If that's the right fix, I can push it directly since it won't have any
dependencies on your patches.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

