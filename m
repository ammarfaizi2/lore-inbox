Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268246AbTB1XSM>; Fri, 28 Feb 2003 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbTB1XSL>; Fri, 28 Feb 2003 18:18:11 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:61069 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S268246AbTB1XRZ>; Fri, 28 Feb 2003 18:17:25 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200302282326.h1SNQ0BT030423@wildsau.idv.uni.linz.at>
Subject: Re: emm386 hangs when booting from linux
In-Reply-To: <Pine.LNX.3.95.1030228174739.13518A-100000@chaos> from "Richard B. Johnson" at "Feb 28, 3 05:54:45 pm"
To: root@chaos.analogic.com
Date: Sat, 1 Mar 2003 00:26:00 +0100 (MET)
Cc: kernel@wildsau.idv.uni.linz.at, linux-kernel@vger.kernel.org,
       herp@wildsau.idv.uni.linz.at
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 28 Feb 2003, H.Rosmanith (Kernel Mailing List) wrote:
> 
> > 
> > hello,
> > 
> > for some reason, I am using the "switch to 16 bit realmode" function
> > present in the linux kernel to execute various 16bit code. One thing
> > that I am doing is to read the mbr off a harddisk to 0x7c00 and then
> > jump to there. This allows to e.g. "quickboot dos" from linux without
> > having to go through bios startup.
> > 
> > I got this working with *one* exception: as soon as I load emm386
> > in config.sys, the system hangs. It doesn't hang completely, e.g.
> > the num-lock led changes light when pressing num-lock, and ctrlaltdel
> > reboots the system. When I "REM"ark the emm386.exe, then dos will
> > boot and display a "C:\>" prompt.
> 
> So you are trying a "home-brew" DOS-EMU which already exists and works
> well.

hm?
I am trying to boot "real" DOS from linux.

> emm386.exe attempts to go to protected mode. That's how it works.

and when going into protected mode, it crashes. I wonder why. I can
start DOS4GW, which does not crash, and I think that DOS4GW too works
with the protected mode features of the CPU.

> That's how it's able to make "high-RAM" appear in "low-RAM" windows
> for the emm386 specification. Of course it will fail when you
> are in virtual 386 mode. The real DOS-EMU emulates the extended/expanded

after executing "machine_real_start", the system is in 16 bit real mode,
not in vm86 mode.

> memory specification so you don't need this in 'config.sys'. I sometimes
> boot real DOS usinf DOS-EMU and it works fine. You need to configure
> it so it will look at, say config.emu, instead of the DOS config.sys.
> That way, you can keep boot-specific configuration files. 

the problem is not only with DOS. when booting M$-Windows (w2k), the
boot-process will hang as soon as w2k tries to enter protected mode.

starting loadlin will hang the system too, as I just found out. hm,
well, at least it's easier looking into loadlin than looking into
emm386 !


> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think about it.
> 
> 

