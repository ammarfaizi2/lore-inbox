Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136529AbREDWDO>; Fri, 4 May 2001 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136531AbREDWDE>; Fri, 4 May 2001 18:03:04 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:13831 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S136529AbREDWCu>; Fri, 4 May 2001 18:02:50 -0400
Date: Fri, 4 May 2001 18:02:11 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        kernel list <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: Re: 2.4.4-ac4 - oops on unload "cdrom" module
In-Reply-To: <200105042110.XAA20705@green.mif.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0105041748360.872-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrzej!

> The following patch fixes unloading of cdrom module when no cdrom driver
> loaded (2.4.5-pre, 2.4.4-ac):

It works for me. Thank you! You have even managed to find out that I had
my CD-ROM disconnected :-)

By the way, shouldn't we register sysctl, /proc/sys/dev/cdrom/ and
/dev/cdrom/ always when the cdrom driver is loaded/initialized, not when a
cdrom unit is found?

I don't know what's the official "policy" is, but wouldn't it be logical
to have some control over the drivers that handle no devices in the
moment?

Actually, the scsi module behaves differently. Right now I have empty
/dev/scsi and /proc/scsi/scsi contains "Attached devices: none"

Anyway, the patch is small, straightforward and consistent with the
current behavior of the driver. And it works.

-- 
Regards,
Pavel Roskin

