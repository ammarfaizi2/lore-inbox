Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263088AbTCLIUP>; Wed, 12 Mar 2003 03:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263090AbTCLIUP>; Wed, 12 Mar 2003 03:20:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:920 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263088AbTCLIUO>;
	Wed, 12 Mar 2003 03:20:14 -0500
Date: Wed, 12 Mar 2003 09:30:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: scott-kernel@thomasons.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312083047.GH811@suse.de>
References: <200303112055.31854.scott-kernel@thomasons.org> <15982.43897.703221.456961@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15982.43897.703221.456961@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12 2003, Neil Brown wrote:
> On Tuesday March 11, scott-kernel@thomasons.org wrote:
> > I frequently receive this message in my syslog, apparently 
> > whenever there are periods of significant write activity:
> > 
> >     bio too big device ide0(3,7) (256 > 255)
> >     bio too big device ide1(22,6) (256 > 255)
> > 
> > It's worth noting that on this system I have had ongoing trouble 
> > with system stability during write activity as well, using a 
> > wide variety of 2.5.x kernels, even though at the time of this 
> > symptom things are apparently running fine.
> > 
> > Filesystems are all ext3 on top soft raid0 devices. This happens 
> > to be 2.5.64, but it has been happening for at least the last 
> > 5-6 versions.
> > 
> > Ideas? Any further debugging output I can provide?
> 
> 
> raid0 doesn't really work well in 2.5 yet.... as you have noticed.
> 
> We really need to grab the bio splitting code out of md/dm.c and use
> it to split bios that are too big or that cross device boundaries.
> 
> any volunteers??

I can give it a shot

-- 
Jens Axboe

