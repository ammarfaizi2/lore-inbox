Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271735AbRHUQYM>; Tue, 21 Aug 2001 12:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRHUQYB>; Tue, 21 Aug 2001 12:24:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4100 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271735AbRHUQXx>; Tue, 21 Aug 2001 12:23:53 -0400
Subject: Re: Kernel Startup Delay
To: mcuss@cdlsystems.com
Date: Tue, 21 Aug 2001 17:26:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Mark Cuss" at Aug 21, 2001 10:11:12 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZEMl-0008EK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to have a delayed spin up as to not bake the power supply.  These two drives
> will contain a striping RAID.  I am concerned that the kernel will load off
> of the other drives and attempt to start this RAID before the disks have
> even spun up - is there a way to have the kernel delay its startup for a
> certain number of seconds while all the drives spin up?

The kernel scsi code issues test-unit-ready commands and will (should 8)) do
the right things and wait for the drives to spin up. 

Alan
