Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUCHKjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 05:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUCHKj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 05:39:29 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47240 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262454AbUCHKjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 05:39:25 -0500
Date: Mon, 08 Mar 2004 19:42:53 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
In-reply-to: <3ACA40606221794F80A5670F0AF15F8401B1A019@PDSMSX403.ccr.corp.intel.com>
To: "Liu, Benjamin" <benjamin.liu@intel.com>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-id: <MDEEKOKJPMPMKGHIFAMAAEDEDGAA.kaneshige.kenji@jp.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain;	charset="gb2312"
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a matter of fact, I don't have special reason to leave RTEs unmasked in
iosapic_register_intr(), iosapic_register_platform_intr(),
iosapic_override_isa_irq().
I think it is better that interrupts are unmasked by individual device
drivers, but
there are some exceptions. For example, PMI and INIT don't need device
drivers.
So I think more investigation is needed about them.

Regards,
Kenji Kaneshige

> -----Original Message-----
> From: Liu, Benjamin [mailto:benjamin.liu@intel.com]
> Sent: Monday, March 08, 2004 6:15 PM
> To: Kenji Kaneshige; linux-ia64@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] fix PCI interrupt setting for ia64
>
>
> Thank you for the information, Kenji. But is there any reason to
> leave it unmasked in iosapic_register_intr(),
> iosapic_register_platform_intr(), iosapic_override_isa_irq(),
> given the fact that they would be unmasked finally in individual
> device drivers?

