Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932826AbWJGUVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbWJGUVj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932827AbWJGUVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:21:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:62424 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932826AbWJGUVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:21:38 -0400
Date: Sat, 7 Oct 2006 13:08:28 -0700
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Jaroslav Kysela <perex@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: sysfs & ALSA card
Message-ID: <20061007200827.GA10108@kroah.com>
References: <Pine.LNX.4.61.0610061548340.8573@tm8103.perex-int.cz> <20061007062458.GF23366@kroah.com> <20061007074440.GA9304@kroah.com> <1160225730.19302.1.camel@localhost> <20061007191228.GA31396@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007191228.GA31396@vrfy.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 09:12:28PM +0200, Kay Sievers wrote:
> On Sat, Oct 07, 2006 at 02:55:31PM +0200, Kay Sievers wrote:
> > On Sat, 2006-10-07 at 00:44 -0700, Greg KH wrote: 
> > >  $ tree /sys/class/sound/
> > >  /sys/class/sound/
> > >  |-- Audigy2 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2
> > >  |-- admmidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/admmidi1
> 
> > > Yeah, I picked the wrong name for the card, it should be "card1" instead
> > > of "Audigy2" here, but you get the idea.
> > 
> > That looks nice. Yeah, it should something that matches to the C1 in the
> > other names.
> 
> This works fine for me with two soundcards and connect/disconnect
> module load/unload.
> 
> All devices are in a flat list in the class directory, also the card%i
> ones:

Yes, nice, your tweak solved my oops problem, which was wierd.  I've
added some error checks now and added it back into my tree, thanks for
the fixes.

greg k-h
