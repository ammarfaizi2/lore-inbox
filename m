Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289823AbSBKPlD>; Mon, 11 Feb 2002 10:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289829AbSBKPkx>; Mon, 11 Feb 2002 10:40:53 -0500
Received: from www.microgate.com ([216.30.46.105]:63496 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S289823AbSBKPkg>; Mon, 11 Feb 2002 10:40:36 -0500
Message-ID: <001701c1b312$24448ca0$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <reddog83@chartermi.net>, <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <auto-000058815980@front2.chartermi.net>
Subject: Re: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
Date: Mon, 11 Feb 2002 09:38:23 -0600
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

> This is a temp fix for thje synclink.c file in drivers/char it work's for
me
> so DJ will you please apply this patch.
> Thank you Victor Torres.
> All it does it removes the #error please convert me to
> Documentation/DMA-mapping.txt
> it compiles and work's great for me.
> Please apply

There is nothing in the DMA-mapping.txt that
applies to the PCI version of the synclink adapter
(which does not do DMA to/from system memory).

The ISA version of the synclink adapter does do
ISA DMA bus master transfers. After reading
DMA-mapping.txt twice it is unclear what changes
need to be applied. The documentation seems to imply
that ISA devices need to make some pci_xxx calls.
I'm not sure how this works when there is no PCI bus.

For now, removing the #error line should work fine
for the PCI adapter and probably for the ISA as well.

I will look at this again as time allows.

I usually wait 6-12 months after the new development
kernel opens before attempting to sync my drivers
to the latest changes. This avoids most of the eat-your-file-system
phase, prevents wasting time chasing after a rapidly changing API,
and still leaves another 12 months for tweaking.

Paul Fulghum, paulkf@microgate.com
Microgate Corporation, www.microgate.com

