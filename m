Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTLFEsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 23:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTLFEsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 23:48:50 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:27869 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S263299AbTLFEst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 23:48:49 -0500
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
From: Stian Jordet <liste@jordet.nu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031206043757.GJ8039@holomorphy.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>
	 <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au>
	 <20031206030755.GI8039@holomorphy.com>
	 <1070684918.7934.2.camel@chevrolet.hybel>
	 <20031206043757.GJ8039@holomorphy.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1070686126.1166.0.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 05:48:46 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lør, 06.12.2003 kl. 05.37 skrev William Lee Irwin III:
> Yeah, it looks like it hit you too.
> 
> Could you boot with noirqbalance on the kernel commandline and see if
> the problem goes away?

Wow, that actually fixed it :)

           CPU0       CPU1
  0:      65636      63667    IO-APIC-edge  timer
  1:        150        136    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:          2          1    IO-APIC-edge  serial
  8:          3          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:         18         37    IO-APIC-edge  ide0
 15:         16          7    IO-APIC-edge  ide1
 17:       4830       4846   IO-APIC-level  aic7xxx, EMU10K1
 18:        218        210   IO-APIC-level  aic7xxx, yenta
 19:       3307       4259   IO-APIC-level  saa7134[0], yenta, eth0,
ide2
 21:      41562      40666   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd
NMI:          0          0
LOC:     129121     129273
ERR:          0
MIS:          0

This is after about one minute uptime. Thanks :)

Best regards,
Stian

