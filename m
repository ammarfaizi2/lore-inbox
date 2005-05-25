Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVEYVL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVEYVL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVEYVL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:11:26 -0400
Received: from mail.emacinc.com ([208.248.202.76]:2973 "EHLO mail.emacinc.com")
	by vger.kernel.org with ESMTP id S261553AbVEYVLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:11:23 -0400
From: NZG <ngustavson@emacinc.com>
Organization: EMAC.Inc
To: linux-kernel@vger.kernel.org
Date: Wed, 25 May 2005 16:10:30 -0500
User-Agent: KMail/1.7.1
References: <Pine.OSF.4.05.10505252303300.23201-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505252303300.23201-100000@da410.phys.au.dk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505251610.30868.ngustavson@emacinc.com>
X-SA-Exim-Connect-IP: 208.248.202.77
X-SA-Exim-Mail-From: ngustavson@emacinc.com
Subject: Re: RT patch acceptance
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the RT patch for the x86 only or is it arch independent?
I'd like to do some work with it on our embedded boards if I don't get 
restricted to pentiums.

thx,
NZG.

On Wednesday 25 May 2005 16:05, Esben Nielsen wrote:
> On Wed, 25 May 2005, Tom Vier wrote:
> > If irqs are run in threads, which are scheduled, how are they scheduled?
> > fifo? What's the point then; simply to let the top half run to completion
> > before another top half starts? If it's about setting scheduling
> > priorities for irq threads, some one top half can prempt another, why not
> > just use irq levels, like bsd (using pic's is slower than using
> > threads?)?
>
> Long interrupt handlers can be interrupt by _tasks_, not only other
> interrupts! An audio application running in userspace can be scheduled
> over an ethernet interrupt handler copying data from the
> controller into RAM (without DMA).
>
> Esben
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
