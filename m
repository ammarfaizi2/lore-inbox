Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSJQBCG>; Wed, 16 Oct 2002 21:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSJQBCG>; Wed, 16 Oct 2002 21:02:06 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:60902 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261605AbSJQBCF>; Wed, 16 Oct 2002 21:02:05 -0400
Date: Wed, 16 Oct 2002 18:07:55 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021017010754.GW22117@nic1-pc.us.oracle.com>
References: <20021014135100.GD28283@suse.de> <20021017005109.GV22117@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017005109.GV22117@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 05:51:10PM -0700, Joel Becker wrote:
> On Mon, Oct 14, 2002 at 03:51:00PM +0200, Jens Axboe wrote:
> > @@ -943,7 +1015,6 @@
> >  	 */
> >  	bh = blk_queue_bounce(q, rw, bh);

	Thinking about this, I went to add it into submit_bh_list()
where we already iterate the bhs.  However, this would require some
reordering and would require teaching create_bounce() about linked I/Os.
Any better ideas?

Joel

-- 

Life's Little Instruction Book #43

	"Never give up on somebody.  Miracles happen every day."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
