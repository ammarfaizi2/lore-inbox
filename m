Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUCDSuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUCDSuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:50:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:1436 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262072AbUCDSuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:50:06 -0500
Date: Thu, 4 Mar 2004 10:44:44 -0800
From: Greg KH <greg@kroah.com>
To: Dominik Kubla <dominik@kubla.de>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304184442.GH13907@kroah.com>
References: <20040303000957.GA11755@kroah.com> <4046CE91.50701@kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4046CE91.50701@kubla.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 07:37:05AM +0100, Dominik Kubla wrote:
> On Tue, Mar 02, 2004 at 04:09:57PM -0800, Greg KH wrote:
> >I've released the 021 version of udev.  It can be found at:
> > 	kernel.org/pub/linux/utils/kernel/hotplug/udev-021.tar.gz
> 
> Nice work, but  I ran into a problem  on my Debian system and  i did use
> the udev-019 permissions file for  Debian. What's the story here anyway?

Debian has a "official" package.  I recommend you use that if you have a
Debian system.

> I seem to be unable to assign group "cdrom" to my ATAPI DVD/CD-RW drive.
> It appears to me that the permissions syntax is missing a possibility to
> overide the owner/group based upon the class of the device.

Permissions are based on the name of the device.

> Is there a way to distinguish between CD-ROM, DVD-ROM and writers? It is
> not unusual  these days to  have at least a  DVD-ROM and CD-Writer  in a
> desktop system. If you look at the  latest offers from Dell you will see
> that they tend to include a DVD-ROM  and a DVD+RW drive in at least some
> configurations. So  it would  be nice  if udev would  be able  to create
> links like "cdwriter", "dvd" and "dvdwriter" out of the box. (And assign
> the appropriate group to the device nodes...)

You can do that, just name them differently based on the type of device.
Also, try providing a symlink to "cdrom" to not break what users are
expecting.

thanks,

greg k-h
