Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUBSQ2l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267355AbUBSQ2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:28:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42421 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267348AbUBSQ2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:28:36 -0500
Date: Thu, 19 Feb 2004 17:27:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joilnen Leite <pidhash@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: ide-scsi lock
Message-ID: <20040219162759.GV27190@suse.de>
References: <20040219135311.95851.qmail@web12603.mail.yahoo.com> <4034D46B.4020204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4034D46B.4020204@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19 2004, Jeff Garzik wrote:
> Joilnen Leite wrote:
> >drivers/scsi/ide-scsi.c:897
> >
> >spin_lock_irqsave(&ide_lock, flags);
> >while (HWGROUP(drive)->handler) {
> >       HWGROUP(drive)->handler = NULL;
> >       schedule_timeout(1);
> >}
> 
> 
> Yep, that's definitely a bug.  Good spotting.

It's a known bug, Williams patches fix it. Which reminds me...

-- 
Jens Axboe

