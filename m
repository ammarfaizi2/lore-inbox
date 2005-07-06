Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVGFT6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVGFT6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVGFT4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:00 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:1542 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S261919AbVGFPdQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:33:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Date: Wed, 6 Jul 2005 10:33:11 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C30@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Thread-Index: AcWCO/VUbzRVTj46RxOx/znfEPmsZAAAVngg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Alexander Fieroch" <fieroch@web.de>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <bzolnier@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <axboe@suse.de>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Alexey Dobriyan" <adobriyan@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 06 Jul 2005 15:33:15.0276 (UTC) FILETIME=[06C10CC0:01C58240]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hm, I did not get any answer to my last report last week. 
> Didn't you get it?
> 
> There are still the same errors in kernel 2.6.13rc2 as in 
> 2.6.13rc1. So I've attached an up to date syslog and the last 
> error report below.
> 
Hi Alexander,
To me, it looks like both IDE channels get wrong IRQ. Didn't you
verified previously that when you go without IDE the system boots up OK?
They get some interrupts because when IRQ 201 occurs triggered by USB,
the handler for ide runs also, since it is shared with both ide and
uhci. (Can you also attach output for "cat /proc/interrupts" please).
> 
>  >Then I would try forth-feeding IRQ 14 to the IDE.
> 
> I don't know how to do that.

I was going to put some code together for you over the weekend, but got
caught up in other things, sorry. The idea was to forcibly assign IRQ 14
for ide0 and IRQ 15 for ide1 in the ide driver, setup-pci.c (just for
diagnostics and proof of concept so to speak) and see if devices become
sane.
I will try tweaking it tonight. I need to make sure it works on my
system first and if it does I will send you the code. 
Thanks,
--Natalie

> Regards,
> Alexander
> 
> 
> 
