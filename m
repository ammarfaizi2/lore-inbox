Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUHHDTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUHHDTN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 23:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUHHDTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 23:19:13 -0400
Received: from mproxy.gmail.com ([216.239.56.248]:59674 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265106AbUHHDTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 23:19:08 -0400
Message-ID: <944a03770408072019362f4a33@mail.gmail.com>
Date: Sat, 7 Aug 2004 23:19:07 -0400
From: Michael Guterl <mguterl@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
Cc: linux-usb-devel@lists.sourceforge.net,
       "Luis Miguel =?ISO-8859-1?Q?=20Garc=FD?= Mancebo" <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
In-Reply-To: <200408071051.23047.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408022100.54850.ktech@wanadoo.es> <200408050834.27452.david-b@pacbell.net> <944a03770408051005614aa25e@mail.gmail.com> <200408071051.23047.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What if Alan's assumptions that it is in ACPI and not USB are correct?
 Personally I don't know enough to handle really any of the tasks you
suggested.  I figured the fact that reverting bk-acpi.patch and
bk-usb.patch would throw up some kind of red flag, that something in
there was maybe messed up and merged in.

On Sat, 7 Aug 2004 10:51:23 -0700, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 05 August 2004 10:05, Michael Guterl wrote:
> > Thanks for the reply David, but where exactly does this leave me and
> > the others experiencing this problem?  Is there any more information I
> > can provide that might help?  Any possible solutions, patches, etc?
> 
> It leaves you (and others) with the problem partially isolated, so that
> someone with time to track it down will have that much less work to do.
> 
> The most effective solutions involve someone who has the problem
> actually stepping up and debugging the whole thing, then providing
> a patch fixing the problem.
> 
> A second-best would be collaboration between someone who has
> the time (not me!) and someone who has the problem (you?) to
> remotely debug the problem.
> 
> A third-best would be for someone (you?) to find out exactly which patch
> caused the problem -- a binary search of the USB patches, luckily it's
> made easier by the fact that it could only be a change in HID, usbcore,
> or some HCD.  (And most likely IMO it's usbcore.)  Then that patch can
> either be further debugged, or reverted.
> 
> - Dave
> 
> 
> > On Thu, 5 Aug 2004 08:34:27 -0700, David Brownell <david-b@pacbell.net>
> wrote:
> > > ....
> 
> 
> > >
> > > The dmesg output shows this is a HID failure.  It's likely connected
> > > with some changes in the unlink logic, since that's what returns
> > > the "-ENOENT" status.  The usb_kill_urb() changes added a new
> > > URB state as I recall, maybe that's part of the issue here... since
> > > that routine replaced the previous "synchronous unlink" logic.
> > >
> > > - Dave
> > >
> > >
> >
>
