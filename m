Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131175AbRCRJga>; Sun, 18 Mar 2001 04:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRCRJgL>; Sun, 18 Mar 2001 04:36:11 -0500
Received: from colorfullife.com ([216.156.138.34]:15119 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129166AbRCRJf6>;
	Sun, 18 Mar 2001 04:35:58 -0500
Message-ID: <001801c0af8e$bda30c10$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <engler@csl.Stanford.EDU>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] blocking w/ spinlock or interrupt's disabled
Date: Sun, 18 Mar 2001 10:35:00 +0100
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

>> enclosed are 163 potential bugs in 2.4.1 where blocking functions are
> > called with either interrupts disabled or a spin lock held. The
> > checker works by:
>
> Here's the file manifest. Apologies.
>
> drivers/atm/idt77105.c
> [...]
> drivers/char/cyclades.c

Unortunately schedule() with disabled interrupts is a feature, it's
needed for the old (deprecated and waiting for termination in 2.5)
sleep_on() functions.

Is it difficult to split it into "interrupts disabled" and "spin lock
held"?

--

    Manfred




