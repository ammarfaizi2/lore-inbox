Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131096AbRAKLlz>; Thu, 11 Jan 2001 06:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131045AbRAKLlp>; Thu, 11 Jan 2001 06:41:45 -0500
Received: from chiara.elte.hu ([157.181.150.200]:58893 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130892AbRAKLlh>;
	Thu, 11 Jan 2001 06:41:37 -0500
Date: Thu, 11 Jan 2001 12:41:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Nathan Walp <faceprint@faceprint.com>, Hans Grobler <grobh@sun.ac.za>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.0-ac5 
In-Reply-To: <1605.979211755@redhat.com>
Message-ID: <Pine.LNX.4.30.0101111238190.6227-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Jan 2001, David Woodhouse wrote:

> The bug here seems to be that we're using the same bit
> (X86_FEATURE_APIC) to report two _different_ features.

i think that the AMD APIC is truly 'compatible', but we are trying to
enable the APIC and program performance counters in an Intel-way. The MSRs
can be incompatible between steppings of the same CPU, so we should not
mark something 'incompatible' on that basis.

so the correct statement is: the UP-P6-specific way of enabling APICs does
not work on Athlons. It doesnt work on P5's either.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
