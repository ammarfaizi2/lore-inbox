Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136175AbRECHlS>; Thu, 3 May 2001 03:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136174AbRECHlI>; Thu, 3 May 2001 03:41:08 -0400
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:46499 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S136168AbRECHk6>; Thu, 3 May 2001 03:40:58 -0400
Date: Thu, 3 May 2001 09:40:52 +0200
From: Andreas Mohr <a.mohr@mailto.de>
To: Richard Polton <Richard.Polton@morganstanley.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cannot find directory on cdrom
Message-ID: <20010503094052.A22925@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
In-Reply-To: <3AF108BE.E8957686@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF108BE.E8957686@morganstanley.com>; from Richard.Polton@morganstanley.com on Thu, May 03, 2001 at 08:29:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 08:29:02AM +0100, Richard Polton wrote:
> Hi,
> 
> I have a cdrom burnt by a friend with W2000 (I know, friends don't let
> friends use W ;-) which has (at least) one directory on it which I
> cannot
> see when mounting the disk under linux. I am using kernel 2.4.4 and
> the mount command is the usual
> 
> mount /dev/cdrom /mnt/cdrom -t iso9660
> 
> I have Joliet compiled into the kernel too. I can send by private email
> the
> first 120 blocks or so of the disk if anyone is interested. I looked at
> this
> with hexlify and can see the mysterious directory (s?) which is called
> 'sturf'.
> 
> Thanks,
> 
> Richard
Hmm, is this the old "non-standard sector alignment" problem ?
Some CDs have their directory sector entries exceed the sector, and AFAIK
the problem is that they exceed it not entry by entry,
but in the middle of a directory entry, which violates the ISO9660 spec.
The Linux CD-ROM driver used to have a workaround for this,
but then after 2.0.x it seems to have been removed.

Why ???

After all Windows perfectly accepts these broken (ISO9660 wise) CD-ROMs.

I don't know whether 2.4.x still has the same "feature" that 2.2.x had.

A Spanish language training CD of mine has this problem, and I can't read
several files on it.

Hmm, or maybe your problem is simply that you forgot to enable the
"hidden" mount option for your CD-ROM ??
(some files are burnt with "hidden" attribute !)

Andreas Mohr
