Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbUCJUtq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUCJUtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:49:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45028 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262825AbUCJUtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:49:43 -0500
Date: Wed, 10 Mar 2004 21:49:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Kenneth Chen <kenneth.w.chen@intel.com>, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310204936.GJ15087@suse.de>
References: <20040310115545.16cb387f.akpm@osdl.org> <200403102003.i2AK3qm16576@unix-os.sc.intel.com> <20040310202025.GH15087@suse.de> <20040310204532.GA10281@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310204532.GA10281@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10 2004, Jesse Barnes wrote:
> On Wed, Mar 10, 2004 at 09:20:25PM +0100, Jens Axboe wrote:
> > It'll be hard to apply the patch against anything but -mm, since it
> > builds (or at least will conflict with) other changes in there. I
> > deliberately made a -mm version this time though I usually make -linus
> > and adapt if necessary, for Andrew to get some testing on this.
> 
> I tried applying to a BK tree (that was fresh as of a couple of hours
> ago), and ignored the dm related changes, and it seemed to work ok after
> I fixed up rejects in direct-io.c and blkdev.h (which didn't seem hard,
> unless I'm missing something):
> 
> 10 qla2200 fc controllers, 64 cpus, 112 disks
> 
> stock BK tree: ~43945 I/Os per second
> w/Jens' patch: ~47149 I/Os per second

Do you have a profile for both runs (what was the work load, btw)?

-- 
Jens Axboe

