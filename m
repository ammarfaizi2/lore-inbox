Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTB1Wk5>; Fri, 28 Feb 2003 17:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268229AbTB1Wk5>; Fri, 28 Feb 2003 17:40:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23939 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265570AbTB1Wk4>; Fri, 28 Feb 2003 17:40:56 -0500
Date: Fri, 28 Feb 2003 17:54:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
cc: linux-kernel@vger.kernel.org,
       Herbert Rosmanith <herp@wildsau.idv.uni.linz.at>
Subject: Re: emm386 hangs when booting from linux
In-Reply-To: <200302280318.h1S3IoxM008387@wildsau.idv.uni.linz.at>
Message-ID: <Pine.LNX.3.95.1030228174739.13518A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003, H.Rosmanith (Kernel Mailing List) wrote:

> 
> hello,
> 
> for some reason, I am using the "switch to 16 bit realmode" function
> present in the linux kernel to execute various 16bit code. One thing
> that I am doing is to read the mbr off a harddisk to 0x7c00 and then
> jump to there. This allows to e.g. "quickboot dos" from linux without
> having to go through bios startup.
> 
> I got this working with *one* exception: as soon as I load emm386
> in config.sys, the system hangs. It doesn't hang completely, e.g.
> the num-lock led changes light when pressing num-lock, and ctrlaltdel
> reboots the system. When I "REM"ark the emm386.exe, then dos will
> boot and display a "C:\>" prompt.

So you are trying a "home-brew" DOS-EMU which already exists and works
well.
emm386.exe attempts to go to protected mode. That's how it works.
That's how it's able to make "high-RAM" appear in "low-RAM" windows
for the emm386 specification. Of course it will fail when you
are in virtual 386 mode. The real DOS-EMU emulates the extended/expanded
memory specification so you don't need this in 'config.sys'. I sometimes
boot real DOS usinf DOS-EMU and it works fine. You need to configure
it so it will look at, say config.emu, instead of the DOS config.sys.
That way, you can keep boot-specific configuration files. 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


