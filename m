Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSJYRTk>; Fri, 25 Oct 2002 13:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbSJYRTk>; Fri, 25 Oct 2002 13:19:40 -0400
Received: from dsl-62-3-75-185.zen.co.uk ([62.3.75.185]:9088 "EHLO
	giantx.co.uk") by vger.kernel.org with ESMTP id <S261501AbSJYRTj>;
	Fri, 25 Oct 2002 13:19:39 -0400
Date: Fri, 25 Oct 2002 18:25:48 +0100
From: Nyk Tarr <nyk@giantx.co.uk>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
Message-ID: <20021025172548.GA598@giantx.co.uk>
References: <20021025103631.GA588@giantx.co.uk> <20021025103938.GN4153@suse.de> <20021025131050.GA593@giantx.co.uk> <20021025144608.GX4153@suse.de> <20021025144844.GY4153@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025144844.GY4153@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 04:48:44PM +0200, Jens Axboe wrote:
> On Fri, Oct 25 2002, Jens Axboe wrote:
> > On Fri, Oct 25 2002, Nyk Tarr wrote:
> > > On Fri, Oct 25, 2002 at 12:39:38PM +0200, Jens Axboe wrote:
> > > > On Fri, Oct 25 2002, Nyk Tarr wrote:
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > I got this nice error after doing an 'eject /cdrom'
> > > > 
> > > > [snip]
> > > > 
> > > > 2.5.44 and thus 2.5.44-acX has seriously broken REQ_BLOCK_PC, so it's no
> > > > wonder that it breaks hard. Alan, I can sync the sgio patches for you if
> > > > you want.
> > > > 
> > > > Nyk, if you could try
> > > > 
> > > > *.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-15.bz2
> > > > 
> > > > that would be great, thanks.
> > > 
> > > This also seems to hang and die. No panic in the logs this time, but
> > > some stuff scrolling off the screen on console. Sadly I've nothing to
> > > use as serial console at the mo' but I'll try some other options...
> > 
> > Please try sgio-16 from the above location. Ejecting works fine for me,
> > it even manages to close the tray when I ask it to.
> 
> Irk you are on SCSI, yes you need this incremental patch for that to
> work. Sorry about that, I've put up 16b which contains this.

That'll teach me to use ide-scsi ^_-.

Working now, thanks. -ac3 applies over the top with 4 offset patches and
seems to work fine (I can't get various bits of 2.5.44 to compile). I'll
hammer it some more tomorrow.

-- 
/__
\_|\/
   /\
