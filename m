Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTLFE3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 23:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTLFE3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 23:29:14 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:17629 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S264917AbTLFE3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 23:29:12 -0500
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
From: Stian Jordet <liste@jordet.nu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031206030755.GI8039@holomorphy.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>
	 <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au>
	 <20031206030755.GI8039@holomorphy.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1070684918.7934.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 05:28:38 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lør, 06.12.2003 kl. 04.07 skrev William Lee Irwin III:
> On Sat, Dec 06, 2003 at 01:48:54PM +1100, Nick Piggin wrote:
> > Although in this case Colin has 2 PPro 200s.
> > Colin - process load should be evenly distributed between CPUs, and this
> > is generally the most important thing. Big networking loads (most commonly)
> > can put a lot of time into processing interrupts though.
> 
> That is rather busted, then.

Uhm.. I was under the impression that this was expected behaviour? If
not, I guess I'm having problems too?

           CPU0       CPU1
  0:   91068534         45    IO-APIC-edge  timer
  1:      65293          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:         71          1    IO-APIC-edge  serial
  8:     325118          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:     245619          1    IO-APIC-edge  ide0
 15:         21          2    IO-APIC-edge  ide1
 17:     444526          0   IO-APIC-level  aic7xxx, EMU10K1
 18:       1112          0   IO-APIC-level  aic7xxx, yenta
 19:    6427306          1   IO-APIC-level  saa7134[0], yenta, eth0,
ide2
 21:      34725    9049384   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd
NMI:          0          0
LOC:   91065099   91064973
ERR:          0
MIS:          2

This is with an uptime of almost 26 hours. Dual P3. USB uses lots of
interrupts from both cpu's, but I'm running both the aic7xxx and eth0
quite hard at times...

Best regards,
Stian

