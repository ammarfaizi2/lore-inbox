Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTEHQGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTEHQGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:06:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60378 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261798AbTEHQGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:06:03 -0400
Date: Thu, 8 May 2003 18:17:59 +0200
From: Jens Axboe <axboe@suse.de>
To: markw@osdl.org
Cc: piggin@cyberone.com.au, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
Message-ID: <20030508161759.GF20941@suse.de>
References: <3EB9B5BA.4080607@cyberone.com.au> <200305081612.h48GCUW25789@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305081612.h48GCUW25789@mail.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, markw@osdl.org wrote:
> On  8 May, Nick Piggin wrote:
> > markw@osdl.org wrote:
> > 
> >>I've collected some data from STP to see if it's useful or if there's
> >>anything else that would be useful to collect. I've got some tests
> >>queued up for the newer patches, but I wanted to put out what I had so
> >>far.
> >>
> > Thanks. It looks like AS isn't doing too badly here. Newer mm kernels
> > have some more AS changes, and the dynamic struct request patch which
> > would be good to test.
> > 
> > Are you using TCQ on your disks?
> > 
> 
> There's a queue depth being set.  Is that a good indicator that TCQ is
> being used?  If not, I'd be happy to verify it.

The queue depth being set, is the highest queueing depth that the scsi
mid layer will throw at you. The actual TCQ depth may be lower, depends
on the hardware. aacraid, iirc, has a pretty big depth so I woudldn't be
surprised if it could use all of those 128 tags.

It would be interesting to see a forced depth of 2 with AS against the
stock case of 128 (and deadline).

-- 
Jens Axboe

