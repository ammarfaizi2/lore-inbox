Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRJVH6n>; Mon, 22 Oct 2001 03:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278077AbRJVH6d>; Mon, 22 Oct 2001 03:58:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45575 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278076AbRJVH6U>; Mon, 22 Oct 2001 03:58:20 -0400
Subject: Re: Linux 2.4.12-ac5
To: rml@tech9.net (Robert Love)
Date: Mon, 22 Oct 2001 09:05:07 +0100 (BST)
Cc: reality@delusion.de (Udo A. Steinberg), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel),
        laughing@shared-source.org
In-Reply-To: <1003714021.1014.144.camel@phantasy> from "Robert Love" at Oct 21, 2001 09:26:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15va55-00017E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You aren't crazy, it doesn't build here either.  The problem is that
> fixmap.h only includes those defines if CONFIG_IO_APIC is defined. 
> Well, I don't have use IO_APIC (I am UP) but I do define
> CONFIG_X86_APIC.  So it does not compile.

Ahah that would make sense.

> So, the problem is that acpitable.c assumes you have both CONFIG_IO_APIC
> and CONFIG_X86_APIC declared.  It shouldn't.  Even more important, why
> is my system compiling acpitable.c now?  I don't compile anything to do
> with ACPI.  What needs access to the ACPI tables via Mini-ACPI, now?

It is needed for a small number of certain newer SMP systems, and
potentially a lot more stuff in the near future.

Alan

