Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbRGEPR6>; Thu, 5 Jul 2001 11:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265381AbRGEPRs>; Thu, 5 Jul 2001 11:17:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33033 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265385AbRGEPRh>; Thu, 5 Jul 2001 11:17:37 -0400
Date: Thu, 5 Jul 2001 08:17:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <3B442354.BCA61010@idb.hist.no>
Message-ID: <Pine.LNX.4.33.0107050810400.22053-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jul 2001, Helge Hafting wrote:
>
> I am fine with "You have to use initrd (or similiar) _if_ you want this
> feature."

Nope.

I do not want to maintain two interfaces. If we make user space the way to
do these things, then we will do pretty much most of the driver setup etc
in user space. We'd have to: we'd enter user space before drivers have had
a chance to initialize, exactly because "features like these" can change
the device mappings etc.

And I don't want to have two completely different bootup paths.

> But please don't make initrd mandatory for those of us who don't
> need ACPI, don't need dhcp before mounting disks and so on.

You would never even know the difference. You'd do a "make bzImage", and
the default filesystem would just be embedded into the image. By default
it probably doesn't need to do much - although things like the BIOS DPMI
scan etc would surely be good to get rid of.

Why complain about that?

			Linus

