Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293190AbSBWT2q>; Sat, 23 Feb 2002 14:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293191AbSBWT2h>; Sat, 23 Feb 2002 14:28:37 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:32746 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S293190AbSBWT2Z>;
	Sat, 23 Feb 2002 14:28:25 -0500
Date: Fri, 22 Feb 2002 20:28:41 +0100
From: Jose Luis Domingo Lopez <jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA hard lock at boot time (KT266A chpiset)
Message-ID: <20020222192840.GB1212@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200202231812.TAA04425@enigma.deepspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200202231812.TAA04425@enigma.deepspace.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 23 February 2002, at 19:12:18 +0100,
Wolly wrote:

> Hi all, 
> 
> I'm using an elitegroup mobo (K7VTA3 / KT266A chipset; Athlon XP) 
> and I'm experiencing a hard lock at boot time when configuring the 
> kernel using `via82cxx support'. (No ctrl-alt-del, no sysrq, only hw reset)
> [...]
>
I have a similar hardware setup here (Soltek SL-75DRV2 with KT266A
chipset + Athlon XP 1700+), and although the box boots and runs fine
(even with Athlon optimizations and VIA82CXXX compiled in), from time to
time the machine locks solid (no kind of response from the box, HDD
light keeps on, power cicle needed).

K7 optimizations and VIA chipsets seem to be quite problematic pieces of
hardware, but in my case you have to add to this a GeForce2 MX video
card, with NO closed-binary nVidia drivers.

Machine freezes seems to follow the following pattern: working on X
environment, watching TV (PCI TV capture card), listening to digital
audio music (aka MP3 :) and some sort of disk access. A high number of
freezes seem to happen when opening a medium sized mailbox in Maildir
format (aproximately 800 messages/files inside). As the box has 256 MB
of RAM, and the mailbox has been read before, the whole directory is
maybe cached, except for newly arrived messages.

"mutt" starts reading the mailbox, and after some hundreds of messages,
the box locks solid. Digital audio stops, overlaid TV capture stops,
SysRq does nothing, network unresponsive. Looking at the logs shows
nothing, even after having tried SysRq+everything after the lock.

The cause of all this ?. Maybe Athlon optimizations, maybe a severe flaw
in the chipset and/or motherboard BIOS, maybe ALSA sound (VIA8233 sound
doesn't work with OSS modules) not fine, maybe crappy nVidia-based video
card....who knows. No overclocking of any kind by the way, and
temperature seems to be under control.

I'll try setting AGP speed to x2 instead of x4, adding Option "NvAgp" "0"
to my X 4.x configuration, disabling DRI and any kind of 3D
acceleration, etc... and whatever I devise to get again a box I can
trust. Damn, I should not have asked for a VIA-based board...

--
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

