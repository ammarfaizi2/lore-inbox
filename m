Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270240AbRHRQXY>; Sat, 18 Aug 2001 12:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270247AbRHRQXE>; Sat, 18 Aug 2001 12:23:04 -0400
Received: from citd-ppp.paderlinx.de ([193.189.252.149]:62215 "EHLO
	mail.citd.de") by vger.kernel.org with ESMTP id <S270240AbRHRQWx>;
	Sat, 18 Aug 2001 12:22:53 -0400
Date: Sat, 18 Aug 2001 18:23:00 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Slowdown
Message-ID: <20010818182300.A15860@citd.de>
In-Reply-To: <Pine.LNX.4.20.0108181156140.5058-100000@citd.owl.de> <E15Y5ew-00014A-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E15Y5ew-00014A-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Aug 18, 2001 at 01:57:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After i switched "High Memory-Support" to "OFF"(4GB Before) the speed went
> > to normal, but now less than half RAM is used.
> > Any suggestions?
> 
> This sounds like the top of memory is running uncached due to wrong mtrr
> settings from the BIOS. Can you post your /proc/mtrr 

Because of other reasons i'm back to 2.2.19

/proc/mtrr from 2.2.19 show this
-- /proc/mtrr --
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x40000000 (1024MB), size= 512MB: write-back, count=1
reg02: base=0x60000000 (1536MB), size= 256MB: write-back, count=1
reg03: base=0x70000000 (1792MB), size= 128MB: write-back, count=1
reg04: base=0x78000000 (1920MB), size=  64MB: write-back, count=1
reg05: base=0x7c000000 (1984MB), size=  32MB: write-back, count=1
-- end --
(32MB "missing". Seems like Linux uses these "missing" MBs.)

For the 2.4.X-Kernel i had switched off the MTRR-Kernel-Option!

Maybe i should try it another time with MTRR-Support switched on. 
Or i should use "mem=2016M".



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

