Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313322AbSDPMaP>; Tue, 16 Apr 2002 08:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313338AbSDPMaO>; Tue, 16 Apr 2002 08:30:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49026 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313322AbSDPMaN>; Tue, 16 Apr 2002 08:30:13 -0400
Date: Tue, 16 Apr 2002 08:31:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Olaf Fraczyk <olaf@navi.pl>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <20020416081453.GP21206@holomorphy.com>
Message-ID: <Pine.LNX.3.95.1020416082145.18369A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, William Lee Irwin III wrote:

> On Tue, Apr 16, 2002 at 09:47:48AM +0200, Olaf Fraczyk wrote:
> > Hi,
> > I would like to know why exactly this value was choosen.
> > Is it safe to change it to eg. 1024? Will it break anything?
> > What else should I change to get it working:
> > CLOCKS_PER_SEC?
> > Please CC me.
> > Regards,
> > Olaf Fraczyk
> 
> I tried a few times running with HZ == 1024 for some testing (or I guess
> just to see what happened). I didn't see any problems, even without the
> obscure CLOCKS_PER_SEC ELF business.
> 
> 
> Cheers,
> Bill
> -

On Version 2.3.17, with a 600 MHz SMP Pentium, I set HZ to 1024 and
recompiled everything. There was no apparent difference in performance
or "feel".

Note that HZ represents the rate at which a CPU-bound process may
get the CPU taken away. Real-world tasks are more likely to be
doing I/O, thus surrendering the CPU, before this relatively long
time-slice expires. I don't think you will find any difference in
performance with real-world tasks. FYI, the Alpha uses 1024 simply
because the timer-chip can't divide down to 100 Hz.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

