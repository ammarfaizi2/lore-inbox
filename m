Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBDQqS>; Sun, 4 Feb 2001 11:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBDQqI>; Sun, 4 Feb 2001 11:46:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27407 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129057AbRBDQpz>; Sun, 4 Feb 2001 11:45:55 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
To: bsuparna@in.ibm.com
Date: Sun, 4 Feb 2001 16:46:39 +0000 (GMT)
Cc: sct@redhat.com (Stephen C. Tweedie), linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hch@caldera.de (Christoph Hellwig), ak@suse.de (Andi Kleen)
In-Reply-To: <CA2569E9.004A4E23.00@d73mta05.au.ibm.com> from "bsuparna@in.ibm.com" at Feb 04, 2001 06:54:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PSJF-0001qi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It appears that we are coming across 2 kinds of requirements for kiobuf
> vectors - and quite a bit of debate centering around that.
> 
> 1. In the block device i/o world, where large i/os may be involved, we'd
> 2. In the networking world, we deal with smaller fragments (for protocol

Its probably worth commenting at this point that the I2O message passing layers
do indeed have both #1 and #2 type descriptor chains to optimise performance
for different tasks. We arent the only people to hit this.

I2O supports 
	offset, pagelist, length

where the middle pages in the list are entirely copied

And sets of
	addr, len

tuples.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
