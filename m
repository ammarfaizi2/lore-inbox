Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRDJSYh>; Tue, 10 Apr 2001 14:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRDJSY1>; Tue, 10 Apr 2001 14:24:27 -0400
Received: from front2.grolier.fr ([194.158.96.52]:44505 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S131308AbRDJSYS> convert rfc822-to-8bit; Tue, 10 Apr 2001 14:24:18 -0400
Date: Tue, 10 Apr 2001 17:13:03 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Jim Studt <jim@federated.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx and 2.4.3 failures - fix, it is interrupt routing
In-Reply-To: <200104092212.RAA11802@core.federated.com>
Message-ID: <Pine.LNX.4.10.10104101706280.1373-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Apr 2001, Jim Studt wrote:

> G*rard Roudier insightfully opined..
> > Looks like an IRQ problem to me.
> > I mean the kernel wants to change IRQ routing and just do the wrong job.
> 
> Give the man a prize!  
> 
> After failing to work with 2.4.0, 2.4.1, 2.4.3, and 2.4.3-ac3 I
> enabled X86_UP_IOAPIC to stir up the interrupt code and it works.
> 
> I'll keep one of these servers set aside for testing and see if I can't
> figure out a little more specifically what the problem is, but IOAPIC
> is fine.  

Probably because the code that messes with IRQs isn't involved when IOAPIC
is used. If I had to guess I would point "arch/i386/kernel/pci-irq.c",
function "pcibios_lookup_irq()".

  Gérard.

