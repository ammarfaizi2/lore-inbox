Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVARIGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVARIGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVARIGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:06:14 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:28420 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261178AbVARIFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:05:55 -0500
Date: Tue, 18 Jan 2005 09:05:52 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
Message-ID: <20050118080552.GC8747@pclin040.win.tue.nl>
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org> <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk> <41EC5207.3030003@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC5207.3030003@osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 04:02:15PM -0800, Randy.Dunlap wrote:
> Al Viro wrote:
> >On Tue, Jan 18, 2005 at 02:54:24AM +0000, Daniel Drake wrote:
> >
> >>Retry up to 20 times if mounting the root device fails.  This fixes 
> >>booting
> >>from usb-storage devices, which no longer make their partitions 
> >>immediately
> >>available.
> >
> >
> >Sigh...  So we can very well get device coming up in the middle of a loop
> >and get the actual attempts to mount the sucker in wrong order.  How 
> >nice...
> >
> >Folks, that's not a solution.  And kludges like that really have no
> >business being there - they only hide the problem and make it harder
> >to reproduce.
> 
> Is there a solution other than initrd/initramfs ?

On the one hand, I entirely agree with Al - this guessing business
is a bad kludge, and building complications on top of it makes
things worse.

On the other hand, we do already have the rootfstype= option,
so one can avoid trying things in the "wrong" order.

Andries
