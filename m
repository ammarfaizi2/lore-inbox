Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263335AbTDCJip>; Thu, 3 Apr 2003 04:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263337AbTDCJip>; Thu, 3 Apr 2003 04:38:45 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:58594 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263335AbTDCJio>; Thu, 3 Apr 2003 04:38:44 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 3 Apr 2003 10:57:57 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Greg KH <greg@kroah.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>, Frank Davis <fdavis@si.rr.com>
Subject: Re: [patch] add i2c_clientname()
Message-ID: <20030403085757.GA13683@bytesex.org>
References: <20030402165116.GA24766@bytesex.org> <20030403010112.GA5407@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403010112.GA5407@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch just adds a #define and a inline function to hide the
> > "i2c_client->name" => "i2c_client->dev.name" move introduced by
> > the recent i2c updates.  That makes it easier to build i2c drivers
> > on both 2.4 and 2.5 kernels.
> 
> This is going to be a harder and harder problem as time goes on, and as
> the i2c core changes over time.  I would just give up now :)

I don't, interfacing with the i2c core is not that much code in most
drivers.

> > +#define I2C_DEVNAME(str)   .dev = { .name = str }
> 
> Why this macro?  You don't use it in your driver, right?

I use it in my current driver code (patches are at
http://bytesex.org/patches/wip/).  Submitting those patches doesn't
make sense before that patch is in because I would get flooded with
"bttv doesn't compile any more" style mails ...

  Gerd

-- 
Michael Moore for president!
