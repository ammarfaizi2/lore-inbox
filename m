Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbTBLAL3>; Tue, 11 Feb 2003 19:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbTBLAL2>; Tue, 11 Feb 2003 19:11:28 -0500
Received: from adsl-66-137-237-97.dsl.rcsntx.swbell.net ([66.137.237.97]:43176
	"HELO frascone.com") by vger.kernel.org with SMTP
	id <S267630AbTBLAL1>; Tue, 11 Feb 2003 19:11:27 -0500
Date: Tue, 11 Feb 2003 18:21:15 -0600
From: David Frascone <dave@frascone.com>
To: linux-kernel@vger.kernel.org
Subject: Faking a memory map?
Message-ID: <20030212002115.GD26196@wolverine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get an existing SDK (userland) for a PCI hardware device
to work across a different propriatary bit-banged interface.

The original device driver just mmaped the PCI registers / address
space into userland.  (talk about lazy ;)

Anyway, the hardware I'm working with is *not* on the PCI bus, and
therefore not memory-mappable.  So, I'm stuck with a complex driver
design (compared to the original), and rewriting the entire bottom of
the SDK.

So, I thought:  Is there a way to cheat?  Would it be possible for me
to *fake* the SDK out by memory mapping some RAM, and then reading /
writing to the ram after bit-banging the device.

I looked into it some, but I couldn't figure out how to get notified
when the region was read/written to (only when the page changed).  So,
is it possible to do the (admitedly ugly) hack I'm attempting?

Thanks in advance,

-Dave

-- 
David Frascone

          What garlic is to salad, insanity is to art.
