Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVK2GF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVK2GF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVK2GF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:05:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:385 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751283AbVK2GF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:05:29 -0500
Date: Mon, 28 Nov 2005 21:44:11 -0800
From: Greg KH <greg@kroah.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Updates to sysfs_create_subdir()
Message-ID: <20051129054411.GB11013@kroah.com>
References: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net> <20051128204950.GC17740@kroah.com> <37362F2B-D74A-4A40-905B-B25264B6C4AB@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37362F2B-D74A-4A40-905B-B25264B6C4AB@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 08:10:36PM -0500, Kyle Moffett wrote:
> On Nov 28, 2005, at 15:49, Greg KH wrote:
> >On Wed, Nov 23, 2005 at 01:56:29PM -0800, Patrick Mochel wrote:
> >>The patch below addresses this issue by parsing the subdirectory  
> >>name and creating any parent directories delineated by a '/'.
> >
> >Generally I never liked parsing stuff like this in the kernel (proc  
> >and devfs both do this).  That being said, I do see the need to  
> >make subdirs like this easier.
> >
> >But what about cleanups?  If I create an attribute group "foo/baz/ 
> >x/" and then remove it, will the subdirectories get cleaned up  
> >too?  What about if I had created a group "foo/baz/y/" after the  
> >"x" one?  Or just "foo/baz"?
> 
> If the kernel gets this, then udev needs to allow attributes with  
> more generic paths too.  It would be nice if I could use this [Pulled  
> from the sample udev output halfway down this page: http:// 
> www.reactivated.net/writing_udev_rules.html#identify-sysfs].
> 
> BUS="scsi", SYSFS{../../../manufacturer}="Tekom Technologies, Inc",  
> NAME="my_camera"

Why can't you do this today?  Have you tried it?

thanks,

greg k-h
