Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTB1DKB>; Thu, 27 Feb 2003 22:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbTB1DKB>; Thu, 27 Feb 2003 22:10:01 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:13707 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S267436AbTB1DKA>; Thu, 27 Feb 2003 22:10:00 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200302280318.h1S3IoxM008387@wildsau.idv.uni.linz.at>
Subject: emm386 hangs when booting from linux
To: linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2003 04:18:50 +0100 (MET)
Cc: herp@wildsau.idv.uni.linz.at (Herbert Rosmanith)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,

for some reason, I am using the "switch to 16 bit realmode" function
present in the linux kernel to execute various 16bit code. One thing
that I am doing is to read the mbr off a harddisk to 0x7c00 and then
jump to there. This allows to e.g. "quickboot dos" from linux without
having to go through bios startup.

I got this working with *one* exception: as soon as I load emm386
in config.sys, the system hangs. It doesn't hang completely, e.g.
the num-lock led changes light when pressing num-lock, and ctrlaltdel
reboots the system. When I "REM"ark the emm386.exe, then dos will
boot and display a "C:\>" prompt.

"machine_real_restart" is in <arch/i386/kernel/process.c> - possibly
it forgets to reset something particular in the cpu/mmu...and later on,
emm386.exe will hang the system. Interestingly, DOS4GW will *not* hang
the system and vertex-inducing games like doom & co. will work like
a charm (woah ... I haven't been playing doom for ages! <streisand> "memories"
</streisand>).

emm386.exe is about 116k byte, so it's probably not written in asm.
I've been searching the web for source-code for some emm, but so far,
no luck. any hint about what could be wrong? maybe I am only 1 bit
away from success, but I will like searching the bit in the haystack.

thanks in advance,
herp
