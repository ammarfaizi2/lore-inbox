Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQKFA1o>; Sun, 5 Nov 2000 19:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129117AbQKFA1d>; Sun, 5 Nov 2000 19:27:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2881 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129110AbQKFA1Z>; Sun, 5 Nov 2000 19:27:25 -0500
Subject: Re: rdtsc to mili secs?
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 6 Nov 2000 00:28:00 +0000 (GMT)
Cc: sushil@veritas.com (Sushil Agarwal), linux-kernel@vger.kernel.org
In-Reply-To: <20001106011000.A9787@athlon.random> from "Andrea Arcangeli" at Nov 06, 2000 01:10:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sa8o-0005jc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Nov 06, 2000 at 04:39:23AM +0530, Sushil Agarwal wrote:
> > Hi,
> >     According to the Intel Arch. Instruction set reference the
> > resolution of the "rdtsc" instruction is a clock cycle. How
> > do I convert this to mili seconds? 
> 
> fast_gettimeoffset_quotient, see do_fast_gettimeoffset().

Also remember that the TSC may not be available due to the chip era, chip bugs
or running SMP with non matched CPU clocks.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
