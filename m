Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265362AbUFBGgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUFBGgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 02:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265368AbUFBGgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 02:36:17 -0400
Received: from dns1.vodatel.hr ([217.14.208.29]:16560 "EHLO dns1.vodatel.hr")
	by vger.kernel.org with ESMTP id S265362AbUFBGgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 02:36:16 -0400
From: "Tvrtko A. =?utf-8?q?Ur=C5=A1ulin?=" <tvrtko.ursulin@zg.htnet.hr>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Question about IDE disk shutdown
Date: Wed, 2 Jun 2004 08:27:59 +0200
User-Agent: KMail/1.6.2
References: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr> <200406020041.22420.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200406020041.22420.bzolnier@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406020827.59515.tvrtko.ursulin@zg.htnet.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 00:41, Bartlomiej Zolnierkiewicz wrote:

> > Following that I see that ide_device_shutdown flushes the cache, and then
> > calls dev->bus->suspend(dev, PM_SUSPEND_STANDBY); which is in fact
> > generic_ide_suspend, right? There, something called REQ_PM_SUSPEND is
> > issued to the drive. As SUSPEND != STANDBY or SLEEP, I am left uncertain.
> >
> > Is there a place to be worried or I am missing something?
>
> You are missing PM code in ide-disk.c.  :-)
>
> See idedisk_start_power_step() and idedisk_complete_power_step(),
> also read comment in <linux/ide.h> about ide_pm_state_*.

I saw that, but the comment speaks only about power management. Therefore I 
wasn't sure that this path is also taken during standard power-off. Thanks!
