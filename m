Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273438AbRIQVVq>; Mon, 17 Sep 2001 17:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273697AbRIQVVg>; Mon, 17 Sep 2001 17:21:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39184 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273438AbRIQVV1>; Mon, 17 Sep 2001 17:21:27 -0400
Subject: Re: how to get cpu_khz?
To: root@chaos.analogic.com
Date: Mon, 17 Sep 2001 22:26:09 +0100 (BST)
Cc: dfries@mail.win.org (David Fries), john@worldwideweber.org (John Weber),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010917155650.17392A-100000@chaos.analogic.com> from "Richard B. Johnson" at Sep 17, 2001 03:58:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15j5u6-0007ur-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > calculated at boot time (that's where /proc/cpuinfo gets its data) and
> > that variable doesn't appear to be exported to the rest of the kernel,
> > either that or I'm just missing something, which I would rather be the
> > case at this point.
> > 
> 
> Ask Alan to export it by default. If no-go, export it in your
> configuration.

Processor speed from cpu_khz is not a constant, it varies per processor
on split multiplier SMP and it varies on certain kinds of power management.
For delays we have udelay(). That has a chance of supporting speed changes
