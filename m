Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTABMXl>; Thu, 2 Jan 2003 07:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTABMXl>; Thu, 2 Jan 2003 07:23:41 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:13584 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261523AbTABMXk>; Thu, 2 Jan 2003 07:23:40 -0500
Message-ID: <3E14315E.F80B3DFF@aitel.hist.no>
Date: Thu, 02 Jan 2003 13:32:30 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: 2.5.54: radeonfb almost works
References: <Pine.LNX.4.33.0211010937050.6296-100000@maxwell.earthlink.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radeonfb almost works now, but there are some problems
with setting (and resetting) the resolution.

I use a flat screen so anything except 1280x1024 is
hopeless to look at.  So I want that from the start.

Just booting with video=radeon gives me a 640x400
mode.  There's some initial garbage (looks like early boot
messages converted to graphichs at the wrong resolution)
on the screen, but that isn't a problem.  The low resolution
is, though.


I first tried "fbset 1280x1024-60", which changed
the resolution, but the console was still a
small 640x400 thing in the upper left corner of
the 1280x1024 display.  Not very useful.

So I tried booting with video=radeon:1280x1024-32@60
That gave me a blank screen, the monitor complained
about "no signal".

But I logged in blind, and ran fbset 1280x1024-60
again.  This gave me the console I want.
1280x1024 resolution, with 160x64 characters.

I could put fbset in a init script, but that is
fragile if I get some error before that init
script runs. I should really see the
console all the time.

Another problem comes up when running X.  Switching
from X to some virtual console always gives me the
"no signal" thing, and I have to type the fbset
command blind before the console becomes
visible.  Switching back to X is never a problem.

This is a UP machine, P4 processor, using preempt.
I use a radeon 7500 in an AGP slot.

Helge Hafting
