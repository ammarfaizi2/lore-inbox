Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbSJNPPq>; Mon, 14 Oct 2002 11:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbSJNPPq>; Mon, 14 Oct 2002 11:15:46 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:64525 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261815AbSJNPPp>; Mon, 14 Oct 2002 11:15:45 -0400
Date: Mon, 14 Oct 2002 16:21:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: Alexander Viro <viro@math.psu.edu>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014162134.C17683@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Clark <michael@metaparadigm.com>,
	Alexander Viro <viro@math.psu.edu>,
	Mark Peloquin <markpeloquin@hotmail.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	evms-devel@lists.sourceforge.net
References: <Pine.GSO.4.21.0210131243480.9247-100000@steklov.math.psu.edu> <3DA9B05F.8000600@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA9B05F.8000600@metaparadigm.com>; from michael@metaparadigm.com on Mon, Oct 14, 2002 at 01:41:51AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 01:41:51AM +0800, Michael Clark wrote:
>  From the discussion so far:
> 
> Pros
> * Simplify ioctl routing to plugins

* allow code reuse
* simplify userspace access to intermediate layer
* avoid data duplication
* avoid having different data structures for very differen things

> Cons
> * Chew up a minor
> * Get a block device we don't need or want (ie. we can still easily
>    directly access the underlying physical block devices)
> * loose purely logical remapping abstraction in plugins

Explain the exact meaning of this to non/native speakers like me, please

> * Complicate mapping of request queues to devices (ie. shouldn't only
>    the top level volume device and the underlying physical devices need
>    request queues)

You need struct request queue as data structure, but you don't actually
need a queue.  Please check the code.

And no, I don't think having a peoper, custom make_request_fn will
complicate the code.
