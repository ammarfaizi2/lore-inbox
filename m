Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbRECUdE>; Thu, 3 May 2001 16:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRECUcz>; Thu, 3 May 2001 16:32:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14601 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135216AbRECUcr>; Thu, 3 May 2001 16:32:47 -0400
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
To: brownfld@irridia.com (Ken Brownfield)
Date: Thu, 3 May 2001 21:36:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105031951.OAA09136@asooo.flowerfire.com> from "Ken Brownfield" at May 03, 2001 12:51:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vPq2-0006B1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just wanted to throw in my two cents and say that there appear to be 
> widespread issues with the APIC code in 2.4.x.  I'm tempted to stick my 
> neck out and say that it might be best to disable SMP IOAPIC by default 
> until APIC can be massaged, at least for a wider variety of hardware.

I would disagree

There are five cases I am seeing

1.	Serverworks total APIC hose ups.
	Fix: remove OSB4 or use -ac tree

2.	440BX and similar boards losing interrupts on some drivers
	Fix: use -ac

3.	APIC errors notably checksum errors. 
	Fix: buy properly manufactured hardware

4.	Hangs on boot with the CUV4XD and a couple of other boards.
	Still a mystery

5.	Incorrect PCI IRQ routing
	Fix: Mostly get a board with a correct BIOS. There are a couple of 
	cases people are looking at - some are fixed in 2.4.4 and -ac
	where magic IRQ lines are not visible directly in PCI space


