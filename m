Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbVFYIbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbVFYIbo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 04:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbVFYIbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 04:31:44 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:21464 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S263365AbVFYIaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 04:30:06 -0400
Subject: Re: Promise ATA/133 Errors With 2.6.10+
From: Erik Slagter <erik@slagter.name>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0506241653580.31140@p34>
References: <Pine.LNX.4.63.0506241653580.31140@p34>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Jun 2005 10:29:51 +0200
Message-Id: <1119688191.4293.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-24 at 16:55 -0400, Justin Piszcz wrote:

> Jun 24 15:24:18 localhost kernel: PDC202XX: Primary channel reset.
> Jun 24 15:24:18 localhost kernel: hde: timeout waiting for DMA
> Jun 24 15:24:18 localhost kernel: hde: status error: status=0x58 { 
> DriveReady SeekComplete DataRequest }
> Jun 24 15:24:18 localhost kernel:
> Jun 24 15:24:18 localhost kernel: ide: failed opcode was: unknown
> Jun 24 15:24:18 localhost kernel: hde: drive not ready for command
> Jun 24 15:24:18 localhost kernel: hde: status timeout: status=0xd0 { Busy 
> }
> Jun 24 15:24:18 localhost kernel:
> Jun 24 15:24:18 localhost kernel: ide: failed opcode was: unknown
> Jun 24 15:24:18 localhost kernel: PDC202XX: Primary channel reset.
> Jun 24 15:24:18 localhost kernel: hde: no DRQ after issuing MULTWRITE_EXT
> Jun 24 15:24:18 localhost kernel: ide2: reset: success

I have exactly this (these messages) but then with a amd/via ata driver
on tyan/amd motherboard with an IBM/Hitachi harddisk.

It looks like the drive cpu locks up every now and then, notably when
the environmental temperature and/or the drive's temperature are high
and there is much activity on the drive.

A reset (either from the driver or manually using hdparm) helps
(temporarily).

I was going to buy new drives for this fact (from another brand) but it
looks that won't necessarily mean my problem will be solved :-(

BTW I have another, exactly identical harddisk in the same computer
(well, ok, 1 year younger) and that one doesn't show the problem. 

BTW2 could it be that somewhere a timeout has been lowered in recent
kernels? That must have been pre-2.6.11 then.
