Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbTA3IgC>; Thu, 30 Jan 2003 03:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbTA3IgC>; Thu, 30 Jan 2003 03:36:02 -0500
Received: from gate.perex.cz ([194.212.165.105]:30472 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267444AbTA3IgB>;
	Thu, 30 Jan 2003 03:36:01 -0500
Date: Thu, 30 Jan 2003 09:45:14 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2 (fwd)
In-Reply-To: <20030129221234.GC2246@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0301300940090.1445-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, Adam Belay wrote:

> On Mon, Jan 27, 2003 at 03:36:41PM +0100, Jaroslav Kysela wrote:
> >
> > Any notes?
> 
> Actually I was wondering if you could provide some further information about the 
> nature of these multidevice sound cards so I can better understand the 
> situation.
> 
> 1.)  How are the componets of a typical card divided among the sub-devices. (ex: 
> control, mpu, wave table, etc)

There are these logical devices as you mentioned plus (optional) joystick 
or IDE controler which the sound driver doesn't drive.

> 2.)  Are all the devices required for the card to properly function, in other 
> words, must the card always have possession of all of the sound related 
> sub-devices in order to function at a minimal level.

No, but that's not the point. The sound driver must grab all devices to 
follow hardware structure.

3.)  Are there any other isapnp cards that depend on multiple devices per
driver, to my knowledge only a limited set of sound cards do.

Almost all isapnp soundcards. The opl3sa2 driver is an exception. Try to 
grep for ISAPNP_DEVICE_ID in linux/sound/isa directory + subdirectories.

Anyway, as I said. The card is bus (PCI has something similar - PCI 
bridges).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


