Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbUAUM2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265936AbUAUM2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:28:35 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:52352 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265935AbUAUM2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:28:32 -0500
Date: Wed, 21 Jan 2004 13:28:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Evaldo Gardenali <evaldo@gardenali.biz>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: parkbd adapter
Message-ID: <20040121122835.GA478@ucw.cz>
References: <4008430C.9090101@gardenali.biz> <20040116133013.12fab7be.rddunlap@osdl.org> <400E60FA.6040806@gardenali.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400E60FA.6040806@gardenali.biz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 09:22:34AM -0200, Evaldo Gardenali wrote:

> I *KNOW* how to google...
> I actually just needeed *DOCUMENTATION* I can't find anywhere, and the
> author seems to ignore my mails (or it goes to spam trash, or whatever
> happens, the thing is I don't get a reply)
> I wonder how useful is a piece of code present in millions of boxes if
> virtually NOBODY knows how to use it. and it annoys me a bit that many
> requested features are out of the kernel, but a feature that is in the
> main tree is virtually useless (if its really useful, where's the link
> for the docs?)
> </rant>
> sorry, but I feel frustrated with that

Your mail is still hanging in my inbox, and unfortunately I don't have
the complete schematic for the parkbd adapter anywhere near me.

I was hoping I could find it, but I suppose the following might be
enough for you to build the adapter:

It's really simple, just two diodes and two resistors in this
arrangement:

            ______
+5V -------|______|--.
                     |
INPUT PIN -----------|
		     |--- KBD PIN
OUTPUT PIN ---|<|----'

Now for KBD CLOCK you use STROBE and ACK pins on the parallel port and
for KBD DATA you use AUTOFD and BUSY pins on the parallel port. I don't
remember the value of the resistor used, but something like 5k should
work OK. It's not completely necessary anyway.

And then you'll also have to connect the keyboard +5V and GND pins. For
+5V you can either use the real keyboard or mouse connectors, get +5V
from the joystick connector or from an external power supply.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
