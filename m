Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSGHSQy>; Mon, 8 Jul 2002 14:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSGHSQx>; Mon, 8 Jul 2002 14:16:53 -0400
Received: from fe5.rdc-kc.rr.com ([24.94.163.52]:30732 "EHLO mail5.wi.rr.com")
	by vger.kernel.org with ESMTP id <S317025AbSGHSQv>;
	Mon, 8 Jul 2002 14:16:51 -0400
Message-ID: <000d01c226ac$436ad360$8a981d41@wi.rr.com>
From: "Ted Kaminski" <mouschi@wi.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: ISAPNP SB16 card with IDE interface
Date: Mon, 8 Jul 2002 13:21:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC to my address)

I've been trying for weeks now and seem to have exhausted every resource i
can find, except this one...

I trying to get a 486 system booting to a 2.4.18 kernel to recognize a CDROM
(a 4x one, model CR-581J, creative labs) connected to a ISAPNP Sound Blaster
16 card with an IDE interface on it. (99% sure actual IDE interface, not one
of those old non-everything ones, SB is model CT2950)

The system is completely functional running Windows 95, so the hardware
works.  I've also pretty much ruled out hardware conflicts because I've
stripped it down to the bare bones...

I can't get all the boot messages here (i have to retype them), but the
relevant portion is this:

ide3: Creative SB16 PnP IDE interface
...
hdg: probing with STATUS(0x00) instead of ALTSTATUS(0x80)
hdg: MATSHITA CR 581, ATAPI CD/DVD-Rom drive
...
ide3 at 0x168-1x16f,0x36e on irq 10
...(displays CHS stuff for HD)...
hdg: irq timeout: status=0x51 { DriveReady SeekComplete Error }
hdg: irq timeout: error=0x60
hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdg: ATAPI reset complete

and it repeats from the irq timeout again before it end_request's

I'm somewhat perplexed, as I have not been able to find a solution to
this... although i did find this

http://groups.google.com/groups?threadm=linux.kernel.20011203171651.GA2149%4
0man.beta.es&rnum=1

but my system doesn't have a PnP BIOS, so it seems that i can't
do that method. !#@

Ted Kaminski


