Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbQKFR1Z>; Mon, 6 Nov 2000 12:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQKFR1P>; Mon, 6 Nov 2000 12:27:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61780 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129243AbQKFR1D>; Mon, 6 Nov 2000 12:27:03 -0500
Subject: Re: rdtsc to mili secs?
To: anton@linuxcare.com (Anton Blanchard)
Date: Mon, 6 Nov 2000 17:27:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org
In-Reply-To: <20001106091723.A516@linuxcare.com> from "Anton Blanchard" at Nov 06, 2000 09:17:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sq3d-0006QT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This means our offset calculations in do_fast_gettimeoffset are way off
> and taking a reading just before a timer tick and just after results in
> a negative interval. Perhaps we should disable tsc based gettimeofday
> for these type of machines.

I seem to remember we have a 'notsc' option. Figuring out which boxes are
infected with the problem may be trickier. We really need to be able to 
read the current CPU clock rate off whatever generates the clocks when we
do a udelay

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
