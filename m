Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTFEWAz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbTFEWAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:00:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:8378 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265215AbTFEWAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:00:53 -0400
Date: Thu, 5 Jun 2003 15:16:33 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       mochel@osdl.org
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <20030605221633.GA7282@kroah.com>
References: <175110000.1054083891@w-hlinder> <20030605211258.GA705@elf.ucw.cz> <20030605211713.GB7029@kroah.com> <20030605220716.GF608@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605220716.GF608@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 12:07:16AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > I did this once before but due to some infrastructure changes 
> > > > it had to be written again. Here it is, pretty simple. Now
> > > > you can see your input devices (except keyboard) listed under
> > > > /sys/class/input like this (yes, I do have two mice attached).
> > > > At the moment the dev file is created and it contains the
> > > > hex value of the major and minor number.
> > > 
> > > *very* nice, and urgently needed for suspend/resume support.
> > 
> > No, classes have nothing to do with suspend/resume, that's devices.
> 
> > > But should not structure be /bus/sys/keyboard_controller/mouse0? Mouse
> > > needs to be suspended before keyboard controller...
> > 
> > Yes, but this patch is putting stuff in /sys/class/input, not /sys/bus
> > :)
> 
> Okay, that means that another patch is needed to create hierarchy for
> power managment... This sysfs stuff is getting hairy.

No, the current /sys/bus tree should be fine for showing the heirachy
for power management.  What in there do you feel is lacking?

greg k-h
