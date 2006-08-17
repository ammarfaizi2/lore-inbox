Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWHQAP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWHQAP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWHQAP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:15:29 -0400
Received: from smtp1.libero.it ([193.70.192.51]:43488 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S932147AbWHQAP2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:15:28 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Subject: R: How to avoid serial port buffer overruns?
Date: Thu, 17 Aug 2006 02:15:29 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDMEBBFNAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1155770899.8796.21.camel@mindpipe>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, thanks.  FWIW here is the serial board we are using:
> 
> http://www.moschip.com/html/MCS9845.html
> 
> The hardware guy says "The mn9845cv, have in default 2 serial ports and
> one ISA bus, where we have connected the tl16c554, quad serial port."
> 
> Hopefully Ingo's latency tracer can tell me what is holding off
> interrupts.

That may be an interrupt-sharing issue: quad port often use at most two irq lines and, FWIK, ISA irqs are edge-triggered, not level-triggered. Are you tring to use two MIDI ports at the same time?

Giampaolo

> 
> Lee
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

