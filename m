Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTFEVGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265138AbTFEVCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:02:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10195 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265137AbTFEVBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:01:39 -0400
Date: Thu, 5 Jun 2003 14:17:13 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       mochel@osdl.org
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <20030605211713.GB7029@kroah.com>
References: <175110000.1054083891@w-hlinder> <20030605211258.GA705@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605211258.GA705@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 11:12:58PM +0200, Pavel Machek wrote:
> Hi!
> 
> > I did this once before but due to some infrastructure changes 
> > it had to be written again. Here it is, pretty simple. Now
> > you can see your input devices (except keyboard) listed under
> > /sys/class/input like this (yes, I do have two mice attached).
> > At the moment the dev file is created and it contains the
> > hex value of the major and minor number.
> 
> *very* nice, and urgently needed for suspend/resume support.

No, classes have nothing to do with suspend/resume, that's devices.

> But should not structure be /bus/sys/keyboard_controller/mouse0? Mouse
> needs to be suspended before keyboard controller...

Yes, but this patch is putting stuff in /sys/class/input, not /sys/bus
:)

thanks,

greg k-h
