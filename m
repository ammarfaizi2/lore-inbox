Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbTLHLgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 06:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbTLHLgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 06:36:53 -0500
Received: from legolas.restena.lu ([158.64.1.34]:29160 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265390AbTLHLgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 06:36:51 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Craig Bradney <cbradney@zip.com.au>
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org, recbo@nishanet.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <200312081321.06692.ross@datscreative.com.au>
References: <200312081321.06692.ross@datscreative.com.au>
Content-Type: text/plain
Message-Id: <1070883402.17639.115.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 12:36:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 04:21, Ross Dickson wrote:
> On Monday 08 of December 2003 04:08, Bob wrote: 
>  > >>Sounds great.. maybe you have come across something. Yes, the CPU 
>  > >>Disconnect function arrived in your BIOS in revision of 2003/03/27 
>  > >>"6.Adds"CPU Disconnect Function" to adjust C1 disconnects. The Chipset 
>  > >>does not support C2 disconnect; thus, disable C2 function." 
>  > >> 
>  > >>For me though.. Im on an ASUS A7N8X Deluxe v2 BIOS 1007. From what I can 
>  > >>see the CPU Disconnect isnt even in the Uber BIOS 1007 for this ASUS 
>  > >>that has been discussed. 
>  > >> 
>  > >>Craig 
>  > >
>  > >I don't have that in MSI K7N2 MCP2-T near the 
>  > >agp and fsb spread spectrum items or anywhere 
>  >> else. 
> >Use athcool: 
> >         http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool
> > or apply kernel patch (2.4 and 2.6 versions were posted already). 
> >--bart 
> 
> Please take a look at 
> 
> Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
> 
> in mailing list.
> 
> I approached it from another angle regarding delaying the apic ack in local timer irq
> and achieved stability. It would be good to have others try it. Ian Kumlien is also
> reporting success so far.
>  

Although I had long uptimes before.. and therefore might achieve them
again fairly easily.. I'm now on 2 days 10 hours which has included a
lot of compilation and a lot of idle time, and plenty of the hdpar and
grep tests. I have used only the IRQ0 IO-APIC edge patch.

Can someone please note all the patches for 2.6 that people have tried
and what they achieve? Im starting to get a bit lost, given the fact
that I'm running stable here with only 1 patch. (so far - this is where
it crashes after I click Send I suppose ;) )

-apic

-io-apic (IRQO set to XT-PIC incorrectly)

-udma133?

-cpu disconnect patch (missing bios option for ACPI Cx states)

Craig

