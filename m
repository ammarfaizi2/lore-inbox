Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136235AbRAMCoX>; Fri, 12 Jan 2001 21:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136310AbRAMCoO>; Fri, 12 Jan 2001 21:44:14 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:24299 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S136235AbRAMCoA>; Fri, 12 Jan 2001 21:44:00 -0500
Date: Sat, 13 Jan 2001 02:43:30 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <E14HDqv-0005Fm-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0101130228310.17083-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Alan Cox wrote:

> |The system is an AMD K6-3 on a FIC PA-2013 mobo with 3 IDE disks.  The
> |size of hda is 4.3 GB, the size of hdb is 854 MB and the size of hdc is
> |1.2 GB.  Hdd is an IDE CDROM drive
>
> I think its significant that two reports I have are FIC PA-2013 but not all.
> What combination of chips is on the 2013 ?

The FIC PA-2013 is one of the stranger types of MVP3.
(A mixture of 82c597 host bridge and 82c598 PCI bridge).

As discussed some time ago on this list, there are some of these
boards, which initially seem to be an MVP3, but have the host bridge ID
set to an VP3. (Real reasoning behind this never figured out).

2.4 has code in the pci quirks to disable the register which makes
the chip masquerade as a VP3, and forces it to identify itself as
an MVP3 part.  I'm curious whether this has an interaction here.

I have a list of known 'hybrid' boards, and known true (both halves) MVP3
boards and also a collection of lspci -xxx outputs from a selection of
them. If anyone wants any of this stuff, shout and I'll put it up
for ftp/www.

I'm curious if all of the other boards in Alans bug reports also
fall into the stranger category.

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
