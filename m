Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbRAaUja>; Wed, 31 Jan 2001 15:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131048AbRAaUjU>; Wed, 31 Jan 2001 15:39:20 -0500
Received: from entropy.muc.muohio.edu ([134.53.213.10]:47491 "EHLO
	entropy.muc.muohio.edu") by vger.kernel.org with ESMTP
	id <S130663AbRAaUjJ>; Wed, 31 Jan 2001 15:39:09 -0500
Date: Wed, 31 Jan 2001 15:38:55 -0500 (EST)
From: George <greerga@entropy.muc.muohio.edu>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Bernd Eckenfels <inka-user@lina.inka.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Request: increase in PCI bus limit
In-Reply-To: <20010131005519.D18746@cadcamlab.org>
Message-ID: <Pine.LNX.4.30.0101311535130.24040-100000@entropy.muc.muohio.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Peter Samuelson wrote:

>[Bernd Eckenfels]
>> May even decrease the kernel for systems < 4 busses.
>
>Be careful, though.  Users may set this thinking "I have a generic
>system with only one PCI bus" without realizing that AGP, cardbus and
>some motherboard devices are all counted.  Pad the CONFIG option by
>about 4 busses and we'll be OK..

If someone says 1 bus, give them one bus.

Just make the description say:
  Add 1 for every PCI
  Add 1 for every AGP
  Add 1 for every CardBus
  Also account for anything else funny in the system.

Then panic on boot if they're wrong (sort of like processor type).


It's somewhat annoying that by choosing SMP NR_CPUS goes to 32 when I know
I only have (and ever will have) 2 in this machine.  Don't make busses have
the same assumptions that just waste memory.

-George Greer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
