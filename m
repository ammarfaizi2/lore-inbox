Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUKjD>; Tue, 21 Nov 2000 05:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbQKUKio>; Tue, 21 Nov 2000 05:38:44 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:19723
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129091AbQKUKij>; Tue, 21 Nov 2000 05:38:39 -0500
Date: Tue, 21 Nov 2000 02:08:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: BASTARDIZED FAKE RAID EXPLAINED!!!!  STOP ASKING!!!!
Message-ID: <Pine.LNX.4.10.10011210131410.26514-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am so damn tired of people not reading or doning their homework before
asking silly questions uder the pretext of a goofy statement!

"Gee Wiz, it sez on the box it is a Raid Controller, and 'duh' Hardware, too".

This is the last time I hope to explain this pile of crap.

Sometime ago, people who make EIDE/ATA Host adapters, otherwise known as
controllers, were smoking a lot of DOPE that day.  They came to the
conclusion that because Microsoft requires a driver for everything, lets
kludge some bogus bullshit hack and shove it in the BIOS and call it RAID!
Then the dumb asres of the world will be suckered into paying more for
something that is not what it is sold as on the packaging.

Now how does this KLUDGE of software in the BIOS and Software Engine work?

Real simple!

* It first use the BIOS to execute software raid calls like mkraid.
* Then it destrokes the drive (you have less capacity, didn't you know?).
* In the beginning the construction of the RAID signature blocks were just
	after the MBR and usually mirrored the MBR and held date and time
	codes that the BIOS used to toggle which LIE it would tell the
	INT19 calls from the BIOS as to what real and what was fake.
* This is know as HOTSWAP-bootable.
* After bitching out most of the card makers that LILO STOMPS all over the
	RAID signature, they got smart and made two copies.  One on the
	front (useless) and one on the tail.
* Since all of these only allow for simple mode raids and partitioning was
	not possible, because it was a kludge remember!  In order to have
	partitions you have to have several signature blocks to
	maintain the date/time stamps and counters.  Since there is only 
	one signature pattern, you get one partition.
* Until all of these card makers and chipset people release the signatures
	and how to update or read/write, Linux will not be able to protect
	the information or the construction of the RAID.

* Now lets say one day Linux gets access or can publish this info.
* How will Linux handle this info, because NOW there will be a way to make
	it work, using the Linux Software Raid Engine.

The short version:

Linux short changes your drive capacity for you to gather its own tables
and signatures for a portion of the drive that if capable of supporting
partitions if needed.  Below is a line diagram.

M==MBR
B==BRS=BiosRaidSignatures
L==LRS=LinuxRaidSignatures
H==HASH-CRAP after LILO runs.

M--------------------------------------------------	normal no raid
MB------------------------------------------------B	bios raid
MH----------------------------------------------LLB	bios raid+linux

The dashes are what you can format and use for data.

Linux will have to destroke the reported geometry/capacity to protect all
the signatures so that we can work with the real BIOS protion of the raid
to enable the Linux soft engine.

I now quit on the details because I am going to bed!
Now nobody ask or bug me again of this stuff/crap until the OEM venders
release their bogus IP.  Everyone should note that I have had this
conversation with all of the venders that make this stuff and called it
what it is and stood on that point.

Where are we today?

One of the four players in this game is at least working to make something
happen, but everyone of these four OEM's are afraid that their IP is more
valuable than the others, but all agree that the Linux Engine does it
better!

So Good Nite and do not ask me this question again!
Or the real ATA will come to life and nobody likes me when that happens.

Regards, 

Andre Hedrick
The Linux ATA/IDE (ranting piss-off over raid shit) guy!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
