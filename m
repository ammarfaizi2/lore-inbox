Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSCUSva>; Thu, 21 Mar 2002 13:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312448AbSCUSvV>; Thu, 21 Mar 2002 13:51:21 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:55218 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S312447AbSCUSvH>;
	Thu, 21 Mar 2002 13:51:07 -0500
Date: Thu, 21 Mar 2002 19:53:58 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.GSO.3.96.1020320121631.13532A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0203211951350.9609-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maciej,

> In short some code like:
>
> timer_ack = !(cpu_has_tsc &&
> 	      APIC_INTEGRATED(GET_APIC_VERSION(apic_read(APIC_LVR))));
>
> should suffice as the condition to disable the code in
> do_timer_interrupt() for systems using the through-8259A mode.  There is
> no need to keep it enabled unconditionally and I/O cycles are quite
> expensive.  The following patch implements it.  Please test it.  It should
> cure your problems as a side effect, but that does not mean the BIOS isn't
> to be fixed.

please consider submitting this patch to Linus and Marcelo.
Perhaps it needs testing by some more people,
but I think it's the right thing to do.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





