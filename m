Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTKJLUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTKJLUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:20:36 -0500
Received: from aun.it.uu.se ([130.238.12.36]:57062 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263190AbTKJLUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:20:35 -0500
Date: Mon, 10 Nov 2003 12:20:28 +0100 (MET)
Message-Id: <200311101120.hAABKSL7023414@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, shane-keyword-kernel.a35a91@cm.nu
Subject: Re: 2.4.23 crash on Intel SDS2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003 13:05:27 -0800, Shane Wegner wrote:
>I posted some weeks ago regarding a crash I was
>experiencing with 2.4.23-pre4.  I am just writing to
>confirm that 2.4.23-pre9 is still unable to run relyably on
>this machine.  In my earlier post, I thought acpi might be
>the culprit as I had it enabled due to a bios bug.  Intel
>since fixed that so I was able to boot 2.4.23-pre9 with
>acpi totally disabled in make config.
>
>The problem is that after some time, usually between 30
>seconds and 15 minutes in, the system locks up.  Nothing
>gets printed into the kernel logs or onto the console. 
>After 60 seconds, the IPMI watchdog kicks in and reboots
>the system.  I run Linux 2.4.22 over here with no problems
>with and without acpi.
>
>It's an Intel server board model SDS2 with a dual Pentium
>III tualatin 1.13ghz.  I am attaching the dmesg output from
>the kernel in case it is helpful but as there is no panics
>or oops being printed, I am not sure how best I can help
>track this down.  If there is anything further I can do or
>any other information needed, let me know.

Pass "nmi_watchdog=1" to the kernel to enable the
I/O-APIC based NMI watchdog. This should detect any
software (kernel) lockups and produce an oops for them.

Enabling the I/O-APIC NMI watchdog eliminated mysterious
lockups on our Dell PE2650 (dual Xeons, Serverworks chipset).

/Mikael
