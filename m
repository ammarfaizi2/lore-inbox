Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287334AbSAGXGY>; Mon, 7 Jan 2002 18:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSAGXGO>; Mon, 7 Jan 2002 18:06:14 -0500
Received: from mail.vr-web.de ([195.243.197.42]:54031 "HELO mail.VR-Web.de")
	by vger.kernel.org with SMTP id <S287334AbSAGXGF>;
	Mon, 7 Jan 2002 18:06:05 -0500
Date: Mon, 7 Jan 2002 23:58:53 +0100 (CET)
From: Matthias Hanisch <mjh@vr-web.de>
To: Carl Scarfoglio <scarfoglio@arpacoop.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre9 - HD performance degradation
In-Reply-To: <3C3A0E04.9020909@arpacoop.it>
Message-ID: <Pine.LNX.4.10.10201072354360.4514-100000@pingu.franken.de>
Organization: Matze at his stone-old Linux Box
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Carl Scarfoglio wrote:

> I ran hdparm -t on my disks and discovered an abysmal drop in hard disk 
> performance since 2.5.2-pre1. Yesterday I ran fsck on all disks and it 
> took more than three times as much to complete under 2.5.2-pre9 than 
> usual. I am running SuSE 6.3, MB is Asus A7v, controller ATA 33 + 
> Promise PDC 20265.
> These are the results for a disk, (ATA 100 IBM 307030),for the other 
> disks they are pretty the same.
> Resuslts for "hdpam -t /dev/hdg"
> Kernel 2.5.2-pre1 - 35 MB/sec
> Kernel 2.5.2-pre4 - 15 MB/sec
> Kernel 2.5.2-pre9 - 10 MB/sec
> For the rest, it seems pretty stable, but I still get kernel panic on 
> cold boots from the AHA 2904 (AIC7850).
> Cheers,
> 		Carlo Scarfoglio


Could be scheduler related. Please try the fresh fix from Davide:

> In sched.c::init_idle() :
>
> current->dyn_prio = -100;
> 
> Let me know.

For more info, see also the related thread here in LKML:

http://marc.theaimsgroup.com/?t=101019244200001&r=1&w=2&n=12

	Matze

