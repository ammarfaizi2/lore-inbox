Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbRAEACM>; Thu, 4 Jan 2001 19:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbRAEACB>; Thu, 4 Jan 2001 19:02:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4625 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129465AbRAEABy>; Thu, 4 Jan 2001 19:01:54 -0500
Date: Thu, 4 Jan 2001 16:01:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: And oh, btw..
Message-ID: <Pine.LNX.4.10.10101041546120.1153-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a move unanimously hailed by the trade press and industry analysts as
being a sure sign of incipient braindamage, Linus Torvalds (also known as
the "father of Linux" or, more commonly, as "mush-for-brains") decided
that enough is enough, and that things don't get better from having the
same people test it over and over again. In short, 2.4.0 is out there.

Anxiously awaited for the last too many months, 2.4.0 brings to the table
many improvements, none of which come to mind to the exhausted release
manager right now. "It's better", was the only printable quote. Pressed
for details, Linus bared his teeth and hissed at reporters, most of which
suddenly remembered that they'd rather cover "Home and Gardening" than the
IT industry anyway.

Anyway, have fun. And don't bother reporting any bugs for the next few
days. I won't care anyway.

		Linus

-----
Changes since the prerelease:

David Mosberger:
 - ia64 update

NIIBE Yutaka:
 - SuperH update

Karsten Keil:
 - re-do ISDN certification checksums

Tim Waugh:
 - VIA DMA=255 bug fix
 - IEEE 1284 config message
 - IEEE 1284 probe fix
 - missing printk argument
 - ppa driver reconnect timeout tweak

Matthew Dharm:
 - USB hotplug fix - specify exactly which fields to match on

Rik Faith:
 - drm driver synch with XFree86-4.0.2
 - oops: we synched a bit too far. Backsync to the _real_ 4.0.2 level.

Geert Uytterhoeven:
 - m68k updates
  - Amiga resource management updates
  - m68k loops_per_jiffy updates
  - m68k keyboard delay/repeat
  - m68k SCSI updates
  - m68k exported symbols update
  - m68k Lance updates
  - fbdev config fixes
  - Amiga Ethernet updates
  - Amiga builtin serial updates
  - m68k config updates
  - m68k __ashldi3
  - Amiga Y2K fixes (a bit late, wouldn't you say?)
  - Misc m68k updates
  - fbdev init order fix
  - Mac/m68k IDE updates
  - m68k asm constraint fixes


Marc ZYNGIER:
 - SMP lockup with IrDA

David Huggins-Daines:
 - remove extra "remove_wait_queue()" in drivers/sound/cs46xx.c.  It
   would lock up badly on nonblocking reads.

Matti Aarnio:
 - teach tulip driver about media types 5 and 6
 - fix ATM LANE driver linkage issues
 - fix DECNET driver unload time cleanup
 - fix pointer comparison type warning
 - get rid of excessive '##' token pasting that newer gcc's warn about

Keith Owens:
 - fix drm Makefile to not use the same objects built-in and in a module
 - update modutils version numbers to match 2.4.x kernel

Russell Kroll:
 - fix radio card drivers that got the request_region sense inverted

Rich Baum:
 - Remove compile warnings with newer gcc versions for lables with no
   expression at the end of a compound block

Andreas Franck:
 - Make the x86 semaphore implementation compile properly with current
   gcc snapshots.  Newer gcc's will release the memory allocated for a
   data structure too early if only the pointer to that memory is passed
   to an asm.

Alan Cox:
 - pcxx.c: make it compile ("mseconds" -> "msec")
 - Documentation: fix typos/glitches
 - CCISS bugfix
 - riscom setup bugfix
 - toshoboe and wavelan overlarge udelay
 - clean/bugfixes amateur radio
 - yam/mkiss build fix
 - old tulip chips driver update
 - sg driver unchecked scsi_allocate_request
 - i810 audio fix
 - RTC CMOS locking fixes

David Miller:
 - update sparc to "loops_per_jiffy"
 - sparc32 uses ix86-like semaphores now
 - missing flush_dcache_page in kiovec support layer
 - netfilter: use "long" for values operated on using bitops
 - more empty statement warning fixes
 - LVM 32-bit compat ioctl checks
 - Include param.h into Sparc64's delay.h to get HZ define
 - Fix Zilog serial port speed setting checks

Neil Brown:
 - raid5 missing unlock on degraded array
 - knfsd inode semaphore: get it early

Johannes Erdfelt:
 - USB oops on unplug fix for dc2xx and ov511 driver

Mitch Davis:
 - prettier printout of IDE registers if < 0x100

Richard Henderson:
 - alpha "loops_per_jiffy" update

Oliver Neukum:
 - fix for SMP race in v4l open()

Andreas Bombe:
 - Makefile fix for ieee1394
 - IEEE 1394 up-to-date

Kai Germaschewski:
 - fix ISDN diversion services name-clash (and crash)

Andre Hedrick:
 - IDE chipset update, DVD-RAM update

Rik van Riel:
 - don't deactivate partially written pages in generic_file_write

Michael Lang:
 - ibmmca upgrade: docs and small bugs

Marko Kreen:
 - big udelay's in fb drivers. Fix.

Me:
 - drivers/net/rcpci45.c: make it compile ("rcpci_pci_table" ->
   "rcpci45_pci_table")
 - mark_buffer_dirty() only does a "balance_dirty()" if the
   buffer was previously clean.
 - mm sanity: never decrement page count past zero
 - no synchronous bdflush wait
 - mm VM scanning and exit race cleanup: mmlist_lock

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
