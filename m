Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbRFRVTT>; Mon, 18 Jun 2001 17:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263318AbRFRVTK>; Mon, 18 Jun 2001 17:19:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:40453 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263257AbRFRVTE>;
	Mon, 18 Jun 2001 17:19:04 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106182118.f5ILIxa187286@saturn.cs.uml.edu>
Subject: Re: very strange (semi-)lockups in 2.4.5
To: george@mvista.com (george anzinger)
Date: Mon, 18 Jun 2001 17:18:59 -0400 (EDT)
Cc: pozsy@sch.bme.hu (Pozsar Balazs), acahalan@cs.uml.edu (Albert D. Cahalan),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3B2E686E.C1BCAA69@mvista.com> from "george anzinger" at Jun 18, 2001 01:45:34 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger writes:
> Pozsar Balazs wrote:

>> The NMI card would be interesting, if anyone tells me how to make
>> one, and how to patch the kernel to show useable information i'm
>> looking forward to do it, and send reports.
>
> Given that your system still handles interrupts:
> a.) It would probably not trigger an NMI timer (the interrupts would
> keep resetting it)

Huh? No, this isn't the NMI timer. It's an NMI you generate
with a pushbutton on the back of your PC. My computer doesn't
have the APIC hardware needed for an NMI timer anyway.

For a PCI card, one must assert the SERR# signal. This is supposed
to be done for 1 clock cycle, on the proper clock edge. Going a bit
beyond 1 clock cycle ought to be OK, but my hand on a button is
likely to assert SERR# for millions of clock cycles. I've no idea
if my motherboard will handle that well.

> b.) Using KGDB will, most likely, be all you need anyway.

I'd rather just get an oops, but even still the board would
be good to have. KGDB can be triggered by an NMI, right?

Building an NMI board would be fun, overkill or not. :-)

> If you have a complete freeze, then the NMI is useful, but even
> here, it is best to let KGDB handle the NMI.  Much easier to see
> what's what than looking thru an OOPS.

I don't have an APIC. I have a plain Pentium MMX. If I want
an NMI it's going to come from a pushbutton.
