Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291589AbSBMLg7>; Wed, 13 Feb 2002 06:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291591AbSBMLgt>; Wed, 13 Feb 2002 06:36:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:21002
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291589AbSBMLga>; Wed, 13 Feb 2002 06:36:30 -0500
Date: Wed, 13 Feb 2002 03:26:04 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020213122607.A31348@suse.cz>
Message-ID: <Pine.LNX.4.10.10202130323230.1888-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Vojtech Pavlik wrote:

> > > None of this is relevant to IDE on Linux.
> > 
> > Well not yet but here is a hint, all future hardware will be MMIO.
> 
> That's nice. Actually, that's the case on many archs already.

Well I am totally aware of this issue and know it needs to be addressed.

> > Meaning all IO is performed under DMA over the ATA-Bridge.
> 
> Ugh? This is not the meaning of your first sentence. 

Surprise

> > Specifically PIO operations are transacted over VDMA to the Bridge and
> > executed as PIO by the Bridge.
> 
> Care to explain in more detail? Hmm, I suppose not.
> 
> I suppose you mean that the IDE controller will use BM DMA w/ SG for
> every transaction and the PIO/DMA/UDMA mode will only be different on
> the IDE BUS. That's very nice, and actually will make things simpler.
> 
> I still don't see how any of the proposed patches kill the possibility
> to do this.
> 
> > > Perhaps you mean PIO using SG-lists to put the data into the right
> > > places. But I still don't see a problem with this and the proposed patch.
> > > 
> > > > Does a function struct for handling IO and MMIO help?
> > > 
> > > Ugh? What is "function struct"?
> > 
> > Since the future will be a mess, and it is possible to have IO/MMIO on the
> > same HOST it will be come more fun than you can imagine.
> 
> The future (kernel point of view) will be how we make it to be. If we
> make a lot of messy code, the future will be a mess. This seems to be
> what you're doing. (Sorry.)

Oh I have the hardware and the newest stuff will have in a few days.
The future is Q3 2002 or sooner.

regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

