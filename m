Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBRD3W>; Sat, 17 Feb 2001 22:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbRBRD3M>; Sat, 17 Feb 2001 22:29:12 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:4868 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S129027AbRBRD26>;
	Sat, 17 Feb 2001 22:28:58 -0500
Date: Sat, 17 Feb 2001 21:28:27 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: Pete Toscano <pete.lkml@toscano.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1ac17 hang on mounting loopback fs
In-Reply-To: <20010217191930.A12036@bubba.toscano.org>
Message-ID: <Pine.LNX.4.30.0102172126430.686-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Pete Toscano wrote:

> reading this, I see now why mkbootdisk was locking in the D state with
> the loop mounted... Would this also explain not being able to seek
> forward while writing a floppy?
>
> I was trying to make the GRUB boot disk by writing the stage 1 and 2
> loaders to the floppy (as per the GRUB docs) with dd:
>
> [root@bubba grub]# dd of=/dev/fd0 if=stage1 bs=512 count=1
> 1+0 records in
> 1+0 records out
> [root@bubba grub]# dd of=/dev/fd0 if=stage2 bs=512 seek=1
> dd: advancing past 1 blocks in output file `/dev/fd0': Permission denied

Different problem.  Add conv=notrunc to the dd command to make it work.

