Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVJHPR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVJHPR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 11:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVJHPRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 11:17:25 -0400
Received: from mx1.rowland.org ([192.131.102.7]:19982 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932155AbVJHPRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 11:17:25 -0400
Date: Sat, 8 Oct 2005 11:17:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: greg@kroah.com, <usb-storage@lists.one-eyed-alien.net>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [usb-storage] Re: RFC drivers/usb/storage/libusual
In-Reply-To: <20051008003519.5da2b580.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0510081116260.24048-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Oct 2005, Pete Zaitcev wrote:

> On Fri, 7 Oct 2005 10:41:14 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > > --- linux-2.6.14-rc2/drivers/usb/storage/usb.h	2005-09-24 20:32:56.000000000 -0700
> > > +++ linux-2.6.14-rc2-wip/drivers/usb/storage/usb.h	2005-10-06 21:37:10.000000000 -0700
> > ...
> > > -/* Dynamic flag definitions: used in set_bit() etc. */
> > > -#define US_FLIDX_URB_ACTIVE	18  /* 0x00040000  current_urb is in use  */
> > > -#define US_FLIDX_SG_ACTIVE	19  /* 0x00080000  current_sg is in use   */
> 
> > I would prefer to keep these definitions in the usb-storage driver.  They 
> > refer to dynamic aspects of an individual device, not static blacklist or 
> > ID-matching for all devices of a particular type.  As such, they are of no 
> > interest to ub or libusual.
> 
> OK
> 
> > > + * Observe that usb-storage blatantly mixes set_bit() and normal
> > > + * shift and mask operations on flags, which is strictly illegal.
> > > + * And it probably even works for all flags except GO_SLOW and NO_WP_DETECT.
> 
> > Once the device is running, the shift/mask operations are used _only_ for
> > reading, never for writing.
> 
> OK
> 
> How about now?

This is better, thank you.

Alan Stern

