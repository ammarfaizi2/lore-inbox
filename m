Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317951AbSGLAfS>; Thu, 11 Jul 2002 20:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317952AbSGLAfR>; Thu, 11 Jul 2002 20:35:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42680 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317951AbSGLAfQ>; Thu, 11 Jul 2002 20:35:16 -0400
Date: Fri, 12 Jul 2002 02:37:49 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <agl7ov$p91$1@cesium.transmeta.com>
Message-ID: <Pine.SOL.4.30.0207120231200.21904-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jul 2002, H. Peter Anvin wrote:

> Okay, I have suggested this before, and I haven't quite looked at this
> in detail, but I would again like to consider the following,
> especially given the changes in 2.5:
>
> Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
> and treat all ATAPI devices as what they really are -- SCSI over IDE.
> It is a source of no ending confusion that a Linux system will not
> write CDs to an IDE CD-writer out of the box, for the simple reason
> that cdrecord needs access to the generic packet interface, which is
> only available in the nonstandard ide-scsi configuration.
>
> There really seems to be no decent reason to treat ATAPI devices as
> anything else.  I understand the ide-* drivers contain some
> workarounds for specific devices, but those really should be moved to
> their respective SCSI drivers anyway -- after all, manufacturers
> readily slap IDE or SCSI interfaces on the same devices anyway.

Already discussed/planned.

Also it has to be done with care on evolution, not revolution way.

Regards
--
Bartlomiej

> Note that this is specific to ATAPI devices.  ATA hard drives are
> another matter entirely.
>
> 	-hpa
>
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

