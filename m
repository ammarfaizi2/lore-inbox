Return-Path: <linux-kernel-owner+w=401wt.eu-S1030221AbXAKDIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbXAKDIz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 22:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbXAKDIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 22:08:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:52850 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030221AbXAKDIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 22:08:53 -0500
Date: Thu, 11 Jan 2007 08:43:36 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20070111031335.GA8392@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com> <20070104090242.44dd8165.akpm@osdl.org> <20070110054419.GA3542@in.ibm.com> <20070110170829.31997fee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110170829.31997fee.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 05:08:29PM -0800, Andrew Morton wrote:
> On Wed, 10 Jan 2007 11:14:19 +0530
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> 
> > On Thu, Jan 04, 2007 at 09:02:42AM -0800, Andrew Morton wrote:
> > > On Thu, 4 Jan 2007 10:26:21 +0530
> > > Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> > >
> > > > On Wed, Jan 03, 2007 at 02:15:56PM -0800, Andrew Morton wrote:
> > >
> > > Patches against next -mm would be appreciated, please.  Sorry about that.
> >
> > I have updated the patchset against 2620-rc3-mm1, incorporated various
> > cleanups suggested during last review. Please let me know if I have missed
> > anything:
> 
> The s/lock_page_slow/lock_page_blocking/ got lost.  I redid it.

I thought the lock_page_blocking was an alternative you had suggested
to the __lock_page vs lock_page_async discussion which got resolved later.
That is why I didn't make the change in this patchset.
The call does not block in the async case, hence the choice of
the _slow suffix (like in fs/buffer.c). But if lock_page_blocking()
sounds more intuitive to you, that's OK. 

> 
> For the record, patches-via-http are very painful.  Please always always
> email them.
> 
> As a result, these patches ended up with titles which are derived from their
> filenames, which are cryptic.

Sorry about that - I wanted to ask if you'd prefer my resending them to the
list, but missed doing so. Some people have found it easier to download the
series as a whole when they intend to apply it, so I ended up maintaining it
that way all this while.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

