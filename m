Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbQL1RyQ>; Thu, 28 Dec 2000 12:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbQL1Rx4>; Thu, 28 Dec 2000 12:53:56 -0500
Received: from dsl081-135-024-nyc1.dsl-isp.net ([64.81.135.24]:44811 "EHLO
	monolith") by vger.kernel.org with ESMTP id <S131020AbQL1Rxt>;
	Thu, 28 Dec 2000 12:53:49 -0500
To: fpieraut@casi.polymtl.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: Activating APIC on single processor
In-Reply-To: <Pine.LNX.4.10.10012281242140.9711-100000@thales.casi.polymtl.ca>
From: David Huggins-Daines <dhd@eradicator.org>
Organization: None worth mentioning
Date: 28 Dec 2000 12:15:45 -0500
In-Reply-To: <fpieraut@casi.polymtl.ca>'s message of "Thu, 28 Dec 2000 17:00:15 GMT"
Message-ID: <87ae9g8o1q.fsf@monolith.cepstral.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<fpieraut@casi.polymtl.ca> writes:

> I activate APIC interruption with the configuration of linux kernel
> 2.4.0test-11. In the linux kernel configuration under processor type and
> features I activate "APIC and IO-APIC support on uniprocessor",  and I
> desactivate "Symmetric multi-processing support". The only way I found to
> check APIC activation is looking into /proc/interrupts, no "IO-APIC" can
> be found there. So I read IO-APIC.txt and I suppose there sould be
> conflicts with IRQ of my PCI cards. So I remove all my PCI cards and still
> have no APIC interrupt. 
> Is there another way to check APIC activation? 
> Am-I doing to right things to activate IO-APIC?

You might not actually have an IO-APIC or even a local APIC.  This is
the case with the Mobile PIII for instance (I puzzled over this myself
for a long time).

To find out for sure, run:

grep 'flags.*apic' /proc/cpuinfo

-- 
David Huggins-Daines		-		dhd@eradicator.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
