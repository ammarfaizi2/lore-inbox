Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUIIRR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUIIRR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUIIRR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:17:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:20654 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266295AbUIIRRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:17:54 -0400
Date: Thu, 9 Sep 2004 10:14:46 -0700
From: Greg KH <greg@kroah.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: another oops, this time in 2.6.9-rc1-mm4
Message-ID: <20040909171446.GD14163@kroah.com>
References: <200409090107.05415.gene.heskett@verizon.net> <20040909063843.GB8352@kroah.com> <200409091134.22299.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409091134.22299.petkov@uni-muenster.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 11:34:22AM +0200, Borislav Petkov wrote:
> On Thursday 09 September 2004 08:38, Greg KH wrote:
> > On Thu, Sep 09, 2004 at 01:07:05AM -0400, Gene Heskett wrote:
> > > Greetings;
> > >
> > > I just had to reboot back to -mm2 after playing with some printer configs
> > > in cups, although the test pages worked, so I'm not sure what this all
> > > about, from var log/messages:
> > >
> > > Sep  8 23:13:42 coyote cups: cupsd -HUP succeeded
> > > Sep  8 23:13:43 coyote kernel: usb_unlink_urb() is deprecated for
> > > synchronous unlinks.  Use usb_kill_urb() Sep  8 23:13:43 coyote kernel:
> > > Badness in usb_unlink_urb at drivers/usb/core/urb.c:456 Sep  8 23:13:44
> > > coyote kernel:  [<c01048ce>] dump_stack+0x1e/0x20 Sep  8 23:13:44 coyote
> > > kernel:  [<c0295f35>] usb_unlink_urb+0x85/0xa0 Sep  8 23:13:44 coyote
> > > kernel:  [<c02a7447>] usblp_unlink_urbs+0x17/0x40 Sep  8 23:13:44 coyote
> > > kernel:  [<c02a74a8>] usblp_release+0x38/0x60 Sep  8 23:13:44 coyote
> > > kernel:  [<c01501ea>] __fput+0x12a/0x140
> > > Sep  8 23:13:44 coyote kernel:  [<c014e8e7>] filp_close+0x57/0x80
> > > Sep  8 23:13:44 coyote kernel:  [<c014e971>] sys_close+0x61/0x90
> > > Sep  8 23:13:44 coyote kernel:  [<c010425d>] sysenter_past_esp+0x52/0x71
> > >
> > > repeat about 40-50 times before I rebooted cause it was very sluggish.
> >
> > It's not a oops, it's a message that the driver needs to be fixed up,
> > and can be ignored safely (but sending a patch to fix the driver would
> > be even nicer...)
> >
> > thanks,
> >
> > greg k-h
> > -
> 
> Hi there Greg,
> please be gentle, this is my first time :)
> The situation looked trivial so I thought I should give it a try:

Hm, ok, next time try adding a "Signed-off-by:" line as documented in
Documentation/SubmittingPatches, and make the patch be able to be
applied with the '-p1' option to patch, as that same file details.

But as this was so simple, I took it the way it was, and have applied it
to my trees.

thanks,

greg k-h
