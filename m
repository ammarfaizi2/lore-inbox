Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSKMVFt>; Wed, 13 Nov 2002 16:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSKMVFs>; Wed, 13 Nov 2002 16:05:48 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10259 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263204AbSKMVFo>;
	Wed, 13 Nov 2002 16:05:44 -0500
Date: Wed, 13 Nov 2002 13:07:11 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Brownell <david-b@pacbell.net>, rusty@rustcorp.com.au,
       kaos <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
Message-ID: <20021113210711.GA7810@kroah.com>
References: <3DD2B1D5.7020903@pacbell.net> <20021113201710.GB7238@kroah.com> <3DD2B8D3.6060106@pacbell.net> <3DD2BD4C.7060502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD2BD4C.7060502@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 03:59:56PM -0500, Jeff Garzik wrote:
> 
> (tangent warning!)
> Another long term idea I would eventually like to realize is the removal 
> of device ids from the C source code.  I don't care where they go -- 
> drivers/net/pci_ids [per directory ids?], drivers/net/3c59x.meta, 
> whereever.  Anywhere but the C source code.  It's quite silly to require 
> a driver rebuild just to add a single PCI id, and further, embedding 
> metadata in C source is rarely a good idea in the long term.  [reference 
> some of Linus's counter-arguments when it was mentioned that Donald 
> Becker's method of including Config.{in,help} data in C source might be 
> useful]

True, this would be nice, but how would the driver know to bind to a new
device, if it isn't rebuilt, and doesn't know about the new id that was
just added?  In the current scheme of driver matching to devices, I
don't see how this could be done.

Not to say I would not want to see this changed to allow this to happen,
I'm very tired of telling USB Palm users to get a new kernel version
just because a single device id was added which their new device has.

thanks,

greg k-h
