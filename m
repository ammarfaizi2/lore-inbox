Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRAaXfc>; Wed, 31 Jan 2001 18:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRAaXfW>; Wed, 31 Jan 2001 18:35:22 -0500
Received: from zeus.kernel.org ([209.10.41.242]:43747 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129524AbRAaXfE>;
	Wed, 31 Jan 2001 18:35:04 -0500
Date: Wed, 31 Jan 2001 23:32:52 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: bsuparna@in.ibm.com
Cc: Ben LaHaise <bcrl@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010131233252.I11607@redhat.com>
In-Reply-To: <CA2569E5.004D51A7.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <CA2569E5.004D51A7.00@d73mta05.au.ibm.com>; from bsuparna@in.ibm.com on Wed, Jan 31, 2001 at 07:28:01PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 31, 2001 at 07:28:01PM +0530, bsuparna@in.ibm.com wrote:
> 
> Do the following modifications to your wait queue extension sound
> reasonable ?
> 
> 1. Change add_wait_queue to add elements to the end of queue (fifo, by
> default) and instead have an add_wait_queue_lifo() routine that adds to the
> head of the queue ?

Cache efficiency: you wake up the task whose data set is most likely
to be in L1 cache by waking it before its triggering event is flushed
from cache.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
