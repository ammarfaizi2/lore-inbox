Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262938AbTCSHNk>; Wed, 19 Mar 2003 02:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262939AbTCSHNk>; Wed, 19 Mar 2003 02:13:40 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:24330 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262938AbTCSHNi>; Wed, 19 Mar 2003 02:13:38 -0500
Message-ID: <3E781B75.6080206@snapgear.com>
Date: Wed, 19 Mar 2003 17:25:41 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: micklweiss@gmx.net, linux-kernel@vger.kernel.org
Subject: Re:  Linux on 16-bit processors
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mick,

> I'm interested on running Linux on some less powerful, cheaper 16 bit
> systems. I would like to know if there is a slimmed down version of the kernel (any
> version 2.2+) that can run on 16-bit CPUs. I know that linux "requires" a
> 32-bit CPU, but I know that it has run on less. I'm interested in any arch -
> really. 
> I can't seem to find a slimmed down version of the kernel. Any projects out
> there? Something with decent performance would be cool too. :o)

You want uClinux, http://www.uclinux.org.


> I'm not apart of the list, so if you could pleace CC: any replies to this
> e-mail (micklweiss@gmx.net) that would be great.
> 
> I asked before at a local user group (southflorida embedded user group)..
> and this is what info they got me. I just cut-n-pasted.
> 
> <cut>
> 
> To: Mick Weiss
> From: "wblake@emsys.net" <wblake@emsys.net>
> 
> glad to help. you have interesting research.
> Most handhelds these days are 32 bit processors, even pagers. Mostly some
> ARM variant especially Intel StrongArm.

Allmost all Palm's use a Motorola 68k varient (either
68328, 68EZ328 or 68VZ328). These have no MMU.


> The main obstacle to running Linux on smaller (cheaper) CPUs seems to be an
> MMU which Linux and most Unixes expect.

Nope. That is what uClinux is all about. Running Linux without
an MMU. We have been doing it for years. First supported on
kernels in the linux-2.0.x range. Most people using 2.4.x these
days, or now uClinux is part of standard linux, it is in all
the latest 2.5.x kernels.


[snip]
> Lineo supports processors in the following specific architectures: 
> 
> 32 bit with memory management 
> 32 bit without memory management 
> 16 bit/ 16 bit DSP 
> 8 bit processor/ 8 bit controller 
> 
> and uclinux is a whopping $200 (its whopping when your just messing with it
> on your spare time ;), plus I'm not sure how its licenced (GPL?).

Well this is most certainly wrong. uClinux is free. It is just
a set of patches against standard linux kernels, so it is,
offcourse, covered by the GPL. You can get all the code at
www.uclinux.org or under cvs at cvs.uclinux.org

Lots of MMUless processors support, including Motorola 68000/683xx
and ColdFire varients, ARM7TDMI cores (from Atmel, Conexant, Samsung,
NetSilicon, etc), NEC v850, Sparc LEON, Intel i960, Hitachi H8/300,
MIPS (MMUless varients, for example from Brecis), FPGA soft cores
(like Altera NIOS, OpenCores OpenRISC, etc).

Regards
Greg




------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:   gerg@uclinux.org
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

