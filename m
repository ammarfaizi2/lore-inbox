Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310920AbSCHPzr>; Fri, 8 Mar 2002 10:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310922AbSCHPzi>; Fri, 8 Mar 2002 10:55:38 -0500
Received: from Expansa.sns.it ([192.167.206.189]:18949 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S310920AbSCHPzX>;
	Fri, 8 Mar 2002 10:55:23 -0500
Date: Fri, 8 Mar 2002 16:54:44 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6 IDE oops with i810 chipset
In-Reply-To: <3C88CEF6.8010603@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203081652560.28525-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a lack of time i tried just 2.5.5, which worked very well.
I get the oops while initializing the IDE controller, just after

hdc: LTN485, ATAPI CD/DVD-ROM drive

and before the expected:
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14


On Fri, 8 Mar 2002, Martin Dalecki wrote:

> Luigi Genoni wrote:
> > HI,
> >
> > It is almost impossible to boot 2.5.6 with IDE disk with
> > chipset :
> >
> > 00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
> > [Master])
> >         Subsystem: Intel Corporation 82801AA IDE
> >         Flags: bus master, medium devsel, latency 0
> >         I/O ports at 2460 [size=16]
> >
> >
> > I get an oops with every configuration I tried.
> > Of course I have no way to save log this oops,
> > and I had no time to write it down. Anyway it is the usual
> > "attemped to kill init" message.
> >
> > Apart of this there is the old OSS driver with still
> > a virt_to_bus() in dma.c file,
> > and drm/i810.c has the same problem too, also if a trivial
> > (and of course wrong, also if it works temporally) fix
> > is quite fast.
>
> Could you please tell me which was the last version (possible up to
> pre status) which worked? And could you possible tell where the
> system actually hangs during the boot process (what is the
> last init message which appears on the screen?).
>
> During IDE setup? During mounting? During fsck or whatever.
> I'm asking this becouse I couldn't get patch-2.5.6-pre3 working
> on my athlon system and there are as well apparent instabilities
> on my i440MX based notebook, which are not related to the IDE changes.
> (pre2 with patch number 16 and 17 applied works for me of course on
> both of them quite well...)
>
> Thank you in advance.
>

