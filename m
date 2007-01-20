Return-Path: <linux-kernel-owner+w=401wt.eu-S965357AbXATTe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbXATTe6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 14:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbXATTe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 14:34:58 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:38526 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965357AbXATTe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 14:34:57 -0500
Message-ID: <023401c73cca$05bc5f00$84163e05@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-pci@atrey.karlin.mff.cuni.cz>
Cc: "Auke Kok" <auke-jan.h.kok@intel.com>, <linux-kernel@vger.kernel.org>
References: <20070117190448.A20184@mail.kroptech.com> <45AEB79B.2010205@intel.com> <00d701c73c1f$b2bb2390$84163e05@kroptech.com> <45B1562C.8070503@intel.com> <011101c73c29$9f6f5db0$84163e05@kroptech.com> <45B16491.7030207@intel.com>
Subject: MSI failure on nForce 430 (WAS: intel 82571EB gigabit fails to see link on 2.6.20-rc5 in-tree e1000 driver (regression))
Date: Sat, 20 Jan 2007 14:34:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc: list trimmed and thread moved to linux-pci)

I have a PCI-E e1000 card that does not see interrupts on 2.6.20-rc5 
unless CONFIG_PCI_MSI is disabled. An e1000 maintainer indicated that 
the PHY state is correct, it's just that the interrupt is not getting 
thru to the kernel. Interestingly, on 2.6.19 PHY interrupts get thru ok 
with MSI enabled (link status responds appropriately) but packet tx 
fails with timeout errors, implying that perhaps MAC interrupts are not 
arriving.

I've attached the contents dmesg, 'lspci -vvv', and 'cat 
/proc/interrupts' from 2.6.20-rc5.

This is an nForce 430 based chipset on a Dell E521 which has had 
interrupt routing issues before. Prior to 2.6.19 it had to be booted 
with 'noapic' in order to come up at all. It also had USB lockup 
problems until I applied the latest BIOS update (v1.1.4). So a BIOS 
interrupt routing bug with MSI is not out of the question.

I'm happy to gather more data or run tests...

--Adam

