Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUFFLF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUFFLF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 07:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUFFLF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 07:05:57 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:385 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263219AbUFFLFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 07:05:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Date: Sun, 6 Jun 2004 21:05:40 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       der.eremit@email.de
References: <200406060007.10150.kernel@kolivas.org> <200406062038.31045.kernel@kolivas.org> <20040606105852.GA19254@suse.de>
In-Reply-To: <20040606105852.GA19254@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406062105.40325.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2004 20:58, Jens Axboe wrote:
> On Sun, Jun 06 2004, Con Kolivas wrote:
> > On Sun, 6 Jun 2004 19:28, Jens Axboe wrote:
> > > On Sun, Jun 06 2004, Con Kolivas wrote:
> > > > hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest
> > > > } hdd: status error: error=0x00
> > > > hdd: drive not ready for command
> > > > hdd: ATAPI reset complete
> I'll take a better look then. Can you check if backing out the entire
> change makes 2.6.7-rcX work? I've attached it for you.

drivers/ide/ide-cd.c: In function `cdrom_start_read_continuation':
drivers/ide/ide-cd.c:1279: warning: implicit declaration of function `MIN'

followed by
drivers/built-in.o(.text+0x687cf): In function 
`cdrom_start_read_continuation':
drivers/ide/ide-cd.c:1279: undefined reference to `MIN'
make: *** [.tmp_vmlinux1] Error 1

Con
