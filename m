Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264994AbRFUOot>; Thu, 21 Jun 2001 10:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264993AbRFUOoj>; Thu, 21 Jun 2001 10:44:39 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:64657 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S264991AbRFUOoa>;
	Thu, 21 Jun 2001 10:44:30 -0400
Date: Thu, 21 Jun 2001 16:44:20 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.x deadlocking
Message-ID: <Pine.LNX.4.30.0106211638380.26985-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My collegue has a Lifetec 9888 laptop (PII) that suffers from IRQ
deadlocking :

His TI PCMCIA bridge locates itself on IRQ 12, and so does his mouse.
System boots fine, but as soon as he types anything or moves his mouse,
the keyboard locks.
2.2.x doesn't seem to allocate a IRQ to the bridge, so no problems there.

Remote access is still possible, and the system works fine excepts that
his keyboard / mouse are dead :)
Not starting GPM prevents the lock.

Is there any way to tell the PCI subsystem to leave IRQ 12 alone ? The
pci_setup() routine seems to be a pretty noop.



	Regards,

		Igmar Palsenberg

-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

