Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314128AbSDZTIT>; Fri, 26 Apr 2002 15:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314129AbSDZTIS>; Fri, 26 Apr 2002 15:08:18 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:27785 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314128AbSDZTIS>; Fri, 26 Apr 2002 15:08:18 -0400
To: linux-kernel@vger.kernel.org
Cc: stephan@maciej.muc.de
Subject: Re: [BUG] 2.5.10 - kernel hangs after detecting CD/DVD ROM (was: Re: IDE problem:  2.5.10 compiles but hangs during boot)
In-Reply-To: <200204251757.07947.stephan@maciej.muc.de>
From: Andi Kleen <freitag@alancoxonachip.com>
X-No-Archive: yes
Date: 26 Apr 2002 21:08:13 +0200
Message-ID: <m3adrq6zxe.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan Maciej <stephan@maciej.muc.de> writes:
> later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
> hda: HITACHI_DK23CA-20, ATA DISK drive
> hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
> 
> That's the last line I see from a 2.5.10 kernel booting up. 2.5.9 does go
> farther:

I have a similar problem on the VirtuHammer simulator. On trying to access
the virtual disk using PIO mode the simular breaks with an error
in a rep ; outsb loop complaining about "writing data while in data in phase".
I guess your problem could be the same, as the DVD is likely accessed
using PIO. 2.5.10 fails, 2.5.9 works.

-Andi
