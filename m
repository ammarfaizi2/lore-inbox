Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUBPWoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBPWn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:43:59 -0500
Received: from gprs152-120.eurotel.cz ([160.218.152.120]:46722 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265932AbUBPWnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:43:11 -0500
Date: Mon, 16 Feb 2004 23:42:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ (ir-kbd-gpio.ko)
Message-ID: <20040216224226.GB322@elf.ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <20040201215438.GA8937@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201215438.GA8937@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> > Common problems and solutions with 2.6 input drivers:
> > Problem:
> > ~~~~~~~~
> > I've read through the whole file, and it did not help me at all!
> > 
> The following is not a problem, but a question I have been unable to
> answer by myself. Is with respect to the recent addition of "input layer
> based support for infrared remote controls", mainly for use with TV
> tuner cards based on bttv.
> 
> Gerd Knorr did the patch that was integrated into mainstream as
> ChangeSet 1.1474.131.296, and I was trying to use the new standard
> driver instead of the ported one from 2.4.x, which I got from LIRC
> mailinglists, and has been working OK with 2.5.x and 2.6.x.
> 
> If I load the new kernel modules ir_kbd_gpio and ir_common I get in the logs:
> ir-kbd-gpio: bttv IR (card=41) detected at pci-0000:00:0b.0/ir0
> 
> And from /proc/bus/input/devices:
> I: Bus=0001 Vendor=1461 Product=0001 Version=0001
> N: Name="bttv IR (card=41)"
> P: Phys=pci-0000:00:0b.0/ir0
> H: Handlers=kbd event3 
> B: EV=100003 
> B: KEY=c304 80100040 0 0 30000 0 2008000 80 1 9e0000 7bb80 0 0 
> 
> So everything seems to be detected OK. But when I start lircd 0.6.6-7,
> it seems to come up fine, but as soon as any application tries to get
> keypresses from /dev/lirc the daemon exists, because of:
> could not open /dev/lirc
> 
> So it seems the new kernel driver for TV capture card based remote
> controls doesn't use /dev/lirc as the place to "send" events from which
> applications read them.

Exactly. With this driver, this is just another keyboard, not lirc
device. You should not need lircd.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
