Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266178AbRF2Ukm>; Fri, 29 Jun 2001 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266177AbRF2Ukc>; Fri, 29 Jun 2001 16:40:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57504 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266178AbRF2UkV>;
	Fri, 29 Jun 2001 16:40:21 -0400
Date: Fri, 29 Jun 2001 22:40:18 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106292040.WAA358371.aeb@vlet.cwi.nl>
To: Gunther.Mayer@t-online.de, andre@aslab.com
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)V3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andre Hedrick wrote:

    > That is a legacy bit from ATA-2 but it is one of those things you cannot
    > get rid of :-(

    in ANSI X3.279-1996, "AT Attachment Interface with Extensions (ATA-2)",
    Approved September 11, 1996 , control register bit 3-7 are reserved.

    However ANSI X3.221-1994, "AT Attachment Interface for Disk Drives",
    Approved May 12, 1994, bit3 is "1" and bits 4-7 are "x".
    No further explanation.

    How far back must we go, to get the sense ?

    >   struct {
    >           unsigned bit0           : 1;
    >           unsigned nIEN           : 1;    /* device INTRQ to host */
    >           unsigned SRST           : 1;    /* host soft reset bit */
    >           unsigned bit3           : 1;    /* ATA-2 thingy */
    >           unsigned reserved456    : 3;
    >           unsigned HOB            : 1;    /* 48-bit address ordering */
    >   } control_t;
    > 
    > once I add-in the real def of bit3 then I will not
    > need to look it up again.

bit3: 0: drive has 1-8 heads
      1: drive has more than 8 heads

(From old MFM/RLL times. In ATA-1 bit3 is set to 1.
See also
	http://www.win.tue.nl/~aeb/linux/hdtypes/hdtypes-2.html
.)

Andries
