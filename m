Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129602AbQKVSvg>; Wed, 22 Nov 2000 13:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131144AbQKVSv1>; Wed, 22 Nov 2000 13:51:27 -0500
Received: from imail.cyberec.com ([202.60.252.12]:9485 "EHLO imail.cyberec.com")
        by vger.kernel.org with ESMTP id <S129602AbQKVSvO>;
        Wed, 22 Nov 2000 13:51:14 -0500
Date: Thu, 23 Nov 2000 01:26:37 +0800
From: Anthony Liu <anthony@nexus-online.com>
To: linux-kernel@vger.kernel.org
Cc: "Charles Turner, Ph.D." <cturner@quark.analogic.com>
Subject: Re: Defective Red Hat Distribution poorly represents Linux
Message-ID: <20001123012637.A505@defiant.starfleet.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        "Charles Turner, Ph.D." <cturner@quark.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1001120084920.580A-100000@quark.analogic.com> <20001120203325.A14918@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i-nntp
In-Reply-To: <20001120203325.A14918@iapetus.localdomain>; from F.vanMaarseveen@inter.NL.net on Mon, Nov 20, 2000 at 08:33:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 08:33:25PM +0100, Frank van Maarseveen wrote:

> [...]
> > [root@merrimac linux-2.2.17]# cd scripts
> > [root@merrimac scripts]# gcc -o mkdep.o mkdep.c
> > collect2: ld terminated with signal 11 [Segmentation fault], core dumped
> > [root@merrimac scripts]# gcc -c -o mkdep.o mkdep.c
> > [root@merrimac scripts]# ld -o mkdep mkdep.o
> > Segmentation fault (core dumped)
> This _is_ a hardware problem.
> 
> > 
> > (5)	I returned home (200 mile round trip), removed my
> > 	SCSI disks from my home machine, and then returned
> > 	and installed them in my friend's machine. The
> > 	machine worked perfectly with Linux version 2.2.17,
> > 	and gcc-2.7.2.3, Binutils-2.8.1.0, etc., the standard
> > 	stuff.
> > 
> > 	This shows that the problems are not because of a
> > 	defective machine.
> Wrong.
> One cannot do statistics on one case. But you can on 10000+ of other
> cases where the above just works (actually, even one case where it works
> proves enough). You should give the mainboard a good massage to make it
> behave more deterministically.
> 
> dust, dirt, aging, bad connectors, broken lines on the mainboard
> incidentally making contact due to mechanical forces, thermal effects,
> who knows what it is. It could be anything. It really is faulty hardware.

Yes, hardware problems can be very subtle.

Case (1)

Just bought a new mouse and stick it in the USB port in my ABIT BX6 2.0
board for test, W98 runs ok. With the USB to PS/2 converter, I inserted
the mouse to the PS/2 port and the board refused to start: no ram count,
not even beep.

Opened the box, yanked all the cables out, pressed on the PS/2
connectors firmly on top of the board, put all cables back and
reconnected the mouse to the PS/2 port. The board started, booted into
2.2.17, everything worked. BTW, the ABIT board is only 1 year old!

Case (2)

One of the older machines I have is a 430VX, with the IBM 6x86 P120 chip
and 48M edo ram. This one would generate sig 11 on kernel compiles,
no matter what I do, even after replacing all ram chips. Sometimes
installing Redhat on this would just failed with the install scripts
choked to death.

There are three major factors here: the board, the CPU and the ram
chips. Replacing ram chips did not solve the problem, replacing
everything is not the most economical option.

Solutions:

Make boot floppies on another machine, compile kernels on another
machine with proper target. Try other distributions as well, like
Mandrake, SuSe or Debian. With that, this 430VX board install and run
Linux just fine as a firewall, caching proxy/DNS machine for six months
already, with no software related problem except that the CMOS battery
is losing charge and old hard disks are acting up. This baby is five
years old.

If the kernel somehow crashed on this 430VX machine, I wouldn't complain
about Linux, nor any distribution company. The fact is: it did generate
sig 11 on kernel compiles which won't happen on another machine.

If a looping kernel compiles test failed, it might corrupt your hard
disk. For a "safer" test, try looping a Quake demo for hours, the bigger
demo the better. It does not matter if you are running Linux or Windows,
machine with problems would hang just after a few loops.

PS: hardware memory tester might help, but in the end it does not test
the machine as a whole.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
