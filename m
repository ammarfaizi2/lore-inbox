Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbVLOApL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbVLOApL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVLOApL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:45:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:24752 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965131AbVLOApJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:45:09 -0500
Date: Wed, 14 Dec 2005 16:44:34 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, katzj@redhat.com
Subject: Re: "block" symlink in sysfs for a multifunction device
Message-ID: <20051215004434.GA4148@kroah.com>
References: <20051212134904.225dcc5d.zaitcev@redhat.com> <20051214055019.GA23036@kroah.com> <20051214152615.13b6b105.zaitcev@redhat.com> <20051214234255.GA3275@kroah.com> <20051214161018.254e75bb.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214161018.254e75bb.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 04:10:18PM -0800, Pete Zaitcev wrote:
> On Wed, 14 Dec 2005 15:42:55 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > And if this isn't acceptable, what would be?
> > 
> > Just because kudzu is messed up... :)
> 
> I thought maybe creating some struct kobject by hand for every LUN.
> This is undesirable mainly because I do not trust myself with handling
> struct kobject at all (currently I only use block device API and so I
> blame Jens every time there's a problem :-)). But if Jeremy cannot
> work around it, I would have to think about it - maybe as a Fedora-specific
> patch.

I don't understand, what exactly would you like to see in the block
device's device directory?  With this patch, we correctly point back to
all of the different block devices controlled by this device.

I'm curious as to why kudzu even cares about this?

And, how does it handle things like mult-port serial devices, which have
all of the multiple class device symlinks in one single device
directory, just like this.

thanks,

greg k-h
