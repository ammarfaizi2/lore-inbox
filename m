Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbULQXvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbULQXvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbULQXvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:51:03 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46537 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262232AbULQXvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:51:00 -0500
Date: Fri, 17 Dec 2004 15:48:54 -0800
From: Greg KH <greg@kroah.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Al Hooton <al@hootons.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ioctl assignment strategy?
Message-ID: <20041217234854.GA24506@kroah.com>
References: <1103067067.2826.92.camel@chatsworth.hootons.org> <20041215004620.GA15850@kroah.com> <41C04FFA.6010407@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C04FFA.6010407@nortelnetworks.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 08:53:46AM -0600, Chris Friesen wrote:
> Greg KH wrote:
> 
> >Minor one coming, why do you want to use an ioctl?  ioctls are generally
> >frowned upon these days, and trying to add a new one is a tough and
> >arduous process, that is not for the weak, or faint of heart.
> 
> Just curious--what other options would you suggest for arbitrary char 
> devices to allow for control that doesn't fit nicely into the read/write 
> paradigm?

Rethink the way you want to control your device.  Seriously, a lot of
ioctls can be broken down into single device files, single sysfs files,
or other such things (a whole new fs as a last resort too.)

So, what does your ioctls do?

thanks,

greg k-h
