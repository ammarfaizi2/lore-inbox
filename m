Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSGXWjz>; Wed, 24 Jul 2002 18:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSGXWjz>; Wed, 24 Jul 2002 18:39:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8651 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317611AbSGXWjy>; Wed, 24 Jul 2002 18:39:54 -0400
Date: Thu, 25 Jul 2002 00:42:47 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Bill Davidsen <davidsen@tmr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Safety of IRQ during i/o
In-Reply-To: <200207242237.g6OMbSO10262@devserv.devel.redhat.com>
Message-ID: <Pine.SOL.4.30.0207250041400.15959-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Pete Zaitcev wrote:

> >[...]
> > I would think that this would be safe when using DMA, and likely to be
> > safe for PIO and more recent chipsets, but I wouldn't want to actually
> > tell anyone that.
>
> A little story from OLS. I have a 486/75 laptop, which can only
> do PIO. It always was losing characters evern on 9600 baud on its
> serial port, and I thought it was simply broken for five years.

:-)

> A guy who did a security talk showed me that doing hdparm -u
> fixes the problem. Apparently, the lappy has a non-buffering UART.
>
> So, it seems that hdparm -u is a very useful thing for obsotele
> boxes. If you do DMA, you probably do not care.

Yup, for PIO unmask (if possible) is a must.

--bzolnier

> -- Pete

