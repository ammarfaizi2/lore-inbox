Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288997AbSAKRP4>; Fri, 11 Jan 2002 12:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290024AbSAKRPr>; Fri, 11 Jan 2002 12:15:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58886 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288997AbSAKRPf>; Fri, 11 Jan 2002 12:15:35 -0500
Subject: Re: Big patch: linux-2.5.2-pre11/drivers/scsi compilation fixes
To: adam@yggdrasil.com (Adam J. Richter)
Date: Fri, 11 Jan 2002 17:27:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200201111659.IAA10274@adam.yggdrasil.com> from "Adam J. Richter" at Jan 11, 2002 08:59:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P5SS-0008FV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I imagine that would be annoying, but I think you are
> misremembering.  Searching my mail since January 16, 2001, for
> "NCR5380" and "53C80", I do not see any note remotely like that.
> I don't think I have posted a patch or said anything about the
> Linux scsi drivers on linux-kernel for years.

Maybe I got the wrong person - if so I apologise.

> 	Now that I am aware of your request regarding using the 2.4.18pre
> version of the NCR driver for future maintenance of the 2.5 driver,
> I am happy to follow it.

I think you'll find it a lot easier to follow too. The thing to watch is
that the queue of devices to process on an IRQ is not per host but driver
global. The rest should be obvious, but watch the co-routine locking. If
you get that wrong the driver does occasionally recurse down the stack and
explode mysteriously.

Alan
