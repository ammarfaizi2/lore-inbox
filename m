Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266046AbRGCXEM>; Tue, 3 Jul 2001 19:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266048AbRGCXEC>; Tue, 3 Jul 2001 19:04:02 -0400
Received: from [216.156.138.34] ([216.156.138.34]:36365 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S266046AbRGCXDw>;
	Tue, 3 Jul 2001 19:03:52 -0400
Message-ID: <3B424F39.C3E84913@colorfullife.com>
Date: Wed, 04 Jul 2001 01:03:21 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdlab.org>, linux-kernel@vger.kernel.org
Subject: Re: Sticky IO-APIC problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> This shows that Linux mapped the APIC (part of the processor).
> It says nothing about mapping any IO APICs (unless you deleted
> that part :).
> 
Correct. Linux always enables the APIC, but it needs some bios tables
for the IO APIC. And the IO APIC is not present on all uniprocessor
motherboards.

> So, how does one know if a (UP) system has an IO APIC and that
> Linux can be configured to use the UP IO APIC code?...

Figure out which ICH is used (lspci?), then check Intel's documentation.

But even if an io apic is present, Linux can only use it if a MP table
is present. Afaik ACPI tables are not yet supported on i386, but ia64
already supports detecting the IO APIC's based on ACPI tables.

--
	Manfred
