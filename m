Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272648AbRHaJh2>; Fri, 31 Aug 2001 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272647AbRHaJhT>; Fri, 31 Aug 2001 05:37:19 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:36367 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S272648AbRHaJhD>; Fri, 31 Aug 2001 05:37:03 -0400
Date: Fri, 31 Aug 2001 11:37:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <thornber@btconnect.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A possible direction for the next LVM driver
Message-ID: <20010831113712.L2855@suse.de>
In-Reply-To: <20010830164547.A807@btconnect.com> <20010831112020.K2855@suse.de> <20010831103541.A440@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010831103541.A440@btconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31 2001, Joe Thornber wrote:
> On Fri, Aug 31, 2001 at 11:20:20AM +0200, Jens Axboe wrote:
> > On Thu, Aug 30 2001, Joe Thornber wrote:
> > > Hi,
> > > 
> > > I'm working on the next iteration of the LVM driver, specifically
> > > trying to address the critism directed at the rather ugly ioctl
> > > interface.  The code has reached the stage where it works and it's
> > > possible to see what I'm aiming for.  I would appreciate it if people
> > > could spare the time to review this and give me feedback.  If there is
> > > general agreement that this is moving in the right direction then the
> > > next major version of LVM may be based around a future version of this
> > > driver.  Please CC me in replies.  The code can be found at:
> > > 
> > > ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper.tar.bz2
> > 
> > Looks interesting, here's patch to fix possible infinite loop in your
> > make_request_fn.
> 
> Great, thanks.

I missed a '}', jfyi

> > Another quick note -- you might want to consider
> > slab'ifying the io_hook allocation/deallocation...
> 
> yes, I'd thought of this, hence the comment ...
> 
> /* FIXME: These should have their own slab */
> inline static struct io_hook *alloc_io_hook(void)
> 
> I'll change that now.

Oh, didn't spot that... But yet, it's a really good idea.

-- 
Jens Axboe

