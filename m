Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRDBPhL>; Mon, 2 Apr 2001 11:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRDBPhC>; Mon, 2 Apr 2001 11:37:02 -0400
Received: from [202.77.223.60] ([202.77.223.60]:20230 "HELO server.achan.com")
	by vger.kernel.org with SMTP id <S129679AbRDBPgr>;
	Mon, 2 Apr 2001 11:36:47 -0400
Message-ID: <003e01c0bb8a$8cd4a140$3700a8c0@pluto>
From: "Andrew Chan" <achan@achan.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Promise 20267 "working" but no UDMA
Date: Mon, 2 Apr 2001 23:35:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, upon further testing, I found that the MB will move on without an
Fasttrack array. However, it will proceed to boot from PXE because it now
thinks that there is no hard disk attached to the entire system (as reported
by the Promise RAID chip)!

So,

1. Promise driver doesn't support SMP or 2.4.x kernels

2. Linux IDE code won't support the chip in any Promise RAID config, not
even single disk span

3. If not under RAID config, the motherboard thinks it has no hard disk, so
booting from disk is not possible even though the kernel can run the disks
in ATA100 mode

The remaining alternative is to boot from floppy (to load the kernel) and
specify the hard disk as root disk... :-(

I am most disappointed with Promise (not so much with Tyan).

Andrew

> >> FastTrack config: only 1 drive, configured as a SPAN volume
> >> consisting of 1 drive
>
> > No RAIDing allowed in the FTTK Bios.
>
> But my motherboard hangs at boot time (while Fasttrack tests for arrays)
> if there is no array defined! There is a message from the Fasttrack bios
> that says something like "no array found, press some key to continue".
> But I need to remotely reboot these servers!

