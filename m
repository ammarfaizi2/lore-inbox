Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSHXNYN>; Sat, 24 Aug 2002 09:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHXNYN>; Sat, 24 Aug 2002 09:24:13 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:48842 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316135AbSHXNYM>; Sat, 24 Aug 2002 09:24:12 -0400
Message-ID: <3D6789CF.B812272F@bigpond.com>
Date: Sat, 24 Aug 2002 23:27:43 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@redhat.com>, andre@linux-ide.org
Subject: Re: Linux 2.4.20-pre4-ac1
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>         Still some Promise glitches - need to review merge carefully

Got a wierd one here:
I use a Promise Ultra100TX2 with a PDC20268 chip, ATA100 IBM as only
drive on card, used as  boot device (OUTBOARD option to swap IDE order)
and CDROMs on each of the motherboard IDE ports, all run as IDE normally,
but if I want to write CDs I use the kernel option "hdh=ide-scsi".
All the pre2-acX and pre4-ac1 run as fine when all are IDE, but the SCSI
option causes a hang immediately after swap is enabled - the next item is
normally "Setting hard drive parameters for hda:", but you never see that.

While that may not be the Promise, the error on cables is - the Promise BIOS
is quite happy at running at 100MHz, and I get 20Mbyte/sec from a DOS boot
when using Norton to clone a disk to a disk (on the other Promise IDE port),
so the hardware is in spec.

The message "Warning: Primary channel requires an 80-pin cable for operation"
is (apart from being wrongly asserted as we know) incorrect is detail:
the plugs ARE 40-pin, the cable however is 80 conductor.
