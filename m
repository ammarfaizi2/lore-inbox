Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbRGSQUO>; Thu, 19 Jul 2001 12:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264927AbRGSQTy>; Thu, 19 Jul 2001 12:19:54 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:56243
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S264877AbRGSQTq>; Thu, 19 Jul 2001 12:19:46 -0400
Message-ID: <00f101c1106e$a119e3c0$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.7-pre7 natsemi network driver random pauses
Date: Thu, 19 Jul 2001 09:19:47 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I upgraded two machines here from 2.4.7-pre6 to 2.4.7-pre7 yesterday
afternoon.

The first machine I upgraded, my workstation, is a 1GHz Athlon on a VIA
KT133 (not A) motherboard using a NetGear FA312TX network card. This machine
has always run Linux just fine. After this upgrade, telnetting to my other
Linux machine (not yet upgraded) and doing long directory listings (or tar
tzvf linux-2.4.0.tar) exhibits random (and long) pauses in the output.
Switching back to 2.4.7-pre6 makes the problem disappear. Note that at this
time only the _client_ end of this connection had been upgraded to -pre7.

I then upgraded my server as well, which is a 700 MHz Coppermine Celeron on
an SIS 630 motherboard, also using a NetGear FA312TX network card. Now this
machine exhibits the same symptoms, even when the telnet client is on a
Windows machine.

So, it appears that one of two things happened:

a) the natsemi driver had changes merged between -pre6 and -pre7 (not listed
in the changelogs) that had negative effects on my systems

b) something else in the kernel caused irq/softirq/whatever random latency
to appear

Any ideas where I should start looking?

