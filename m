Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTFEVzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbTFEVzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:55:35 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:45473 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S265209AbTFEVzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:55:33 -0400
Date: Fri, 6 Jun 2003 00:07:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       mochel@osdl.org
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <20030605220716.GF608@elf.ucw.cz>
References: <175110000.1054083891@w-hlinder> <20030605211258.GA705@elf.ucw.cz> <20030605211713.GB7029@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605211713.GB7029@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I did this once before but due to some infrastructure changes 
> > > it had to be written again. Here it is, pretty simple. Now
> > > you can see your input devices (except keyboard) listed under
> > > /sys/class/input like this (yes, I do have two mice attached).
> > > At the moment the dev file is created and it contains the
> > > hex value of the major and minor number.
> > 
> > *very* nice, and urgently needed for suspend/resume support.
> 
> No, classes have nothing to do with suspend/resume, that's devices.

> > But should not structure be /bus/sys/keyboard_controller/mouse0? Mouse
> > needs to be suspended before keyboard controller...
> 
> Yes, but this patch is putting stuff in /sys/class/input, not /sys/bus
> :)

Okay, that means that another patch is needed to create hierarchy for
power managment... This sysfs stuff is getting hairy.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
