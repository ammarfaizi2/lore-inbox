Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUCXKuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbUCXKuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:50:39 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:24786 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S263227AbUCXKug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:50:36 -0500
Date: Wed, 24 Mar 2004 02:50:32 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: apic errors and looping with 2.4, none with 2.2 (supermicro/serverworks
 LE chipset)
In-Reply-To: <Pine.LNX.4.58.0403230420000.25095@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.58.0403240011150.21019@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0403230420000.25095@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've rebooted with noapic and nolapic and the machine seemed to be stable
for a while.  Then I got:

Mar 24 00:27:08 dahlia kernel: APIC error on CPU1: 00(02)
Mar 24 00:27:08 dahlia kernel: APIC error on CPU0: 00(02)
Mar 24 00:27:08 dahlia kernel: spurious APIC interrupt on CPU#0, should never happen.
Mar 24 00:27:13 dahlia kernel: APIC error on CPU1: 02(08)
Mar 24 00:27:13 dahlia kernel: APIC error on CPU0: 02(08)
Mar 24 00:28:07 dahlia kernel: APIC error on CPU1: 08(02)
Mar 24 00:28:07 dahlia kernel: APIC error on CPU0: 08(02)
Mar 24 00:28:07 dahlia kernel: APIC error on CPU0: 02(08)
Mar 24 00:28:07 dahlia kernel: APIC error on CPU0: 08(02)
Mar 24 00:28:07 dahlia kernel: APIC error on CPU1: 02(0a)

I added nosmp to the lilo append line and rebooted.

noapic, nolapic, and nosmp seems to be stable.  I haven't had anything
logged in the last 2 hours.  Are there known APIC or SMP problems with
serverworks LE chipsets or supermicro motherboards and 2.4?  What are the
steps to troubleshooting an APIC problem?


-Chris

On Tue, 23 Mar 2004, Chris Stromsoe wrote:

> I have one machine that won't run 2.4.  As soon as a 2.4 kernel boots, it
> starts throwing APIC errors.
>
> The machine is a dual CPU pIII 933MHz system with 512Mb ram on a
> SuperMicro motherboard, either a P3TDLR or a 370DLR, with the ServerWorks
> LE chipset.  I'm booting using lilo with append="noapic".
>
> As soon as I boot into a 2.4 kernel, I start getting APIC errors on both
> CPUs.  Varying combinations of:
>
> Mar 23 00:40:45 dahlia kernel: APIC error on CPU0: 02(08)
> Mar 23 00:40:45 dahlia kernel: APIC error on CPU1: 01(08)
> Mar 23 00:45:45 dahlia kernel: APIC error on CPU1: 08(08)
> Mar 23 00:45:45 dahlia kernel: APIC error on CPU0: 08(08)
> Mar 23 00:58:27 dahlia kernel: APIC error on CPU0: 08(01)
> Mar 23 00:58:27 dahlia kernel: APIC error on CPU1: 08(02)
> Mar 23 01:04:54 dahlia kernel: APIC error on CPU1: 02(02)
> Mar 23 01:04:54 dahlia kernel: APIC error on CPU0: 01(02)
> Mar 23 01:05:46 dahlia kernel: APIC error on CPU1: 02(08)
> Mar 23 01:05:46 dahlia kernel: APIC error on CPU0: 02(08)
> Mar 23 01:08:37 dahlia kernel: APIC error on CPU1: 08(02)
> Mar 23 01:08:37 dahlia kernel: APIC error on CPU0: 08(02)
> Mar 23 01:11:04 dahlia kernel: APIC error on CPU1: 02(02)
> Mar 23 01:11:04 dahlia kernel: APIC error on CPU0: 02(0a)
> Mar 23 01:11:04 dahlia kernel: APIC error on CPU1: 02(08)
> Mar 23 01:25:45 dahlia kernel: APIC error on CPU1: 08(08)
> Mar 23 01:25:45 dahlia kernel: APIC error on CPU0: 0a(08)
>
> After a few hours of uptime, the box stops responding to keyboard input.
> It begins printing the above messages to console over and over.  I have
> several other identical machines that I received in the same batch that
> run 2.4 without any problems (though they do seem to require "noapic").
>
> It runs fine with 2.2 and is running 2.2.26 right now.
>
> The machine is not in production use and can be used to test.  Any ideas
> for what I should look at?
>
>
> -Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
