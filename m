Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312166AbSCUOQZ>; Thu, 21 Mar 2002 09:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312213AbSCUOQQ>; Thu, 21 Mar 2002 09:16:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51720 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312166AbSCUOQG>; Thu, 21 Mar 2002 09:16:06 -0500
Subject: Re: SMP IRQ management issues in 2.4.x
To: Fionn.Behrens@unix-ag.org (Fionn Behrens)
Date: Thu, 21 Mar 2002 14:31:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020321145711.47a90758.fionn@unix-ag.org> from "Fionn Behrens" at Mar 21, 2002 02:57:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o3bM-0005Jz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After changing from 2.2.18 to 2.4.17 recently, I noticed that after booting 
> 2.4 my interrupts were routed a lot less effectively than under 2.2

Can you post both 2.2 and 2.4 tables for comparison

> Needless to say that Harddrives connected to ide2 and ide3 (Promise) 
> constantly lose interrupts when used as long as X is running (nvidia), 
> bringing the system to crawl.

You should never be losing interrupts, even with everything on one IRQ line.
PCI interrupts are level trigger so don't get "lost" in the same way as ISA
ones did
