Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265721AbRGEPll>; Thu, 5 Jul 2001 11:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265555AbRGEPlb>; Thu, 5 Jul 2001 11:41:31 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:21736 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S265721AbRGEPlS>; Thu, 5 Jul 2001 11:41:18 -0400
To: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ronald Bultje <rbultje@ronald.bitfreak.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <E15HsKg-0001Pk-00@the-village.bc.nu> <m2sngc3w10.fsf@sympatico.ca> <20010705083729.A2414@ragnar-hojland.com>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 05 Jul 2001 11:38:29 -0400
In-Reply-To: Ragnar Hojland Espinosa's message of "Thu, 5 Jul 2001 08:37:29 +0200"
Message-ID: <m2vgl7e68a.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ragnar" == Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com> writes:

 Ragnar> And here's a counter claim: At home have 128 + 64, both of
 Ragnar> different speeds and brands.  Of course, to run properly you
 Ragnar> have to force the pc100 to run at 66, but other than that
 Ragnar> they're happy (96MB swap)

[...]

Yes, I imagine Linux does work ;-) The fact is that SDRAM is
problematic (from a hardware perspective).  For the OP, it could be a
bus capacitance problem.  If the boards are older, they might not be
designed for larger memories with have a higher capacitance.  Slowing
down the accesses will stop the problem.  You would do this by going
to the BIOS and changing the CAS and RAS timings (or maybe you can
change the SDRAM clock).  SDRAM has a `NOP' state so that you can run
at a higher clock speed, but delay a command.  Anyways, I don't think
that Linux is messing with the SDRAM controllers, but I am not an
authority.  Also, a single stick is always better than several
smaller memory sizes.

I was looking at the memtest86 web sight "http://www.memtest86.com/"
and I didn't see anything that test for SDRAM cache lines.  Single
beat SDRAM read/writes are less stressful than BURSTS.  It is typical
for single beats read/write to work while bursts fail as four 32 bit
values are written and read in quick succession.  The `algorithm'
description on the web page doesn't seem to test for this issue from
what I see... of course I have been wrong before!

regards,
Bill Pringlemeir


