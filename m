Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136548AbREDWXj>; Fri, 4 May 2001 18:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136543AbREDWWm>; Fri, 4 May 2001 18:22:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22282 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136552AbREDWWH>;
	Fri, 4 May 2001 18:22:07 -0400
Date: Sat, 5 May 2001 00:21:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Roskin <proski@gnu.org>
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-ac4 - oops on unload "cdrom" module
Message-ID: <20010505002133.A23814@suse.de>
In-Reply-To: <200105042110.XAA20705@green.mif.pg.gda.pl> <Pine.LNX.4.33.0105041748360.872-100000@fonzie.nine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105041748360.872-100000@fonzie.nine.com>; from proski@gnu.org on Fri, May 04, 2001 at 06:02:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04 2001, Pavel Roskin wrote:
> > The following patch fixes unloading of cdrom module when no cdrom driver
> > loaded (2.4.5-pre, 2.4.4-ac):
> 
> It works for me. Thank you! You have even managed to find out that I had
> my CD-ROM disconnected :-)
> 
> By the way, shouldn't we register sysctl, /proc/sys/dev/cdrom/ and
> /dev/cdrom/ always when the cdrom driver is loaded/initialized, not when a
> cdrom unit is found?
> 
> I don't know what's the official "policy" is, but wouldn't it be logical
> to have some control over the drivers that handle no devices in the
> moment?

We should, the -ac tree has the first cut of the cdrom updates and they
didn't have the linking right. The right init sequence fixes the issue
as well, not just initing after the first cdrom driver registers.

-- 
Jens Axboe

