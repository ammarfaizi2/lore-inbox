Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTKCU3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTKCU3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:29:34 -0500
Received: from ale.atd.ucar.edu ([128.117.80.15]:52659 "EHLO ale.atd.ucar.edu")
	by vger.kernel.org with ESMTP id S262937AbTKCU3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:29:32 -0500
From: "Charles Martin" <martinc@ucar.edu>
To: <linux-kernel@vger.kernel.org>
Cc: "'Charles Martin'" <martinc@ucar.edu>
Subject: RE: interrupts across  PCI bridge(s) not handled
Date: Mon, 3 Nov 2003 13:29:25 -0700
Message-ID: <000001c3a249$2f9f30a0$c3507580@atdsputnik>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0311031218250.20373-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@osdl.org] 
> Sent: Monday, November 03, 2003 1:23 PM
> To: Charles Martin
> Cc: linux-kernel@vger.kernel.org; martinc@atd.ucar.edu
> Subject: RE: interrupts across PCI bridge(s) not handled
> 
> 
> 
> On Mon, 3 Nov 2003, Charles Martin wrote:
> > 
> > I enabled APIC_DEBUG, and here is the dmesg output.
> 
> Hmm..
> 
> The MP tables mention IRQ's up to 51, but no further.
> 
> But the PIRQ routing tables talk about irqs 92-95 for bus 6.
> 
> It really looks like the IRQ routing entries are just broken. One 
> potential fix is to enable ACPI, and hope that the ACPI irq 
> routing isn't 
> as broken as the PIRQ stuff.
> 
> Other than that I don't see anything we can do. Anybody else?
> 
> 		Linus
> 
> 

I do notice that bus #6, which is the backplane extender,
has an APIC id of 0, but an APIC #0 was not enumerated. All other
buses get assigned to the identified APICs of 8, 9 and 10. 

Charlie

