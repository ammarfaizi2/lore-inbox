Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129577AbRCANMx>; Thu, 1 Mar 2001 08:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbRCANMo>; Thu, 1 Mar 2001 08:12:44 -0500
Received: from chiara.elte.hu ([157.181.150.200]:6918 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129577AbRCANM2>;
	Thu, 1 Mar 2001 08:12:28 -0500
Date: Thu, 1 Mar 2001 14:11:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2ac7
In-Reply-To: <Pine.GSO.3.96.1010301131145.15979D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.30.0103011409100.2631-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Mar 2001, Maciej W. Rozycki wrote:

> > o	Handle broken PIV MP tables with a NULL ioapic
>
>  That's not a right fix. [...]

Maciej, it *is* the right fix. These are UP systems not SMP systems, but
if we boot an SMP kernel then we find a (largely bogus) mptable during the
scan.

Any BIOS of a real SMP box that is so blatantly broken to specify a NULL
ioapic in the mptable deserves SMP mode being disabled altogether.

lets not overcomplicate things.

	Ingo

