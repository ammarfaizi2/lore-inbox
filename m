Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130746AbQKGFBL>; Tue, 7 Nov 2000 00:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbQKGFBC>; Tue, 7 Nov 2000 00:01:02 -0500
Received: from mail01.syd.optusnet.com.au ([203.2.75.104]:1232 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S130746AbQKGFAu>; Tue, 7 Nov 2000 00:00:50 -0500
Message-ID: <3A078C65.B3C146EC@mira.net>
Date: Tue, 07 Nov 2000 16:00:21 +1100
From: Antony Suter <antony@mira.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0a8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
In-Reply-To: <20001106011000.A9787@athlon.random> <E13sa8o-0005jc-00@the-village.bc.nu> <20001106091723.A516@linuxcare.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> > > fast_gettimeoffset_quotient, see do_fast_gettimeoffset().
> >
> > Also remember that the TSC may not be available due to the chip era, chip
> > bugs or running SMP with non matched CPU clocks.
> 
> When I boot my thinkpad 600e off battery and then change to AC power,
> gettimeofday has a nasty habit of going backwards. Stephen Rothwell
> tells me it is one of these machines in which the cycle counter
> slows down when power is removed.
> 
> This means our offset calculations in do_fast_gettimeoffset are way off
> and taking a reading just before a timer tick and just after results in
> a negative interval. Perhaps we should disable tsc based gettimeofday
> for these type of machines.

This issue, and all related issues, need to be taken care of for all
speed
changing CPUs from Intel, AMD and Transmeta. Is the answer of "howto
write
userland programs correctly with a speed changing cpu" in a FAQ
somewhere?

--
- Antony Suter  (antony@mira.net)  "Examiner"  openpgp:71ADFC87
- "And how do you store the nuclear equivalent of the universal
- solvent?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
