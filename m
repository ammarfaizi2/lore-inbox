Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUCZBSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbUCZBPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 20:15:14 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:43480 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S263833AbUCZBNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 20:13:18 -0500
Date: Thu, 25 Mar 2004 17:09:57 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: apic errors and looping with 2.4, none with 2.2 (supermicro/serverworks
 LE chipset)
In-Reply-To: <Pine.LNX.4.55.0403251418340.11552@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0403251708310.9801@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0403230420000.25095@potato.cts.ucla.edu>
 <Pine.LNX.4.58.0403240011150.21019@potato.cts.ucla.edu> <20040324212759.GD6572@logos.cnet>
 <Pine.LNX.4.55.0403251418340.11552@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Maciej W. Rozycki wrote:
> On Wed, 24 Mar 2004, Marcelo Tosatti wrote:
>
> > Maybe Maciej or Mikael have more clue of what might be happening.
> >
> > On Wed, Mar 24, 2004 at 02:50:32AM -0800, Chris Stromsoe wrote:
> > > I've rebooted with noapic and nolapic and the machine seemed to be
> > > stable for a while.  Then I got:
> > >
> > > Mar 24 00:27:08 dahlia kernel: APIC error on CPU1: 00(02)
> > > Mar 24 00:27:08 dahlia kernel: APIC error on CPU0: 00(02)
> > > Mar 24 00:27:08 dahlia kernel: spurious APIC interrupt on CPU#0, should never happen.
> > > Mar 24 00:27:13 dahlia kernel: APIC error on CPU1: 02(08)
> > > Mar 24 00:27:13 dahlia kernel: APIC error on CPU0: 02(08)
> [...]
> > > I added nosmp to the lilo append line and rebooted.
> > >
> > > noapic, nolapic, and nosmp seems to be stable.  I haven't had
> > > anything logged in the last 2 hours.  Are there known APIC or SMP
> > > problems with serverworks LE chipsets or supermicro motherboards and
> > > 2.4?  What are the steps to troubleshooting an APIC problem?
>
>  As long as you boot more than a single CPU, local APIC units are used
> at least to send IPIs.  The error messages you see report receive
> checksum and receive acceptance errors.  The latters result from the
> formers and all of them, including the spurious APIC interrupt are
> results of signal errors (noise?) during a transmission over the
> inter-APIC serial bus.  This is a hardware problem.  I'd start by
> checking the power supply first.


The only way that I've been able to boot and stay up is with nosmp,
noapic, and nolapic.  I'll try replacing the power supply and see if that
helps things out.  It's going to take me a few days to get a replacement
-- is there anything else that I should check while I'm waiting?



-Chris


> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
>
