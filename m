Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVBMKGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVBMKGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 05:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBMKGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 05:06:36 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:29650 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261260AbVBMKGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 05:06:30 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050212183440.GC8170@ucw.cz>
References: <20050211201013.GA6937@ucw.cz>
	 <1108227679.12327.24.camel@localhost>  <20050212183440.GC8170@ucw.cz>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 11:05:00 +0100
Message-Id: <1108289100.5978.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, den 12.02.2005, 19:34 +0100 schrieb Vojtech Pavlik:
> On Sat, Feb 12, 2005 at 06:01:19PM +0100, Kenan Esau wrote:
> > Am Freitag, den 11.02.2005, 21:10 +0100 schrieb Vojtech Pavlik: 
> > > Hi!

[...]

> > As far as I can see the
> > init-sequence is the one from Haralds xfree 3.3.6-driver. There is a
> > reason why this sequence is not like that anymore in my driver.
> 
> OK.
> 
> > This
> > sequence does not always work and there is not something like a "magic
> > knock sequence".
> 
> You mean that the only needed bit is setting the resolution to '7'?

The lifebook touchscreen has some extensions to the standard protocol:

0xe8 0x06: Stop absolute coordinate output 
0xe8 0x07: Start absolute coordinate outpout (3-byte packets)
0xe8 0x08: Start absolute coord. output with 6-byte packets

> > The lifebook-touchscreen hardware is a little bit slow
> > and it happens quite often that it does not understand a command that
> > you send.
> 
> I don't believe this - the PS/2 protocol has handshakes for both sides,
> so each side can slow down as much as it wants. PLUS, the clock is
> driven by the device.

I dont't know the PS2-specs. But I know the lifebook hardware quite
well. While implementing my driver (for xfree 4.0 at that time) I
noticed that it happens often that the device came back with an error or
resend. I fixed this by just waiting a short time and then retry.

If you agree I will take your patch as the basis and make it work. Now I
know how you want it to look like.

I think this was the kick in the ass I needed ;-)

> > This is the reason why you often have to send a command
> > several times until the hardware understands... 
> > Probably this was what was seen by Harald on the USB-bus and he just
> > used this sequence.
> 
> USB?!

Yeah -- OK. PS2...

[...]


Greetings 


	Kenan

