Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVAUANt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVAUANt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVAUANp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:13:45 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:17662 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262231AbVAUAMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:12:22 -0500
Date: Thu, 20 Jan 2005 16:04:06 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>, zaitcev@yahoo.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on USB_STORAGE=n
Message-ID: <20050121000406.GB14469@kroah.com>
References: <20041220001644.GI21288@stusta.de> <20041220003146.GB11358@kroah.com> <20041223024031.GO5217@stusta.de> <20050119220707.GM4151@kroah.com> <20050120024900.GA5506@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120024900.GA5506@one-eyed-alien.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 06:49:00PM -0800, Matthew Dharm wrote:
> On Wed, Jan 19, 2005 at 02:07:07PM -0800, Greg KH wrote:
> > On Thu, Dec 23, 2004 at 03:40:31AM +0100, Adrian Bunk wrote:
> > > On Sun, Dec 19, 2004 at 04:31:46PM -0800, Greg KH wrote:
> > > > On Mon, Dec 20, 2004 at 01:16:44AM +0100, Adrian Bunk wrote:
> > > > > I've already seen people crippling their usb-storage driver with 
> > > > > enabling BLK_DEV_UB - and I doubt the warning in the help text added 
> > > > > after 2.6.9 will fix all such problems.
> > > > > 
> > > > > Is there except for kernel size any good reason for using BLK_DEV_UB 
> > > > > instead of USB_STORAGE?
> > > > 
> > > > You don't want to use the scsi layer?  You like the stability of it at
> > > > times?  :)
> > > > 
> > > > > If not, I'd suggest the patch below to let BLK_DEV_UB depend
> > > > > on EMBEDDED.
> > > > 
> > > > No, it's good for non-embedded boxes too.
> > > 
> > > 
> > > My current understanding is:
> > > - BLK_DEV_UB supports a subset of what USB_STORAGE can support
> > > - for an average user, there's no reason to enable BLK_DEV_UB
> > > - if you really know what you are doing, there might be several reasons
> > >   why you might want to use BLK_DEV_UB
> > 
> > I have been running with just the code portion of this patch for a while
> > now, with good results (no Kconfig changes.)
> > 
> > Pete and Matt, do you mind me applying the following portion of the
> > patch to the kernel tree?
> 
> I have no objection.

Ok, I've commited the change to my trees, thanks.

greg k-h
