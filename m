Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbSJQF5b>; Thu, 17 Oct 2002 01:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261814AbSJQF5b>; Thu, 17 Oct 2002 01:57:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7881 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261810AbSJQF53>;
	Thu, 17 Oct 2002 01:57:29 -0400
Date: Thu, 17 Oct 2002 08:03:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021017060314.GD9245@suse.de>
References: <20021014135100.GD28283@suse.de> <20021017005109.GV22117@nic1-pc.us.oracle.com> <20021017010754.GW22117@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017010754.GW22117@nic1-pc.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16 2002, Joel Becker wrote:
> On Wed, Oct 16, 2002 at 05:51:10PM -0700, Joel Becker wrote:
> > On Mon, Oct 14, 2002 at 03:51:00PM +0200, Jens Axboe wrote:
> > > @@ -943,7 +1015,6 @@
> > >  	 */
> > >  	bh = blk_queue_bounce(q, rw, bh);
> 
> 	Thinking about this, I went to add it into submit_bh_list()
> where we already iterate the bhs.  However, this would require some
> reordering and would require teaching create_bounce() about linked I/Os.
> Any better ideas?

The worst problem is the deadlock issue with potentially having to
allocate more than one bounce page.

-- 
Jens Axboe

