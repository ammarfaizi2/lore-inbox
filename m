Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLLUbx>; Tue, 12 Dec 2000 15:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLLUbn>; Tue, 12 Dec 2000 15:31:43 -0500
Received: from pnendick.cpe.dsl.enteract.com ([216.80.39.125]:65284 "EHLO
	thefunk.org") by vger.kernel.org with ESMTP id <S129340AbQLLUbZ>;
	Tue, 12 Dec 2000 15:31:25 -0500
Date: Mon, 11 Dec 2000 14:00:31 -0600
From: " Paul C. Nendick " <pauly@enteract.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.16 SMP: mtrr errors
Message-ID: <20001211140029.A828@thefunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: any responses to my email address <pauly@enteract.com>

My setup
-A standard install of RedHat 7.0 with the 2.2.16smp w/ hand compiled X
 4.0.1 to support xinerama
-Tyan tiger 133 s1834 motherboard (VIA Apollo Pro133A Chipset)
-256mb PC133 RAM
-Two 800 Mhz PIII eb Slot-1 CPU's
-Matrox g450 32MB RAM dual-heal AGP video card w/ hand compiled X driver
 from matrox

My problem
from /var/log/message at startup:

mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
<snip>
CPU0: Intel Pentium III (Coppermine) stepping 03
<snip>
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3194.88 BogoMIPS).
<snip>
checking TSC synchronization across CPUs: passed.
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs

and immediately after starting X:

kernel: mtrr: base(0xd4000000) is not aligned on a size(0x1800000) boundary
last message repeated 2 times

and finally:

%cat /proc/mtrr 
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
reg02: base=0xd5800000 (3416MB), size=   8MB: write-combining, count=1

I would like to know what, if anything, is wrong and what I can do about it.

Cheers!

/paul

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
