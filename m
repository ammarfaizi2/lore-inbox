Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280402AbRKEJPB>; Mon, 5 Nov 2001 04:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280403AbRKEJOv>; Mon, 5 Nov 2001 04:14:51 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35316
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280402AbRKEJOn>; Mon, 5 Nov 2001 04:14:43 -0500
Date: Mon, 5 Nov 2001 01:14:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011105011437.A377@mikef-linux.matchmail.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>, <3BE5F5BF.7A249BDF@zip.com.au> <20011104193232.A16679@mikef-linux.matchmail.com> <3BE60B51.968458D3@zip.com.au> <20011105080635.D2580@suse.de> <20011105081836.F2580@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011105081836.F2580@suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 08:18:36AM +0100, Jens Axboe wrote:
> On Mon, Nov 05 2001, Jens Axboe wrote:
> > Interesting, the 2.5 design prevents this since it doesn't account
> > merges as a penalty (like a seek). I can do something like that for 2.4
> > too, I'll do a patch for you to test.
> 
> Ok here it is. It's not as efficient as the 2.5 version since it
> proceeds to scan the entire queue for a merge, but it should suffice for
> your testing.
> 

Does the elevator still favor blocks that are on the outside of the platter
over all others?  If so, I think this should be removed in favor of a
timeout just like the other seek requests...

I've been able to put a swap partition on the outside of my drive, and get
utterly abizmal performance, while on another similar system, with swap on
the inside of the drive performance was much better during a swap storm...

Mike
