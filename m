Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLXLl7>; Sun, 24 Dec 2000 06:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbQLXLlu>; Sun, 24 Dec 2000 06:41:50 -0500
Received: from colorfullife.com ([216.156.138.34]:44813 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129585AbQLXLlp>;
	Sun, 24 Dec 2000 06:41:45 -0500
Message-ID: <3A45DADF.1B87B81E@colorfullife.com>
Date: Sun, 24 Dec 2000 12:15:43 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Q: natsemi.c spinlocks
In-Reply-To: <3A44E4D0.E8F177B9@colorfullife.com> <3A45493C.3C75EC1A@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> start_tx()
> {

Yes, I overlooked start_tx.

Hmm. start_tx also assumes that the cpu commits writes in order, I'm
sure the driver is unreliable on RISC cpus.

Perhaps the driver should use pci_alloc_consistent and pci_map_single?

--
  Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
