Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312977AbSC0HFM>; Wed, 27 Mar 2002 02:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312980AbSC0HFD>; Wed, 27 Mar 2002 02:05:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27141 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312690AbSC0HEv>;
	Wed, 27 Mar 2002 02:04:51 -0500
Date: Wed, 27 Mar 2002 08:03:25 +0100
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020327070325.GA20703@suse.de>
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com> <20020320152008.A19978@vger.timpanogas.org> <20020320152504.B19978@vger.timpanogas.org> <3C9935CA.38E6F56F@zip.com.au> <20020320234552.A21740@vger.timpanogas.org> <20020325181645.A17171@vger.timpanogas.org> <20020326014219.GA3536@matchmail.com> <20020326100330.A20201@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26 2002, Jeff V. Merkey wrote:
> > 
> > That's good news.
> > 
> > Are you still working on the A/B list patch?  I'd imagine that it could make
> > several problems easier to fix in the block layer.
> > 
> 
> Yes.  I am asking Darren Major, who wrote the A/B implementation 
> in NetWare to review the patch before we submit it.  It may affect
> some drivers.  We are verifying that the change I instrumented 
> will not break anything.

I'm curious how you are doing this cleanly in 2.4. There are lots of
places in the kernel that do direct list management on the queue_head.
Are you adding two separate hidden lists and splicing content to the
queue_head?

2.5 has this done much more cleanly (of course I'm very biased). See the
deadline I/O scheduler patch I've posted before, stuff like this can be
done a lot cleaner there. Internal I/O scheduler structures are
completely hidden from drivers.

-- 
Jens Axboe

