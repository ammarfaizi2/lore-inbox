Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268434AbTBNPcC>; Fri, 14 Feb 2003 10:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbTBNPcC>; Fri, 14 Feb 2003 10:32:02 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:61429 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S268434AbTBNPcC>;
	Fri, 14 Feb 2003 10:32:02 -0500
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Edward King <edk@cendatsys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E4D0029.5090005@cendatsys.com>
References: <7b263321.0302140626.2ddb7980@posting.google.com>
	 <3E4D0029.5090005@cendatsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045237300.540.43.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 14 Feb 2003 16:41:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 15:41, Edward King wrote:

> Just wanted to jump in here -- I'm setting up a box using two PDC20268
> controllers for a 4 drive software raid.  The system locks on heavy
> disk activity only if dma is active.
> 
> I was watching this thread and put in the patch to remove the
> "drive->waiting_for_dma++;" line.  I still get lockups and the message
> on the console is:
> 
> hdg: dma_timer_expiry: dma status == 0x21
> hde: dma_timer_expiry: dma status == 0x21
> hdg: timeout waiting for DMA
> PDC202XX: Secondary channel reset
> hdg: timeout waiting for DMA
> hdg: (__ide_dma_test_irq) called while not waiting
> hdg: status error: status = 0x58 { DriveReady SeekComplete DataRequest

The above error is a different problem. Before trying to track it
down, I'd strongly suggest that you first check if it still happens
with the latest 2.4.21-pre4-acX from kernel.org


Ben.

