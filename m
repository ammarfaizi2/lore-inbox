Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSAULkw>; Mon, 21 Jan 2002 06:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbSAULkm>; Mon, 21 Jan 2002 06:40:42 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:42767 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S284890AbSAULki>; Mon, 21 Jan 2002 06:40:38 -0500
Date: Mon, 21 Jan 2002 12:38:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121123828.C24754@suse.cz>
In-Reply-To: <Pine.LNX.4.40.0201201054011.7238-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.10.10201201555040.12376-100000@master.linux-ide.org> <20020121114311.A24604@suse.cz> <20020121114830.W27835@suse.de> <20020121121456.A24656@suse.cz> <20020121122954.Z27835@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020121122954.Z27835@suse.de>; from axboe@suse.de on Mon, Jan 21, 2002 at 12:29:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 12:29:54PM +0100, Jens Axboe wrote:
> On Mon, Jan 21 2002, Vojtech Pavlik wrote:
> > I always thought it is like this (and this is what I still believe after
> > having read the sprcification):
> > 
> > ---
> > SET_MUTIPLE 16 sectors
> > ---
> > READ_MULTIPLE 24 sectors
> > IRQ
> > PIO transfer 16 sectors
> > IRQ
> > PIO transfer 8 sectors
> > ---
> > 
> > Where am I wrong?
> 
> I agree completely, see previous mail.
> 
> > By the way, the device *isn't* required to support any lower multiple
> > count than the maximum one it advertizes. Ugly.
> 
> Oh? That basically narrows down the multi count value from hdparm to a
> boolean on-or-off. I'd be surprised to see any drives break with lower
> multi count in real life, though..

The spec seems to mandate to check the Identify data again after setting
new Multmode to see whether the drive supported the value we wanted to
program it to.

-- 
Vojtech Pavlik
SuSE Labs
