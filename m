Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTKLLJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 06:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTKLLJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 06:09:53 -0500
Received: from intra.cyclades.com ([64.186.161.6]:46274 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261936AbTKLLJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 06:09:51 -0500
Date: Wed, 12 Nov 2003 09:02:17 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Shane Wegner <shane-dated-1071003928.b2036e@cm.nu>
Cc: linux-kernel@vger.kernel.org, <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.23 crash on Intel SDS2
In-Reply-To: <20031109210527.GA1936@cm.nu>
Message-ID: <Pine.LNX.4.44.0311120857020.14144-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Nov 2003, Shane Wegner wrote:

> Hi,
> 
> I posted some weeks ago regarding a crash I was
> experiencing with 2.4.23-pre4.  I am just writing to
> confirm that 2.4.23-pre9 is still unable to run relyably on
> this machine.  In my earlier post, I thought acpi might be
> the culprit as I had it enabled due to a bios bug.  Intel
> since fixed that so I was able to boot 2.4.23-pre9 with
> acpi totally disabled in make config.
> 
> The problem is that after some time, usually between 30
> seconds and 15 minutes in, the system locks up.  Nothing
> gets printed into the kernel logs or onto the console. 
> After 60 seconds, the IPMI watchdog kicks in and reboots
> the system.  I run Linux 2.4.22 over here with no problems
> with and without acpi.
> 
> It's an Intel server board model SDS2 with a dual Pentium
> III tualatin 1.13ghz.  I am attaching the dmesg output from
> the kernel in case it is helpful but as there is no panics
> or oops being printed, I am not sure how best I can help
> track this down.  If there is anything further I can do or
> any other information needed, let me know.

> On node 0 totalpages: 262144
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 32768 pages.

What do you (what is your workload) during the few minutes before the
crash?

There are no significant driver changes in -pre4 that could affect you.

Can you please try with mem=900M? I suspect something in the VM changes
might be causing this.



