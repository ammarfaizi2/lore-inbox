Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271845AbTGYAnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271846AbTGYAnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:43:21 -0400
Received: from tomts17-srv.bellnexxia.net ([209.226.175.71]:7878 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S271845AbTGYAnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:43:14 -0400
Date: Thu, 24 Jul 2003 20:56:53 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: why the current kernel config menu layout is a mess
Message-ID: <Pine.LNX.4.53.0307242020140.23200@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  (if you're not interested in this ongoing discussion, there's
always the delete key.  although, in all fairness, i'd be happy
to move this discussion to another forum, if people think it's
distinct enough to deserve its own list.  just a thought.  i'm
open to suggestions.)

  in order to really demonstrate why the kernel menu layout is
really chaotic, i spent about 10 minutes going over the layout
from 2.6.0-test1-bk2, and here are some observations regarding
why it needs real work.

"General setup"

    this option seems to exist only because no one took the time
  to figure out where those suboptions really belonged.  consider
  the suboption "Support for paging of anonymous memory".
  might this not go under "Processor type and features",
  where there are other memory-related options?

    this just seems like a grab-bag of unrelated options that
  were thrown here at random.

"Power management options"

    i've already whined about how you can turn off this
  option and still select ACPI, which seems non-intuitive.

    in addition, though, i'm not sure "CPU frequency scaling"
  belongs here.  it might just as well fit under "Processor type
  and features", although that may be nit-picking.

"Bus options (PCI, PCMCIA, EIAS, MCA, ISA)

    if this is for busses, why aren't the other busses here as
  well?  shouldn't USB be here as well?  although, in all fairness,
  USB represents such a huge collection of options, it might deserve
  its own top-level entry, but even then, it would make sense to 
  at least have it right after the "Bus options" entry.

    and what about I2C, which is described as a "slow serial bus
  protocol"?  it's a bus.  why isn't it here?

"Generic driver options"

    a single option choice deserves its own top-level menu entry?
  hardly.

"Parallel port support"

    this really deserves its own top-level menu entry as well?
  again, hardly.  why not just combine serial and parallel ports
  under a single entry?  "Serial and parallel ports"?  regardless,
  it's silly to have parallel ports way up here, and serial 
  drivers all the way down as a sub-menu under "Character
  devices"

"Character devices" (jumping ahead just a bit)

    and while we're on the subject of character devices, it's 
  absurd to have an entire menu structure labelled like this.
  what normal people think to themselves, "hey, i want to 
  configure my character devices now"??

    rather, they'll think, "i'll configure my mouse now.  or
  my floppy device.  or power management".  etc, etc.  to lump
  stuff under that menu entry just because they share that
  property is really counter-productive.

    as a concrete example, note the sub-menu "Mice".  you've
  already got some mouse configuration under "Input device support".
  why not deal with mice in one place?  "Character devices", indeed.
  hmmmmph.

"Block devices"

    same thinking here.  it's not helpful to gather this many
  entries under a single menu entry just because they happen to
  all block devices.  normal people don't think that way.

    and it might (i said *might*) make more sense to keep
  parallel port configuration and "Parallel port IDE device
  support together", but i wouldn't defend that to the death.
  it's just a thought.

"Multiple devices (RAID and LVM)"

    i'm not sure this wouldn't fit just as well as a sub-menu
  of "Filesystems".  certainly, LVM wouldn't be out of place
  there.  again, just a thought.

"Fusion MPT"

    hard to believe this deserves its own top-level entry,
  but i could be wrong.

"IEEE 1394"

    it's a bus, right?  move it there.

"Networking support"

    yeesh, what a mess.  at the very least, if everything else
  related to networking is here, ISDN should be, too.  but, really,
  it needs a lot more cleaning up than just that.

"Linux telephony"

    might this also belong under networking?

"Input device support"

    another menu in serious need of cleanup.  at the very least,
  if mice are dealt with here, why is there also a "Mice" entry
  under "Character devices"?

"Character devices" (again)

    almost all of this can be moved to other menus.  "Serial
  drivers" should go higher up.  "I2C" qualifies as a bus.
  "Mice" should be under "Input device support".  you get the
   idea.

"Graphics support"

    it's thoroughly confusing (as many have already pointed out)
  to have the "Input devices" selection control the display of the
  "Console display driver support".

    IMHO, "Graphics support" should involve video cards, framebuffers,
  that sort of thing.  not something as fundamental as virtual 
  consoles.  i think that "Console display driver support" sub-menu
  should be ripped right out of there and moved up.  way up.  where
  no one can miss it.

"IrDA", "Bluetooth"

    any reason why two wireless technologies are not next to
  each other in the menu layout?  perhaps as a networking
  sub-option?


  anyway, i could go on but i'm sure you get the idea.  this
current layout could use a major overhaul.

rday
