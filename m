Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbUFFLK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUFFLK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 07:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUFFLK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 07:10:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41161 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263271AbUFFLKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 07:10:35 -0400
Date: Sun, 6 Jun 2004 13:10:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       der.eremit@email.de
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040606111032.GA13836@suse.de>
References: <200406060007.10150.kernel@kolivas.org> <200406062038.31045.kernel@kolivas.org> <20040606105852.GA19254@suse.de> <200406062105.40325.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406062105.40325.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06 2004, Con Kolivas wrote:
> On Sun, 6 Jun 2004 20:58, Jens Axboe wrote:
> > On Sun, Jun 06 2004, Con Kolivas wrote:
> > > On Sun, 6 Jun 2004 19:28, Jens Axboe wrote:
> > > > On Sun, Jun 06 2004, Con Kolivas wrote:
> > > > > hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest
> > > > > } hdd: status error: error=0x00
> > > > > hdd: drive not ready for command
> > > > > hdd: ATAPI reset complete
> > I'll take a better look then. Can you check if backing out the entire
> > change makes 2.6.7-rcX work? I've attached it for you.
> 
> drivers/ide/ide-cd.c: In function `cdrom_start_read_continuation':
> drivers/ide/ide-cd.c:1279: warning: implicit declaration of function `MIN'
> 
> followed by
> drivers/built-in.o(.text+0x687cf): In function 
> `cdrom_start_read_continuation':
> drivers/ide/ide-cd.c:1279: undefined reference to `MIN'
> make: *** [.tmp_vmlinux1] Error 1

Ah fudge, can you make the obvious corrections and test that?

-- 
Jens Axboe

