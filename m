Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319292AbSIFSTs>; Fri, 6 Sep 2002 14:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319295AbSIFSTs>; Fri, 6 Sep 2002 14:19:48 -0400
Received: from mail1.cirrus.com ([141.131.3.20]:37021 "EHLO mail1.cirrus.com")
	by vger.kernel.org with ESMTP id <S319292AbSIFSTq>;
	Fri, 6 Sep 2002 14:19:46 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C05233F8A@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <tom.woller@cirrus.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>,
       "Woller, Thomas" <tom.woller@cirrus.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: cs4281 & select in 2.4
Date: Fri, 6 Sep 2002 13:23:52 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Toshiba refused to lend us any laptops after repeated requests,
so all the toshiba work has been without a unit to test with.
There is at least one (that i remember) specific fix for toshiba
systems in the driver.
also does recording work at all?  i mostly tested with grecord.
so, look at cs4281_setup_record_src(), and maybe commenting out
the toshiba specific code concerning the recording sources might
make a difference. or if the unit is NOT recognized, then forcing
the code to setup as your unit as a 1640CDT and see if that
helps.

i'll think about it some more. let me know
tom

On Fri, 6 Sep 2002, Rik van Riel wrote:
> On Fri, 6 Sep 2002, Woller, Thomas wrote:
>
> > which 2.4 version are you using? 2.4.19?  There was a
ham-radio
> > select(2) fix in the cs4281 driver back in 2.4.17 era, think
that

> > i'll put cs4281-src-20011214-01n-tar.bz2 into \cs4281
directory.
>
> Thanks.  I've just grabbed the tarball and will let you know
> if this fixes things.

You're right, all updates were already included in the 2.4.19
kernel. The only thing extra in your tarball is the 2.2 compat
code and two copy_to_user() return code fixes in cs4281_ioctl().

I wonder if it's some strange bug with the CS4281 hardware in
this Toshiba laptop:

00:08.0 Multimedia audio controller: Cirrus Logic Crystal CS4281
PCI Audio (rev 01)
        Subsystem: Toshiba America Info Systems: Unknown device
ff00
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at fc010000 (32-bit, non-prefetchable) [size=4K]
        Memory at fc000000 (32-bit, non-prefetchable) [size=64K]

Does this ring a bell (pun intended) ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org
