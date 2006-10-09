Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932955AbWJIQJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955AbWJIQJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932957AbWJIQJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:09:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:12240 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932955AbWJIQJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:09:54 -0400
Date: Mon, 9 Oct 2006 09:08:56 -0700
From: Greg KH <greg@kroah.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1
Message-ID: <20061009160856.GA21862@kroah.com>
References: <20060919012848.4482666d.akpm@osdl.org> <45100272.505@mbligh.org> <20060919093122.d8923263.akpm@osdl.org> <45128BB5.2040004@shadowen.org> <20061007202628.GA30404@kroah.com> <452A4108.2060502@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452A4108.2060502@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 01:31:04PM +0100, Andy Whitcroft wrote:
> Greg KH wrote:
> > On Thu, Sep 21, 2006 at 01:55:17PM +0100, Andy Whitcroft wrote:
> >> Andrew Morton wrote:
> >>> On Tue, 19 Sep 2006 07:45:06 -0700
> >>> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> >>>
> >>>>> - It took maybe ten hours solid work to get this dogpile vaguely
> >>>>>   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
> >>>>>   I guess it's worth briefly testing if you're keen.
> >>>> PPC64 blades shit themselves in a strange way. Possibly the udev
> >>>> breakage you mentioned? Hard to tell really if people are going to
> >>>> go around breaking userspace compatibility ;-(
> >>> What version of udev is it running?
> >> Ok, this is not a blade, but a ppc lpar.  Its running the following
> >> version of udev:
> >>
> >> udevinfo, version 021_bk
> >>
> >> (Assuming of course the help for udev info -V is not lying when it says
> >> "-V       print udev version".)
> > 
> > What distro shipped 021_bk for a version of udev?  What is running on
> > this machine?
> > 
> > (yeah, I know this is a old message, but I'm trying to fix up the udev
> > issues right now...)
> 
> Hmmm.  The machine claims to be running SuSE.  We have it recorded as
> SLES9, but I actually can't find any way to tell from the machine which
> actual release thereof it is.
> 
> This version of ud
> gekko-lp1:~ # udevinfo -V
> udevinfo, version 021_bk
> gekko-lp1:~ # rpm -qa | grep udev
> udev-021-36.32
> 
> This seems to be the correct version for the first GA of SLES9.

Ah, ok, thanks.  But udev on SLES9 does not actually control /dev, only
/dev/disk/, which is not used for booting in any manner, so you should
not have any issues with that old udev.

thanks,

greg k-h
