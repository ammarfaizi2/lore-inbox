Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131535AbRCNUmI>; Wed, 14 Mar 2001 15:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131543AbRCNUl6>; Wed, 14 Mar 2001 15:41:58 -0500
Received: from colorfullife.com ([216.156.138.34]:29192 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131535AbRCNUln>;
	Wed, 14 Mar 2001 15:41:43 -0500
Message-ID: <000d01c0acc7$1e8388e0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <pmhahn@titan.lahn.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 8139too
Date: Wed, 14 Mar 2001 21:41:06 +0100
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

> Hello LKML!

> i686 2.4.2 UP+kdb+lm_sensors+pcmcia
> after APM laptop suspend to disk
> 8139too is build-in, not pcmcia
> I often get hangups after suspend-to-disk if I'm connected to a
hub/switch.
> This is the first oops I've actually seen and copied it by hand:

I remember a similar bug report.

Was the nic connected or not?
It seems that rtl8139_resume() unconditionally enables the nic, even if
it wasn't open()'ed. Then an interrupt arrives and crashes because some
memory structures were not allocated.



--

    Manfred


