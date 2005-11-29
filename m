Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVK2PWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVK2PWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVK2PWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:22:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56869 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751377AbVK2PWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:22:05 -0500
Date: Tue, 29 Nov 2005 16:23:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Luke-Jr <luke-jr@utopios.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd doesn't replace ide-scsi?
Message-ID: <20051129152300.GX15804@suse.de>
References: <200511281218.17141.luke-jr@utopios.org> <438B70AA.7090805@tmr.com> <58cb370e0511290658m682ae978hea2100f57252a928@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0511290658m682ae978hea2100f57252a928@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2005, Bartlomiej Zolnierkiewicz wrote:
> > Unfortunately using ide-cd still doesn't have the code set to allow all
> > burning features to work if you are not root. Even if you have
> > read+write there's one command you need to do multi-session which is
> > only allowed to root. Works fine for single sessions, I guess that's all
> > someone uses.
> 
> Interesting because both drivers ide-cd and sr+ide-scsi use exactly
> the same code (block/scsi_ioctl.c) to verify which commands don't
> need root privileges.  Care to give details?

Not if he is using /dev/sgX with ide-scsi, only SG_IO through /dev/srX
will go through the block/scsi_ioctl.c path.

-- 
Jens Axboe

