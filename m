Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135882AbRDYPYv>; Wed, 25 Apr 2001 11:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135883AbRDYPYk>; Wed, 25 Apr 2001 11:24:40 -0400
Received: from saloma.stu.rpi.edu ([128.113.199.230]:48649 "EHLO incandescent")
	by vger.kernel.org with ESMTP id <S135882AbRDYPYc>;
	Wed, 25 Apr 2001 11:24:32 -0400
Date: Wed, 25 Apr 2001 11:24:02 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Marcus Meissner <Marcus.Meissner@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: trident , pci_enable_device moved
Message-ID: <20010425112402.A31842@mp3revolution.net>
In-Reply-To: <20010425090438.A12672@caldera.de> <20010425130624.A3216@caldera.de> <20010425104949.A31649@mp3revolution.net> <3AE6E797.A31803BE@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AE6E797.A31803BE@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Apr 25, 2001 at 11:04:55AM -0400
X-Operating-System: Linux incandescent 2.4.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I saw "trident" and thought video.  Sorry, marcus.  :)

This is what I was told (it was only needed for secondary video
devices).  From that, I would expect that all video devices would
need it, just in case they happened to be the second card.  Am I
missing some subtlety in some of the video driers/chipsets that
wouldn't allow them to be used as a second video device (therefore
not requiring pci_enable_device)?


On Wed, Apr 25, 2001 at 11:04:55AM -0400, Jeff Garzik wrote:
> 
> Andres Salomon wrote:
> > Just a warning; I was informed by Alan that doing this for video
> > drivers was unnecessary, since video devices were already enabled
> > during bootup.
> 
> To clarify:  the primary display device is enabled and initialized, and
> its video BIOS executed, when during BIOS startup and before the Linux
> kernel gets control.  All other display devices are not only not
> initialized, but they are disabled as well.
> 
> Marcus is doing sound ATM so I doubt this matters to him...
> 
> -- 
> Jeff Garzik      | The difference between America and England is that
> Building 1024    | the English think 100 miles is a long distance and
> MandrakeSoft     | the Americans think 100 years is a long time.
>                  |      (random fortune)
> 

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
