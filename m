Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSKACpP>; Thu, 31 Oct 2002 21:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265422AbSKACpP>; Thu, 31 Oct 2002 21:45:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9988 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262812AbSKACpO>;
	Thu, 31 Oct 2002 21:45:14 -0500
Date: Thu, 31 Oct 2002 18:48:41 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFC: bare pci configuration access functions ?
Message-ID: <20021101024841.GD13031@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF6C@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF6C@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 06:39:26PM -0800, Lee, Jung-Ik wrote:
> 
> Platform management, early console access, acpi, hotplug io-node w/ root,...
> pci_bus based access is useless before pci driver is initialized.
> All exceptions will be forced to use fake structs...
> Sounds we need to be ready to live with all exceptions here too :)
> Or just to make them all happy with that simple bare functions.

Ok, let's make them happy with bare functions, _if_ we have to.  Places
that do not have to will be gleefully pointed out and mocked :)

> OK, if simple and pure pci config access is not possible in Linux land,
> let pci driver fake itself, not everyone else :)
> Just export the two APIs like pci_config_{read|write}(s,b,d,f,s,v),
> or the ones in acpi driver. Hide the fake pci_bus manipulation in them. 
> This way is way better than having everyone fake pci driver ;-)

I agree.  But can we do this for all archs?  I don't know, and look
forward to your patch proving this will work.  Without all arch support
of this, I can't justify only exporting the functions for i386 and ia64.

thanks,

greg k-h
