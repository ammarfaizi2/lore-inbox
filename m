Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275294AbTHMRwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275291AbTHMRub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:50:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:29444 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S275287AbTHMRuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:50:19 -0400
Date: Wed, 13 Aug 2003 19:50:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813175009.GA12128@mars.ravnborg.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, rddunlap@osdl.org, davej@redhat.com,
	willy@debian.org, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <20030812180158.GA1416@kroah.com> <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030813173150.GA3317@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 10:31:51AM -0700, Greg KH wrote:
> 
> How about this patch?  If you like it I'll add the pci.h change to the
> tree and let you take the tg3.c part.
> 
> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700) },
Why not without the extra {}'s so something like this:

> +	PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701),
> +	PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702),
>  	{ 0, }
>  };
>  
> +#define PCI_DEVICE(vend,dev) { \
> +	.vendor = (vend), .device = (dev), \
> +	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID }

	Sam
