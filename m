Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSBXCyn>; Sat, 23 Feb 2002 21:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289255AbSBXCyX>; Sat, 23 Feb 2002 21:54:23 -0500
Received: from cs24344-28.austin.rr.com ([24.243.44.28]:57351 "EHLO
	explorer.dummynet") by vger.kernel.org with ESMTP
	id <S289239AbSBXCyP>; Sat, 23 Feb 2002 21:54:15 -0500
Date: Sat, 23 Feb 2002 20:54:11 -0600
From: Dan Hopper <ku4nf@austin.rr.com>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020224025411.GA2418@yoda.dummynet>
Mail-Followup-To: Dan Hopper <ku4nf@austin.rr.com>,
	Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
	Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <fa.n7cofbv.1him3j@ifi.uio.no> <fa.dsb79pv.on84ii@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.dsb79pv.on84ii@ifi.uio.no>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> remarked:
> 
> On Fri, Feb 15, 2002 at 10:22:05AM -0800, Patrick Mochel wrote:
> > 
> > On Fri, 15 Feb 2002, Patrick Mochel wrote:
> > 
> > > 
> > > > no, it doesn't solve the problem. i would like to test it whith 
> > > > preemtible kernel not set but it doesn't boot.
> > > 
> > > While Greg's patch did fix part of the problem, the rest of it was on my 
> > > end. Could you try this patch, and see if helps?
> > 
> > Actually, the patch that I sent is against my current tree, which includes 
> > some changes that I've already pushed to Linus. If you're using BK, you 
> > should be able to pull his current tree (if you're into that kinda thing). 
> > Or, wait until -pre2. Sorry about that.
> 
> Your current tree, + this patch, + my patch solves all of the unloading,
> removing, and loading problems that I had been seeing.
> 
> Thanks for finding this.

I wonder if anyone might look at doing the same sort of fix to
the 2.4.18 working tree?  I experience the same sort of behavior
with usb-uhci on my KT266A board (VT82C586B USB) on 2.4.18-rc1 (and
previous 2.4.x kernels, too).  I'd do it myself, but the patch from
Patrick on inode.c makes me too nervous to do it, since I have
no experience with the filesystem drivers.

Thanks,
Dan Hopper
