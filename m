Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311416AbSCMWg0>; Wed, 13 Mar 2002 17:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311409AbSCMWgP>; Wed, 13 Mar 2002 17:36:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20488 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311379AbSCMWgK>; Wed, 13 Mar 2002 17:36:10 -0500
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
To: davidsen@tmr.com (Bill Davidsen)
Date: Wed, 13 Mar 2002 22:51:46 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.LNX.3.96.1020313171800.5467C-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Mar 13, 2002 05:22:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lHb0-0007go-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If several processors are idle, say CPU0 busy and CPU[123] idle, does it
> preferentially use a "CPU" on another chip? And does that make any
> difference? It's not clear to me if the HT CPUs share cache or not, they
> obviously share bandwidth from L2 to RAM.

The scheduler changes try to schedule onto a new true CPU rather than a
sibling first. Typically you only gain 10-30% via the HT feature so you
want to load the "real" CPU's properly. 

> I'm looking at P4 chips and boards, my 2Q02 budget has some $$ for a
> system. I also will be getting some laptops 3Q02, does the new P4-M mobile
> chip by any chance have HT? If so a good reason to go Intel, assuming that
> either the BIOS or Linux can get it to use the feature ;-)

At the moment HT is Xeon only. Linux can do the right thing with it as of
2.4.18 + acpismp=force. Autodetect should be in soon. I don't know about
Intel's future product plans for HT.

Alan
