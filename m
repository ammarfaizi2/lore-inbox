Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSKGLXj>; Thu, 7 Nov 2002 06:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266488AbSKGLXj>; Thu, 7 Nov 2002 06:23:39 -0500
Received: from gate.perex.cz ([194.212.165.105]:9997 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266480AbSKGLXj>;
	Thu, 7 Nov 2002 06:23:39 -0500
Date: Thu, 7 Nov 2002 12:29:52 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Greg KH <greg@kroah.com>
cc: Adam Belay <ambx1@neo.rr.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP MODULE_DEVICE_TABLE Update - 2.5.46 (3/6)
In-Reply-To: <20021107062816.GC26821@kroah.com>
Message-ID: <Pine.LNX.4.33.0211071224570.875-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Greg KH wrote:

> On Wed, Nov 06, 2002 at 09:02:00PM +0000, Adam Belay wrote:
> > 
> > diff -ur --new-file a/include/linux/module.h b/include/linux/module.h
> > --- a/include/linux/module.h	Wed Oct 30 17:45:58 2002
> > +++ b/include/linux/module.h	Wed Oct 30 17:45:24 2002
> > @@ -239,6 +239,8 @@
> >   * The following is a list of known device types (arg 1),
> >   * and the C types which are to be passed as arg 2.
> >   * pci - struct pci_device_id - List of PCI ids supported by this module
> > + * pnpc - struct pnpc_device_id - List of PnP card ids (PNPBIOS, ISA PnP) supported by this module
> > + * pnp - struct pnp_device_id - List of PnP ids (PNPBIOS, ISA PnP) supported by this module
> 
> I must have missed this last time, but to refresh my memory, why do you
> need two different device types?  What's the difference between a card
> id and a device id?

The card id represents a group of logical devices (device ids). It's good
to know how are devices connected, especially for soundcards where are
several logical devices working together (codec, synth, midi uart).
Addressing these devices separately (as the OSS sound driver does for
example) causes a lot of confusion for users when more cards are in one
system.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

