Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSGVKzM>; Mon, 22 Jul 2002 06:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSGVKzM>; Mon, 22 Jul 2002 06:55:12 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:20213 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S316709AbSGVKzI>; Mon, 22 Jul 2002 06:55:08 -0400
From: "Ramit Bhalla" <ramit.bhalla@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: Compiling bug - broken compile
Date: Mon, 22 Jul 2002 16:30:28 +0530
Message-ID: <KMELKICNHILNIJDACGAIIECCCKAA.ramit.bhalla@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-577ddca4-5909-458b-9dad-01259e9131be"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-577ddca4-5909-458b-9dad-01259e9131be
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I'm using the 2.4.7 Kernel.
I'm trying to make this work without any BIOS support so I configure the
kernel to use "Direct" PCI calls through the menuconfig scripts. I also turn
off PCI Hot Pluggable support.

The build will break during "make zImage" at the end during the link phase.
It says it cannot find the symbol pcibios_set_irq_routing and
pcibios_get_irq_routing_table.

If I configure PCI to use BIOS calls, it work fine.

I noticed the problem lies in the file arch/i386/kernel/i386_ksyms.c
In that file EXPORT_SYMBOL(pcibios_set_irq_routing) is placed under #ifdef
CONFIG_PCI. If I add another clause #ifdef CONFIG_PCI_BIOS (which I presume
from the Config.in file is the definition for PCI Bios calls instead of
Direct calls), then it works fine.

Regards,
Ramit Bhalla.


Wipro Technologies,
No. 8
7th Main, 1st Block,
Koramangala,
Bangalore.
India - 560034.

E-mail - ramit.bhalla@wipro.com
Ph. - 91-80-5530035 ext 1082
Fax - 91-80-5530086

www.wipro.com


------=_NextPartTM-000-577ddca4-5909-458b-9dad-01259e9131be
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-577ddca4-5909-458b-9dad-01259e9131be--
