Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281361AbRKLIo6>; Mon, 12 Nov 2001 03:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281360AbRKLIoi>; Mon, 12 Nov 2001 03:44:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28171 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281357AbRKLIo2>; Mon, 12 Nov 2001 03:44:28 -0500
Subject: Re: sbp2.c on SMP
To: akpm@zip.com.au (Andrew Morton)
Date: Mon, 12 Nov 2001 08:50:48 +0000 (GMT)
Cc: hogsberg@users.sourceforge.net, jamesg@filanet.com,
        hjl@lucon.org (H . J . Lu), axboe@suse.de (Jens Axboe),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au> from "Andrew Morton" at Nov 11, 2001 05:37:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163Cno-00057M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If, for example, you call scsi_old_done() under spin_lock_irqsave(), 
> the reenabling of interrupts will expose you to deadlocks.  Perhaps
> scsi_old_done() should just use spin_unlock()/spin_lock()?

scsi_old_done ceases to exist in 2.5 thankfully. Its basically emulating
old (1.2,2.0,..) scsi completion

