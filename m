Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVISO3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVISO3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 10:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVISO3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 10:29:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:1153 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932432AbVISO3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 10:29:52 -0400
Date: Mon, 19 Sep 2005 16:29:50 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ST 5481 USB driver
Message-ID: <20050919142950.GA13757@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050917215242.GA27813@pingi3.kke.suse.de> <20050917222640.GA27785@kroah.com> <20050919142121.GA2959@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050919142121.GA2959@pingi3.kke.suse.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 04:21:21PM +0200, Karsten Keil wrote:
> Hi Greg,
> 
> On Sat, Sep 17, 2005 at 03:26:40PM -0700, Greg KH wrote:
> > On Sat, Sep 17, 2005 at 11:52:42PM +0200, Karsten Keil wrote:
> > >  	// Cancel all USB transfers on this B channel
> > > +	b_out->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
> > >  	usb_unlink_urb(b_out->urb[0]);
> > > +	b_out->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
> > 
> > URB_ASYNC_UNLINK is now gone in 2.6.14-rc1, so this change will break
> > the build :(
> > 
> 
> OK, what would be the correct fix ?

Found out myself, that usb_unlink_urb is always async now, so URB_ASYNC_UNLINK is
really obsolete and removing the lines should be enough.

> Documentation/usb/URB.txt still point to URB_ASYNC_UNLINK for such cases.
> 

Should be adapted too.

-- 
Karsten Keil
SuSE Labs
ISDN development
