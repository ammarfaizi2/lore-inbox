Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbTCMOt6>; Thu, 13 Mar 2003 09:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbTCMOt6>; Thu, 13 Mar 2003 09:49:58 -0500
Received: from users.ccur.com ([208.248.32.211]:63840 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S262370AbTCMOt5>;
	Thu, 13 Mar 2003 09:49:57 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200303131459.OAA18664@rudolph.ccur.com>
Subject: Re: [PATCH] bug in 2.4 bh_kmap_irq() breaks IDE under preempt patch
To: axboe@suse.de (Jens Axboe)
Date: Thu, 13 Mar 2003 09:59:45 -0500 (EST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <20030313092601.GB827@suse.de> from "Jens Axboe" at Mar 13, 2003 10:26:01 AM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I fixed this in 2.5 ages ago, just didn't get it in 2.4 block-highmem...
> There's a tiny bit missing from your patch:
> 
> > +	local_irq_save(*flags);
> 	local_irq_disable();
> 
> other than that it's fine. See 2.5 for reference.

local_irq_save() does a local_irq_disable() as part of its function.
Joe
