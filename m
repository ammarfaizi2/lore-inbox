Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267905AbTBLWeF>; Wed, 12 Feb 2003 17:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267908AbTBLWeF>; Wed, 12 Feb 2003 17:34:05 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:13828
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267905AbTBLWeD>; Wed, 12 Feb 2003 17:34:03 -0500
Date: Wed, 12 Feb 2003 17:44:45 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for  
 i8042?
In-Reply-To: <200302122017.h1CKH4b13492@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0302121741460.571-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's a new OSS Sound Blaster driver from Paul Laufer along with the new
PnP changes from Adam Belay.

Things are looking better but we still have serious conflicts. I don't
know why i'm out of IRQs so quickly.

The counter is at zero because it was a fresh remote reboot. If i was to
use the soundblaster I would get IRQ/DMA timeout errors. I do hear chunks
of sound though so we've got a conflict of sharing IRQs somewhere.

On Wed, 12 Feb 2003, Pete Zaitcev wrote:

> >> On Wed, Feb 12, 2003 at 11:14:40AM -0500, Shawn Starr wrote:
> >> >
> >> > Right but, why does this *not* show up in 2.4? IRQ 12 is free in 2.4 but
> >> > not in 2.5 *with* PS/2 mouse enabled?!
> >>
> >> Because this interrupt is only requested when /dev/psaux is opened in 2.4.
> >
> > I see, wasn't this better behaviour though?
>
> Not for all hardware. As SMM emulated "software i8042" continue
> to spread, the bugs continue to spread as well. Some systems,
> notably Dell i5000 simply do not work at all if the IRQ12 is
> not serviced (it's actually a little more complicated, but anyway...).
>
> I saw that the counter was at zero for your soundblaster, but
> I strongly suspect it had little to do with the PS/2 mouse.
> I am surprised it even compiles. I think it was one of the
> last drivers converted to proper DMA API, perhaps it just
> wasn't done right. I know SB won't interrupt if DMA does not
> complete. Why don't you verify that the sound subsystem is
> sane in your case? You might be using ALSA and not knowing it.
>
> -- Pete
>
>

