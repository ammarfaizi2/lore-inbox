Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263254AbREaWap>; Thu, 31 May 2001 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbREaWaf>; Thu, 31 May 2001 18:30:35 -0400
Received: from zeus.kernel.org ([209.10.41.242]:16291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263254AbREaWaa>;
	Thu, 31 May 2001 18:30:30 -0400
Message-ID: <000901c0ea21$4383b7e0$1700000a@kamamura>
From: "Tomas Styblo" <trip@matrix.cyberspace.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 freezes on VIA KT133
Date: Fri, 1 Jun 2001 00:30:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the problem is caused by some DMA related bug in the VIA chipset
and/or in the Linux DMA-IDE VIA driver.
I finnaly get rid of the freezes, by simply compiling the kernel completely
without IDE-DMA support. Now hdparm shows disks do not use DMA and
the system is stable, as far as I can say now.

I've tested it VERY intensely last couple of days and
did not manage to freeze it. For 12 hours a lot of concurrent processes
 copied gigs of data all over the disks, calculated
CPU intensive crypto etc, the system hasn't frozen. For debugging purposes
I also tried to downgrade to 2.2.19 with IDE-DMA activated.
It crashed. So it really seems DMA is the problem here.

Maybe I did not describe the freezes accurately in my first post. After the
freeze, the screen always went black,
and the system was dead - did not respond to pings, keyboard etc. It was
neccessary to hard reset it.

Tomas


