Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUCJXH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUCJXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:03:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:26331 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262882AbUCJW6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:58:06 -0500
Date: Wed, 10 Mar 2004 14:53:41 -0800
From: Greg KH <greg@kroah.com>
To: Dominik Kubla <dominik@kubla.de>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040310225341.GF24336@kroah.com>
References: <20040303000957.GA11755@kroah.com> <4046CE91.50701@kubla.de> <20040304184442.GH13907@kroah.com> <40482ACC.3070504@kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40482ACC.3070504@kubla.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 08:22:52AM +0100, Dominik Kubla wrote:
> >Permissions are based on the name of the device.
> >
> 
> Oh, i realized that. But my point is: shouldn't they be based on the 
> CLASS of the device rather than the name? After all the names are 
> changeable, but the class is not...
> 
> I checked the hotplug-devel archives and saw that somebody has already
> posted a patch doing that. So i guess the question boils down to:
> Will you accept it or not?

Ok, I'm convinced now.  I just took a patch that does this.

> >>Is there a way to distinguish between CD-ROM, DVD-ROM and writers? It is
> >>not unusual  these days to  have at least a  DVD-ROM and CD-Writer  in a
> >>desktop system. If you look at the  latest offers from Dell you will see
> >>that they tend to include a DVD-ROM  and a DVD+RW drive in at least some
> >>configurations. So  it would  be nice  if udev would  be able  to create
> >>links like "cdwriter", "dvd" and "dvdwriter" out of the box. (And assign
> >>the appropriate group to the device nodes...)
> >
> >
> >You can do that, just name them differently based on the type of device.
> >Also, try providing a symlink to "cdrom" to not break what users are
> >expecting.
> 
> Would you care to explain how to do it?

Is there some way that you can see in sysfs or in /proc that you can use
to detect these devices differently?

thanks,

greg k-h
