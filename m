Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALA3V>; Thu, 11 Jan 2001 19:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbRALA3L>; Thu, 11 Jan 2001 19:29:11 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:30981 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129742AbRALA26>;
	Thu, 11 Jan 2001 19:28:58 -0500
Date: Fri, 12 Jan 2001 01:28:39 +0100
From: Frank de Lange <frank@unternet.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112012839.A11091@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au> <20010111201819.B3269@unternet.org> <3A5E0849.EB428D70@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5E0849.EB428D70@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jan 11, 2001 at 02:23:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 02:23:53PM -0500, Jeff Garzik wrote:
> Just out of curiosity, if you boot a Linux 2.4.0 kernel with the
> "noapic" command line option, does behavior improve?

For the curious, here's a summary of some tests I did:

apic, 2 cpu's, no smp affinity -> network hangs under load
apic, maxcpus=1, no smp affinity -> network hangs under load
apic, 2 cpu's, smp affinity for all irq's on CPU1 -> network hangs under load
noapic, 2 cpu's, no smp affinity -> NO HANG, WORKSFORME

Quick and dirty conclusion: as soon as the apic comes in to play, things get
messy...

ps. load == 2 simultaneous nfs cp -rd <big_directory> sessions and streaming
esd audio over the network

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
