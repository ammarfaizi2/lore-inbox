Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRAUOjC>; Sun, 21 Jan 2001 09:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131258AbRAUOil>; Sun, 21 Jan 2001 09:38:41 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:32773 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130006AbRAUOii>;
	Sun, 21 Jan 2001 09:38:38 -0500
Message-ID: <3A6AF45D.9BEC7FFC@mandrakesoft.com>
Date: Sun, 21 Jan 2001 09:38:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred <manfred@colorfullife.com>
CC: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Q: natsemi.c spinlocks
In-Reply-To: <3A44E4D0.E8F177B9@colorfullife.com> <3A45493C.3C75EC1A@uow.edu.au> <3A45DADF.1B87B81E@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred wrote:
> 
> Andrew Morton wrote:
> >
> > start_tx()
> > {
> 
> Yes, I overlooked start_tx.
> 
> Hmm. start_tx also assumes that the cpu commits writes in order, I'm
> sure the driver is unreliable on RISC cpus.
> 
> Perhaps the driver should use pci_alloc_consistent and pci_map_single?

Eventually, all drivers which use PCI DMA of some sort -should- use
pci_alloc_consistent, etc.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
