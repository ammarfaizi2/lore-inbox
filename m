Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSGEApO>; Thu, 4 Jul 2002 20:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSGEApO>; Thu, 4 Jul 2002 20:45:14 -0400
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:6663 "EHLO mail1.wi.rr.com")
	by vger.kernel.org with ESMTP id <S314602AbSGEApM>;
	Thu, 4 Jul 2002 20:45:12 -0400
Message-ID: <001301c223bd$d738a500$8a981d41@wi.rr.com>
From: "Ted Kaminski" <mouschi@wi.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Lack of support? IDE interface on SB16 ISAPNP
Date: Thu, 4 Jul 2002 19:49:38 -0500
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

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&safe=off&threadm
=linux.kernel.20011203171651.GA2149%40man.beta.es&rnum=1&prev=/groups%3Fhl%3
Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26safe%3Doff%26selm%3Dlinux.kernel.200
11203171651.GA2149%2540man.beta.es

long link... but my system doesn't have a PnP BIOS, so it seems that i can't
do that method. !#@

Please CC responces to my address, as I'm not about to swamp my inbox just
for this problem. :)

Ted Kaminski

