Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270913AbVBEVYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270913AbVBEVYe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270119AbVBEVYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:24:34 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:3089 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270913AbVBEVYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:24:23 -0500
To: Marco Rogantini <marco.rogantini@supsi.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 (8139too) net problem in linux 2.6.10
References: <Pine.LNX.4.62.0502051818370.4821@rost.dti.supsi.ch>
	<87wttmg77p.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.62.0502052052560.6832@rost.dti.supsi.ch>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Feb 2005 06:24:13 +0900
In-Reply-To: <Pine.LNX.4.62.0502052052560.6832@rost.dti.supsi.ch> (Marco
 Rogantini's message of "Sat, 5 Feb 2005 21:03:56 +0100 (CET)")
Message-ID: <87y8e266pu.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Rogantini <marco.rogantini@supsi.ch> writes:

> I'm using a TI-PCI4510 on a Dell Inspiron 8500.
> Kernel is linux-2.6.11-rc3 and your patch is already included there.
>
> I tried to load the module with 'disable_clkrun' option but nothing has
> changed... :-(

Umm... Bit strange...

I couldn't find the PCI4510 in yenta_table. Did you add the PCI4510 to
yenta_table? Could you send "lspci -n" (what vendor-id and device-id)?

> dmesg extract:
>
> Linux Kernel Card Services
>    options:  [pci] [cardbus] [pm]
> PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
> ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
> Yenta: CardBus bridge found at 0000:02:01.0 [1028:013e]
> Yenta: ISA IRQ mask 0x04d8, PCI irq 11
> Socket status: 30000020

The disable_clkrun code didn't run. If it was running, you should see
the following message.

"Yenta: Disabling CLKRUN feature"
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
