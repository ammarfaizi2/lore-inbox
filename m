Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWA0LxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWA0LxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWA0LxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:53:13 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:63245 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S932461AbWA0LxN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:53:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Out of Memory: Killed process 16498 (java).
Date: Fri, 27 Jan 2006 11:53:06 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C2703556694@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Out of Memory: Killed process 16498 (java).
Thread-Index: AcYgBSGCcA7RcwvWRWuBNfb6btGzWwDMxIOw
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>, <lwoodman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any progress on a patch?

-- 
Andy, BlueArc Engineering
 

> -----Original Message-----
> From: Jens Axboe [mailto:axboe@suse.de] 
> Sent: 23 January 2006 10:12
> To: Andy Chittenden
> Cc: Andrew Morton; davej@redhat.com; 
> linux-kernel@vger.kernel.org; lwoodman@redhat.com
> Subject: Re: Out of Memory: Killed process 16498 (java).
> 
> On Mon, Jan 23 2006, Andy Chittenden wrote:
> > > There's your problem, apparently both of these queues is 
> > > being set to a
> > > limit lower than blk_max_low_pfn which means the block layer 
> > > will revert
> > > to the isa dma bounce zone for that queue... There's room for
> > > improvement in the logic that chooses what zone to allocate 
> > > from.
> > 
> > So I presume that requires a source fix. Or can it be 
> configured out?
> 
> It does, I'll see if I can get some time to generate one.
> 
> -- 
> Jens Axboe
> 
> 
