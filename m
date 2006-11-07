Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752694AbWKGEIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbWKGEIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 23:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbWKGEIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 23:08:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:16060 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752694AbWKGEIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 23:08:12 -0500
Date: Tue, 7 Nov 2006 13:07:44 +0900
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       Wilco Beekhuizen <wilcobeekhuizen@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
Message-ID: <20061107040744.GA23641@kroah.com>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com> <1162817254.5460.4.camel@localhost.localdomain> <1162847625.10086.36.camel@localhost.localdomain> <20061107012519.GC25719@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107012519.GC25719@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 08:25:19PM -0500, Dave Jones wrote:
> On Mon, Nov 06, 2006 at 09:13:45PM +0000, Alan Cox wrote:
> 
>  > +static const struct pci_device_id via_vlink_fixup_tbl[] = {
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233_0), 17},
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233A), 17 },
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233C_0), 17 },
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8235), 16 },
>  > +	/* May not be needed for the 8237 */
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237), 15 },
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237A), 15 },
>  >  	{ 0, },
> 
> This got me wondering what PCI_VDEVICE was, so I went looking.
> It's a libata'ism it seems with the comment..
> 
> /* move to PCI layer? */

I have no objection to moving this to pci.h.  Feel free to send me a
patch.

thanks,

greg k-h
