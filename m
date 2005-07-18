Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVGRQKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVGRQKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 12:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVGRQKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 12:10:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:31464 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261798AbVGRQKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 12:10:43 -0400
Subject: Re: ANNOUNCE: Driver for Rocky 4782E WDT and pls help
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gyorgy Horvath <horvaath@alpha.tmit.bme.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42DC2871.1030103@alpha.tmit.bme.hu>
References: <42DC2871.1030103@alpha.tmit.bme.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Jul 2005 17:34:26 +0100
Message-Id: <1121704467.12438.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-07-18 at 15:08 -0700, Gyorgy Horvath wrote:
>    - Half of the RAM were stolen from Linux.
>      (mem=xxxx kernel parameter)
>      This range was requeset_mem_region-ed, then
>      ioremap-ped for bus mastering DMA transfer.
>      Actually 30 M is used.

Did you make sure none of that is ACPI owned in the E820 map and that if
you set any cache properties they match and are consistent with any
Linux pagetable uses ?

>    - Issuing a simple ls -la / surelly causes instant death.

Is this also true with ide=nodma ?

>    hardware bug. None. I feel it.  Although I noticed that
>    someone (not me) takes control of the PC - time to time -
>    for cca. 400..500 usec so that no DMA can occur.

Probably SMM firmware. Make sure you have USB driver loaded. Consider
turning ACPI and APM off

>    Moreover, I have applied a breakpoint to sscanf in the
>    shared.o. Disassembling the the code causes sudden death
>    at a given point. The code portions were not executed, just
>    disassembled. What the hell is that?

Smells like broken hardware.

