Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275506AbTHMV0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275507AbTHMV0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:26:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:30424 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275506AbTHMV0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:26:05 -0400
Date: Wed, 13 Aug 2003 14:26:11 -0700
From: Greg KH <greg@kroah.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813212611.GA6652@kroah.com>
References: <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <m31xvpe2ar.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m31xvpe2ar.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 10:21:48PM +0200, Krzysztof Halasa wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > -	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC9100,
> > -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701) },
> 
> We might even consider
> 
> +	{ PCI_DEVICE(BROADCOM, TIGON3_5700) },
> +	{ PCI_DEVICE(BROADCOM, TIGON3_5701) },
> 
> As probably using anything but PCI_DEVICE_ID_* and PCI_VENDOR_ID_*
> would be a bug.

Someone else mentioned that to me, but that's just mean as this file
shows that not all device ids are in the pci id table.

Maybe that's a 2.7 thing :)

thanks,

greg k-h
