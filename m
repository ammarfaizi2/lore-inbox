Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131118AbRA3TxL>; Tue, 30 Jan 2001 14:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132443AbRA3TxE>; Tue, 30 Jan 2001 14:53:04 -0500
Received: from [64.160.188.242] ([64.160.188.242]:50185 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S132394AbRA3Twz>; Tue, 30 Jan 2001 14:52:55 -0500
Date: Tue, 30 Jan 2001 11:51:58 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Nicholas Knight <tegeran@home.com>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.30.0101301557540.11641-100000@svea.tellus>
Message-ID: <Pine.LNX.4.21.0101301145360.13653-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually what rumors are you hearing?

Right now I can tell you from personal experience that the VIA VT82C686A
chipset is causing kernel deaths, corrupted data on my drives, and UDMA
issues (meaning that when I enable the UDMA support the kernel
CONSISTENTLY crashes.)

This is all pre patch-2.4.1-pre11. I've not tested the new patch as of yet
as I was in a car accident and have not felt well enough to mess with
things. I will however be testing the new patch in about a half hour. The
test bed will be the SMP box I've been talking about on the list, Red Hat
7.0 (only one that will install on the machine without dying instantly
during installation) and using the KGCC rather than the GCC that comes
with RH7.

Supposedly there are a couple of other patches available to add as well,
but I'm not sure where they are exactly. I just downloaded the patch that
Voj gave (v3.20) for the VIA chipsets.


Nicholas, give me a bit and I'll let you know what's going on with my
tests here. I can consistently get the current kernel to die simply by
running

dd if=/dev/hda4 of=/tmp/testing.img bs=1024M count=2k


TRy this on your box with the patch-2.4.1-pre11 added to the kernel source
and let me know what you get. Maybe we can work on this together.


David D.W. Downey



On Tue, 30 Jan 2001, Tobias Ringstrom wrote:

> So you have not seen any corruption, but are willing to do testing.  Very
> kind, but you could have choosen a better subject, I think.  There are a
> lot more rumours that facts regarding the VIA drivers right now.
> 
> /Tobias
> 
> 
> On Tue, 30 Jan 2001, Nicholas Knight wrote:
> 
> > I have a Soyo K7VIA motherboard which uses VT82C686A, with an 800mhz Athlon
> > CPU in it.
> > So far I've never run a 2.3* or 2.4* kernel on it, I've only done that on my
> > P3 using a propriatory micron motherboard that uses an intel BX2 chipset.
> > However, I recently trashed my linux installation (doing things totaly
> > unrelated to the kernel) and now would be more than happy to assist in
> > trying to figure out what the heck is causing the filesystem corruption on
> > VIA chipsets, but so far I've only found bits and peices of information on
> > it, and have been unable to locate a compiliation of information avalible on
> > the problem, so I'd know just where to start.
> > If anyone could point me to a good place to start looking, besides the
> > thousands of messages containing just bits and peices of information, I
> > could get to work on some testing.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
