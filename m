Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288940AbSAFNYH>; Sun, 6 Jan 2002 08:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288946AbSAFNX6>; Sun, 6 Jan 2002 08:23:58 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:40336 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S288940AbSAFNXu>;
	Sun, 6 Jan 2002 08:23:50 -0500
Date: Sun, 6 Jan 2002 14:23:45 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201061323.OAA29303@harpo.it.uu.se>
To: stepan@3amp.com
Subject: Re: 2.4.17 - hang after 'freeing unused kernel memory'
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002 12:30:39 +0100, Stepan Hluchan wrote:
>I have installed the RedHat 7.2 distro (I think it comes with
>2.4.10-something
>but that hangs too) on one machine A. and then transferred the HD to
>another (machine B) where it should be used.   On machine A (Celeron 800Mhz)
>it all boots up fine with any kernel, on machine B (P75 @ 100Mhz, ancient
>BIOS
>and mobo) it hangs after the message 'freeing up XX k unused kernel memory'.
>
>I have compiled the 2.4.17, 2.4.0 kernels set to 'classic pentium', but both
>would
>hang...

User error. It's actually INIT that's hanging, not the kernel.
When you installed on machine A, RH chose glibc libraries optimised
for i686-class CPUs. These libraries WILL NOT RUN on anything less,
including the P5 classic in your machine B, due to their use of the
CMOV instruction.

Move the disk back to machine A. Manually install the plain i386 glibc
library (glibc-2.2.4-19.3.i386.rpm if you get it from the RH7.2 updates
sites). Then move the disk back to machine B.

/Mikael
