Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269386AbRGaRsZ>; Tue, 31 Jul 2001 13:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRGaRsN>; Tue, 31 Jul 2001 13:48:13 -0400
Received: from admin.manx.net ([195.10.115.5]:62226 "EHLO mail.manx.net")
	by vger.kernel.org with ESMTP id <S269387AbRGaRsG>;
	Tue, 31 Jul 2001 13:48:06 -0400
Reply-To: <nigel-home@corleco.com>
From: "Nigel Bennington" <nigel-home@corleco.com>
To: <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Broken source file in v2.4.7 sources
Date: Tue, 31 Jul 2001 18:47:40 +0100
Message-ID: <NPEEKFLGNDBMBALCMAHGAEBBCBAA.nigel-home@corleco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi, I hope I've addressed this bug report to the right people...

In the sources for v2.4.7, as current yesterday (30/Jun/2001), the file

drivers/block/DAC960.c

refers to the sem member of a variable defined as being of type IO_Request_T

tracking this backwards, it maps to the structure struct request, defined in
the file

include/linux/blkdev.h

this struct does not contain a member sem, although it did in v2.4.3 (the
only other kernel sources I have),

this means that the DAC960.c file is broken in the 2.4.7 kernel.

Hope this helps.

p.s. Is 2.4.7 considered a stable release, or should I be looking at
something between 2.4.3 and 2.4.7?


Thanks in advance,


Nigel Bennington.

