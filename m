Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135214AbRDRQHR>; Wed, 18 Apr 2001 12:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135215AbRDRQHH>; Wed, 18 Apr 2001 12:07:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13831 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135214AbRDRQGy>; Wed, 18 Apr 2001 12:06:54 -0400
Subject: Re: AHA-154X/1535 not recognized any more
To: markus.schaber@student.uni-ulm.de (Markus Schaber)
Date: Wed, 18 Apr 2001 17:08:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        markus.schaber@student.uni-ulm.de (Markus Schaber),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.SOL.4.33.0104181600230.14689-100000@lyra.rz.uni-ulm.de> from "Markus Schaber" at Apr 18, 2001 05:25:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14puVG-00053d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, as this device is already configured by the bios, I just tried
> to load it giving the right IO port, and got the following message:

The kernel PnP will deconfigure it

> Board 1 has Identity 08 0f 6d b9 45 42 15 90 04:  ADP1542 Serial No 258849093 [checksum 08]
> pnptext:60 -- Fatal - IO range check attempted while device activated
> pnptext:60 -- Fatal - Error occurred executing request '<IORESCHECK> ' --- further action aborted

It thinks it hasnt got a good location for it. You could try making it nocheck
if it cant find I/O space for it but thats not ideal.

The module parameters are

aha1542=io, irq, busff, dmaspeed


