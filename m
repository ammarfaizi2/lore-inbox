Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130334AbRBFUkn>; Tue, 6 Feb 2001 15:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130380AbRBFUkd>; Tue, 6 Feb 2001 15:40:33 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:16376 "EHLO
	hoggar.fisica.ufpr.br") by vger.kernel.org with ESMTP
	id <S130353AbRBFUk1>; Tue, 6 Feb 2001 15:40:27 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14976.24819.276892.26475@hoggar.fisica.ufpr.br>
Date: Tue, 6 Feb 2001 18:39:15 -0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: CPU error codes
In-Reply-To: <E14Nz6N-0002Vj-00@the-village.bc.nu>
In-Reply-To: <Pine.SOL.4.21.0101250913590.15936-100000@orange.csi.cam.ac.uk>
	<E14Nz6N-0002Vj-00@the-village.bc.nu>
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox (alan@lxorguk.ukuu.org.uk) wrote on 31 January 2001 15:23:
 >> > In the intel databook. Generally an MCE indicates hardware/power/cooling
 >> > issues
 >> 
 >> Doesn't an MCE also cover some hardware memory problems - parity/ECC
 >> issues etc?
 >
 >Parity/ECC on main memory is reported by the chipset and needs seperate
 >drivers or apps to handle this

Really? I thought it could be because of RAM. Here's the story:

The kernel is 2.2.18pre24.

I'm having VERY frequent of this (sometimes once a day, sometimes once
a week, sometimes twice a day, on a much used machine)

CPU 1: Machine Check Exception: 0000000000000004
Bank 4: b200000000040151<0>Kernel panic: CPU context corrupt

CPU 0: Machine Check Exception: 0000000000000004
Bank 4: b200000000040151<0>Kernel panic: CPU context corrupt

CPU 0: Machine Check Exception: 0000000000000004
Bank 4: b200000000040151<0>Kernel panic: CPU context corrupt

This is on an ASUS P2B-DS with two PIII 700MHz and 100MHz FSB, 1GB of
RAM. The mce happens with both processors (the above is just part of
it).

I've already changed the motherboard and processors, and it continued.
Then I changed the memory, and it continues. I also changed the
power supply just in case, to no avail...

It happens with PC100 and PC133 memory. I increased the memory latency
(the SPD says it's cl2, I put it 3T and 10T DRAM) but the problem
persists.

Since I changed the main board and processor, I think the most likely
cause is ram. It seems the x86 can access ram directly, so if there's
a NMI there what will happen?

This is happening on a CRITICAL machine, so any help will be much
appreciated.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
