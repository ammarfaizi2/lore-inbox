Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbRBAAJV>; Wed, 31 Jan 2001 19:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129344AbRBAAJM>; Wed, 31 Jan 2001 19:09:12 -0500
Received: from leviathan.bkw.stw-bonn.de ([131.220.158.243]:53514 "EHLO
	leviathan.bkw.stw-bonn.de") by vger.kernel.org with ESMTP
	id <S129258AbRBAAJG>; Wed, 31 Jan 2001 19:09:06 -0500
Date: Thu, 1 Feb 2001 01:09:11 +0100
Message-Id: <200102010009.BAA22560@leviathan.bkw.stw-bonn.de>
From: Joerg Dietrich <joerg@dietrich.net>
To: linux-kernel@vger.kernel.org
Subject: Re: seti@home and es1371
X-Newsgroups: leviathan.lkml
In-Reply-To: <20010131171130.A1664@mulder.konqui.de>
Organization: Rheinische Friedrich-Wilhelms Universitaet Bonn
X-PGP-Keys: mail -s "send public key" joerg@dietrich.net </dev/null
X-PGP-KeyID: 1024D/2B693EBF
X-PGP-Fingerprint: 062B A4C3 73D5 51F3 312A  F7F0 24A1 BECC 2B69 3EBF
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I hope you can help me. I have a problem with my on board soundcard and
> seti. I have a Gigabyte GA-7ZX Creative 5880 sound chip. I use the kernel

This board doesn't by any chance have a VIA KT133 chip set?

> driver es1371 and it works goot. But when I run seti@home I got some noise
> in my sound when I play mp3 and other sound. But it is not every time 10s

I had the same problem with my ASUS A7V and Soundblaster PCI64, 
and I know someone who had the same problem with a Gigabyte 7KX. 
Only link between us was the chip set and the sound driver (and 
the knowledge that it worked flawlessly under Windows and with
other chip sets on slower CPUs). 

So all claims linking this to CPU hungry programs or bad onboard 
hardware are simply wrong. Which Kernel version do you run? 2.2.17?

All I can tell you is that it is gone now. I wrote a wrapper
script around xmms to stop seti when xmms start and continue seti
when xmms exits. Not very nice but it worked.

Then one day I started mpg123 without stoping seti first. The
problem was gone. What had changed? The kernel version from 
2.2.17 to 2.2.18+VM-global. I don't know if it's 2.2.18 or the 
VM-global patch the made the problem disappear. I never digged
into this.

Try them, I hope it works for you.

Regards,
        Jo:rg

-- 
Fortune cookie of the day:
Weinberg's Principle:
	An expert is a person who avoids the small errors while
	sweeping on to the grand fallacy.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
