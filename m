Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUCJUVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUCJUVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:21:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63707 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262816AbUCJUUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:20:31 -0500
Date: Wed, 10 Mar 2004 21:20:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Kenneth Chen <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310202025.GH15087@suse.de>
References: <20040310115545.16cb387f.akpm@osdl.org> <200403102003.i2AK3qm16576@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403102003.i2AK3qm16576@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10 2004, Kenneth Chen wrote:
> Andrew Morton wrote on Wednesday, March 10, 2004 11:56 AM
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > Here's a first cut at killing global plugging of block devices to reduce
> > > the nasty contention blk_plug_lock caused. This introduceds per-queue
> > > plugging, controlled by the backing_dev_info.
> >
> > This is such an improvement over what we have now it isn't funny.
> >
> > Ken, the next -mm is starting to look like linux-3.1.0 so I think it
> > would be best if you could benchmark Jens's patch against 2.6.4-rc2-mm1.
> 
> I'm planning on couple experiments: one is just Jens's change on top of
> what we have so we can validate the backing dev unplug. Then we will run
> 2.6.4-rc2-mm1 + Jens's patch.

It'll be hard to apply the patch against anything but -mm, since it
builds (or at least will conflict with) other changes in there. I
deliberately made a -mm version this time though I usually make -linus
and adapt if necessary, for Andrew to get some testing on this.

-- 
Jens Axboe

