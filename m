Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279844AbRKFTej>; Tue, 6 Nov 2001 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279878AbRKFTea>; Tue, 6 Nov 2001 14:34:30 -0500
Received: from air-1.osdl.org ([65.201.151.5]:3970 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S279844AbRKFTeP>;
	Tue, 6 Nov 2001 14:34:15 -0500
Date: Tue, 6 Nov 2001 11:37:24 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ACPI "hlt" mode and SMP systems?
In-Reply-To: <008901c166f8$0063af20$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.33.0111061133250.22170-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Nov 2001, Martin Eriksson wrote:

> When will the equivalence of "hlt" (in APM) work in ACPI SMP systems? Or
> does it already? I have a hard time decoding all the ACPI symbols, such as
> C1 C2 S0 S1 S2 S3 and so on...

"hlt" is equivalent to ACPI processor power state C1,

When ACPI is loaded, it replaces the idle function with its own
(drivers/acpi/ospm/processor/prpower.c::pr_power_idle() ), which places
the processors in lower power states gradually.

I once documented all of the states in a readable format. I will post it
once I get back from lunch...

	-pat

