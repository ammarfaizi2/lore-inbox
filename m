Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261417AbRETF5u>; Sun, 20 May 2001 01:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbRETF5k>; Sun, 20 May 2001 01:57:40 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:51894
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S261417AbRETF52>; Sun, 20 May 2001 01:57:28 -0400
Message-ID: <000901c0e0f2$499590a0$6daaa8c0@Kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: ATA/ATAPI driver development
Date: Sat, 19 May 2001 23:01:18 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting ready to make some changes to the ide-floppy driver (to support
dynamic media change notification), and after spending a few days reviewing
most of the IDE driver code (ide, ide-disk, ide-cd, ide-floppy and
ide-probe), I think I've got a good handle on what needs to be done.
However, since what I need to do involves sending some ATA (not ATAPI)
commands to the drive, that will add some complexity to the ide-floppy
driver. I'm not opposed to that, but it appears that many of the other
drivers (ide, ide-disk and ide-cd) already have code to send an ATA command
(writing to the registers), and interrupt handlers to handle sending or
receiving the buffer(s) of data that the command wants to transfer.

Is this the way it is intended to be, with this code duplicated in multiple
subdrivers? The sheer complexity of the DMA interface would make me think it
would be far better for this "infrastructure" stuff to all be in ide.c, and
just be used by the subdrivers. I can certainly make yet another copy of the
code for the few commands that ide-floppy will need to be able to issue, but
before I went about that I thought I'd see if there was a better plan...
Thanks for your attention.

