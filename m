Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWAECHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWAECHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAECHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:07:54 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:54682 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751019AbWAECHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:07:53 -0500
Date: Wed, 4 Jan 2006 18:07:42 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.15
Message-ID: <20060105020742.GA18815@suse.de>
References: <20060105004826.GA17328@kroah.com> <Pine.LNX.4.64.0601041724560.3279@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601041724560.3279@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 05:38:05PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 4 Jan 2006, Greg KH wrote:
> >
> > Here are a lot of driver core patches for 2.6.15.  They have all been in
> > the past few -mm releases with no problems.
> 
> Strange, because it doesn't merge with your other own changes. It might be 
> an ordering thing (ie they might have merged fine in another order). Or 
> maybe it's just because the -mm scripts will force-apply patches (or drop 
> them).
> 
> Anyway, there were clashes in drivers/usb/core/usb.c with the patch "USB: 
> fix usb_find_interface for ppc64" that came through your USB changes, and 
> that gets a merge error with the uevent/hotplug thing.
> 
> I can do the trivial manual fixup, but when I do, I have two copies of 
> "usb_match_id()": one in drivers/usb/core/driver.c and one in 
> drivers/usb/core/usb.c.
> 
> I've pushed out my tree, so that you can see for yourself (it seems to 
> have mirrored out too).

Yeah, I was wondering how that would merge together, I'll take a look at
the tree after dinner and fix up the problem (there should only be one
copy of that function.)

thanks,

greg k-h
