Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265870AbRGPTja>; Mon, 16 Jul 2001 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbRGPTjU>; Mon, 16 Jul 2001 15:39:20 -0400
Received: from f86.law7.hotmail.com ([216.33.237.86]:11283 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265870AbRGPTjJ>;
	Mon, 16 Jul 2001 15:39:09 -0400
X-Originating-IP: [198.252.187.206]
From: "daniel sheltraw" <l5gibson@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PCI and interrupts
Date: Mon, 16 Jul 2001 14:39:07 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F86vW5seWpRXg1MlIra00019133@hotmail.com>
X-OriginalArrivalTime: 16 Jul 2001 19:39:07.0411 (UTC) FILETIME=[FA52F630:01C10E2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel developers

I am asking this question here because of a lack of results with
my post to the linux-parport list. I hope you don't mind.

I have an Intek21 PCI parallel port (PCI vendor id=14DB,
device id=2120) which is advertised as supporting interrupt
sharing. I am writing a custom driver for this card in place
of a previously working custom driver for an ISA parallel port.
The problem is I can not get hardware interrupts to work.

The /proc/pci file reports that the card is using IRQ 11
as does the pci_dev struct. Also pci_read_config_byte tells me
that INTA is being used for this card. I enable interrupts
as with the former ISA device but I get no interrupts (my
ISR is never called upon level triggering pin 10).

I have also tried changing modes in using the ECR register
at base + 0x402 but still no interrupts.

Does anyone know what might be going on with this card? Does
anyone have similar experience with this card?

Thanks once again,
Daniel
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

