Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbRAaS6I>; Wed, 31 Jan 2001 13:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131049AbRAaS5u>; Wed, 31 Jan 2001 13:57:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38665 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131772AbRAaS5i>; Wed, 31 Jan 2001 13:57:38 -0500
Subject: Re: [PATCH] make sym53c8xx.c and ncr53c8xx.c call pci_enable_device
To: groudier@club-internet.fr (Gérard Roudier)
Date: Wed, 31 Jan 2001 18:58:04 +0000 (GMT)
Cc: rasmus@jaquet.dk (Rasmus Andersen), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101292235170.2036-100000@linux.local> from "Gérard Roudier" at Jan 29, 2001 10:50:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O2SF-0002tb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the pci_enable_device() thing is to be added to the drivers, it must
> preferently be placed after the checking against RAID attachement.

You cant check the signature until the device has been enabled. Maybe you
could poke the LSI guys and find out how windows PnP stuff handles this.

I think the proposed change is ok because if the board is enabled then the 
enabling code won't touch it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
