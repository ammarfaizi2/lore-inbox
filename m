Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135700AbREBRvH>; Wed, 2 May 2001 13:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135686AbREBRvA>; Wed, 2 May 2001 13:51:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19985 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135701AbREBRup>; Wed, 2 May 2001 13:50:45 -0400
Subject: Re: Problems even with 512 block size MOs
To: bon@elektron.ikp.physik.tu-darmstadt.de (Uwe Bonnes)
Date: Wed, 2 May 2001 18:53:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <15088.18199.487902.514295@hertz.ikp.physik.tu-darmstadt.de> from "Uwe Bonnes" at May 02, 2001 07:42:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14v0om-00042i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Copying a 6.5 MByte file with cp returns nearly immediately on the
> commandline, but umount nearly takes forever. Maximum rate detected by
> xosview during umount was about 30 kByte.
> 
> I have similar behaviour on another machine and with different disk. However
> I don't get any "dmesg" output despite the "CONFIG_SCSI_LOGGING=y" option on
> both machines.

That sounds like it isnt queueing multiple commands at a time. M/O has
an erase/write sequence so you want to queue large blocks otherwise its two
rotations per I/O

> Are all my MO disks rotten? Are the MO drives broken? Are my SCSI adapters
> broken? Or is there a bug in the SCSI layer?

SCSI layer or scsi driver I suspect.

