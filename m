Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVK2GzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVK2GzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVK2GzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:55:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:48536 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751331AbVK2GzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:55:24 -0500
Date: Mon, 28 Nov 2005 22:55:12 -0800
From: Greg KH <greg@kroah.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Updates to sysfs_create_subdir()
Message-ID: <20051129065512.GA4945@kroah.com>
References: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net> <20051128204950.GC17740@kroah.com> <37362F2B-D74A-4A40-905B-B25264B6C4AB@mac.com> <20051129054411.GB11013@kroah.com> <B43BE39F-16A2-4BFE-A6AA-0F4439780F1C@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B43BE39F-16A2-4BFE-A6AA-0F4439780F1C@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 01:41:01AM -0500, Kyle Moffett wrote:
> On Nov 29, 2005, at 00:44, Greg KH wrote:
> >On Mon, Nov 28, 2005 at 08:10:36PM -0500, Kyle Moffett wrote:
> >>If the kernel gets this, then udev needs to allow attributes with  
> >>more generic paths too.  It would be nice if I could use this  
> >>[Pulled from the sample udev output halfway down this page: http:// 
> >>www.reactivated.net/writing_udev_rules.html#identify-sysfs].
> >>
> >>BUS="scsi", SYSFS{../../../manufacturer}="Tekom Technologies,  
> >>Inc", NAME="my_camera"
> >
> >Why can't you do this today?  Have you tried it?
> 
> Hmm, no, I don't suppose I have.  I guess I was taking the udev docs  
> and other similar pages at their word that you couldn't match things  
> in multiple subdirs.  *tries*  Interesting; it appears to work, but  
> it would be nice if it was documented somewhere; this is _really_  
> handy for certain devices with partial or missing udev support.

Patches for documentation is always gladly accepted :)

> I do have one question, though.  Is there any way to access the  
> "DEVICE" or "SUBSYSTEM" values of those parent sysfs nodes?  I can  
> see that those are symlinks in sysfs to other sysfs dirs, so there's  
> no real way to match them with SYSFS{*},

As they are symlinks, you might just be able to follow them as part of
the path.  But odds are, something in libsysfs would prevent that from
working that way...

thanks,

greg k-h
