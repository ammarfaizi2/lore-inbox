Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUCKAan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUCKAan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:30:43 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54201 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262914AbUCKAaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:30:39 -0500
Date: Thu, 11 Mar 2004 09:34:06 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
In-reply-to: <16463.30226.948230.439549@napali.hpl.hp.com>
To: davidm@hpl.hp.com, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <MDEEKOKJPMPMKGHIFAMAEELHDGAA.kaneshige.kenji@jp.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain;	charset="us-ascii"
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry that the report falls behind. I wanted to check out by using
real device driver which uses a probe_irq_on(), but I don't have appropriate
environment now.

Though I didn't check out on a real machine yet, I believe my patch doesn't
have any influence on probe_irq_on() because current probe_irq_on() calls
startup callback to unmask the RTEs as you said before.

Regards,
Kenji Kaneshige

> -----Original Message-----
> From: linux-ia64-owner@vger.kernel.org
> [mailto:linux-ia64-owner@vger.kernel.org]On Behalf Of David Mosberger
> Sent: Thursday, March 11, 2004 5:10 AM
> To: Kenji Kaneshige
> Cc: linux-ia64@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] fix PCI interrupt setting for ia64
>
>
> Kenji,
>
> Sorry, I lost track of the status of this patch.  Has it been checked
> out OK with respect to interrupt probing?
>
> 	--david
>
> >>>>> On Mon, 08 Mar 2004 11:49:10 +0900, Kenji Kaneshige
> <kaneshige.kenji@jp.fujitsu.com> said:
>
>   Kenji> Hi, In ia64 kernel, IOSAPIC's RTEs for PCI interrupts are
>   Kenji> unmasked at the boot time before installing device drivers. I
>   Kenji> think it is very dangerous.  If some PCI devices without
>   Kenji> device driver generate interrupts, interrupts are generated
>   Kenji> repeatedly because these interrupt requests are never
>   Kenji> cleared. I think RTEs for PCI interrupts should be unmasked
>   Kenji> by device driver.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

