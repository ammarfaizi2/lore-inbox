Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSKLBLU>; Mon, 11 Nov 2002 20:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265821AbSKLBLU>; Mon, 11 Nov 2002 20:11:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22286 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265798AbSKLBLT>;
	Mon, 11 Nov 2002 20:11:19 -0500
Date: Mon, 11 Nov 2002 17:13:04 -0800
From: Greg KH <greg@kroah.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Adam Belay <ambx1@neo.rr.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP MODULE_DEVICE_TABLE Update - 2.5.46 (3/6)
Message-ID: <20021112011304.GE26926@kroah.com>
References: <20021107062816.GC26821@kroah.com> <Pine.LNX.4.33.0211071224570.875-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211071224570.875-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 12:29:52PM +0100, Jaroslav Kysela wrote:
> On Wed, 6 Nov 2002, Greg KH wrote:
> 
> > On Wed, Nov 06, 2002 at 09:02:00PM +0000, Adam Belay wrote:
> > > 
> > > diff -ur --new-file a/include/linux/module.h b/include/linux/module.h
> > > --- a/include/linux/module.h	Wed Oct 30 17:45:58 2002
> > > +++ b/include/linux/module.h	Wed Oct 30 17:45:24 2002
> > > @@ -239,6 +239,8 @@
> > >   * The following is a list of known device types (arg 1),
> > >   * and the C types which are to be passed as arg 2.
> > >   * pci - struct pci_device_id - List of PCI ids supported by this module
> > > + * pnpc - struct pnpc_device_id - List of PnP card ids (PNPBIOS, ISA PnP) supported by this module
> > > + * pnp - struct pnp_device_id - List of PnP ids (PNPBIOS, ISA PnP) supported by this module
> > 
> > I must have missed this last time, but to refresh my memory, why do you
> > need two different device types?  What's the difference between a card
> > id and a device id?
> 
> The card id represents a group of logical devices (device ids). It's good
> to know how are devices connected, especially for soundcards where are
> several logical devices working together (codec, synth, midi uart).
> Addressing these devices separately (as the OSS sound driver does for
> example) causes a lot of confusion for users when more cards are in one
> system.

But I don't see any code using this functionality in the kernel right
now (or in the patches just sent out.)  Is it really needed if there is
no users?

thanks,

greg k-h
