Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSFSVRU>; Wed, 19 Jun 2002 17:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSFSVRT>; Wed, 19 Jun 2002 17:17:19 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:27378 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S318013AbSFSVRR>; Wed, 19 Jun 2002 17:17:17 -0400
Message-Id: <200206192116.g5JLGV811273@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Dave Jones <davej@suse.de>
Subject: Re: Linux 2.5.23-dj2
Date: Wed, 19 Jun 2002 23:19:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <200206192059.g5JKxF806954@mail.science.uva.nl> <20020619230603.L29373@suse.de>
In-Reply-To: <20020619230603.L29373@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 23:06, Dave Jones wrote:
> On Wed, Jun 19, 2002 at 11:02:17PM +0200, Rudmer van Dijk wrote:
>  > I was busy testing it with 2.5.23-dj1...
>  > got a panic, but could not save the output (and did not liked the idea
>  > to write it all down 8), also I thought it had notinhg to do with the
>  > agpgart split and wanted to try to run 2.5.23-dj1 first before
>  > reporting... ah well will try it with -dj2
>
> Chipset type and the output of "grep AGP .config" may be something to
> begin with. Did it crash on load at boot time? or during agp usage?

sorry, was a bit short 8-)

It crashed during boot, at the time X was starting (as reported earlier by ??)
booting without starting X worked, and the following oops occured while 
staring X (using the bootscript)

Kernel BUG at exit.c: 562
invalid operand: 0000
<snip> (did not handcopied this part)
 <0>Kernel Panic: attempted to kill the idle task!
in idle task - not syncing

gandalf:~ # lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 
(rev
01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:0b.0 Ethernet controller: Winbond Electronics Corp W89C940
00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:11.0 Ethernet controller: Winbond Electronics Corp W89C940
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)

gandalf:/usr/src/kernel/linux-2.5.23-dj2 # grep AGP .config
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
CONFIG_AGP_SIS=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set

	Rudmer

PS. will try -dj2 in a moment (just finished compiling)
