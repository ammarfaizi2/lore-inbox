Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288963AbSBDM5I>; Mon, 4 Feb 2002 07:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSBDM46>; Mon, 4 Feb 2002 07:56:58 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41231 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288955AbSBDM4x>; Mon, 4 Feb 2002 07:56:53 -0500
Message-Id: <200202041255.g14CtDt12574@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Luis A. Montes" <Luis.A.Montes.1@worldnet.att.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 filesystem corruption
Date: Mon, 4 Feb 2002 14:55:15 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200202030538.g135chu00602@penguin.montes2.org>
In-Reply-To: <200202030538.g135chu00602@penguin.montes2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 February 2002 03:38, Luis A. Montes wrote:
> I have been experiencing filesystem corruption very frequently with
> 2.4.17. I've probably reinstalled my system more than 10 times in as
> many days. So far it seems to be related to the kernel version and
> perhaps to the UDMA settings. I haven't been able to crash the system
> running 2.4.5 or 2.2.19, but it has crashed with 2.4.17 every time,
> regardless of cpu optimization (Athlon, K6 or i386), AGP (built-in, as
> a module or not built), filesystem (ext2 or xfs). Last kernel I tried
> was a 2.4.17 with a ext2 fs and a patch I found by Lionel Bouton in
> this list to handle my SiS 735 chipset. It did seem more stable for a
> while, until I decided to try and enable ultra dma 66 on my primary
> drive. The two partitions that I had mounted got completely corrupted
> (on boot the kernel tried to mount it as a UMSDOS fs) and e2fsck
> wasn't able to fix it. It did seem to work with udma 33, I compiled
> the kernel without a problem as a test of disk IO, but I can't really
> tell for sure that there wasn't a subtle disk corruption just waiting
> to crop up.
>
> My system is as follows:
>
> ECS K7S5A Motherboard with the SiS 735 chipset, 128MB of PC133 SDRAM
> and Athlon XP 1700+ processor at 1.4 something MHz. Memory is good,
> tested with memtest86 overnight several full passes.
>
> hda: Western Digital Caviar WDC AC313000R (it is *not* in the udma
> black list, should it be?)

Maybe. Your report might lead to this, can you test with some hdd known to 
work with UDMA66+ in another box?

> hdb: Western Digital Caviar WDC AC23200L (this one is in the black
> list, but is not being mounted, so it shouldn't matter, right?)

Trying to disconnect it and provoke fs corruption on a test partition
on the first drive sounds like good idea...

> Software: Straight Slackware 8 install, with XFree86 from cvs. But
> lately I havent even tried glx, dri et al at all ...
>
> Questions:
>
> - There is a patch by the IDE maintainer (Andre Hedrick?), but I don't
>   know if that is supposed to make the system behave better or is a
>   new major architectural change (if it is the latest I probably don't
>   want to compound my problem, do I?) although at this point I'm
>   willing to try almost anything, even windows ;-)

Consider CC'ing Andre and Jens Axboe:
andre@linuxdiskcert.org
Jens Axboe <axboe@suse.de>
--
vda
