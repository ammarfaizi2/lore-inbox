Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268707AbUIXMPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268707AbUIXMPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268708AbUIXMPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:15:47 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:45258 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S268707AbUIXMPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:15:44 -0400
From: Andrew Walrond <andrew@walrond.org>
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
Subject: Re: lost memory on a 4GB amd64
Date: Fri, 24 Sep 2004 13:15:42 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <200409241041.08975.andrew@walrond.org> <Pine.LNX.4.58.0409242126450.16306@fb07-calculator.math.uni-giessen.de>
In-Reply-To: <Pine.LNX.4.58.0409242126450.16306@fb07-calculator.math.uni-giessen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241315.42740.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 Sep 2004 12:42, you wrote:
>
> NUMA was enabled all the time (at least most of the time). I don't know if
> I ever ran it without NUMA. I'll certainly try that.
>
> Unfortunately, I won't be able to do any reboots during the next one or
> two weeks since the machine has gone into stable operation tonight. (with
> some loss of memory for now)
>
> if it is of some interest, that's what dmesg tells about NUMA:
>
>      BIOS-provided physical RAM map:
>       BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>       BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>       BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>       BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
>       BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
>       BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
>       BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
>       BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
>      Scanning NUMA topology in Northbridge 24
>      Number of nodes 2 (10010)
>      Node 0 MemBase 0000000000000000 Limit 000000013fffffff
>      Skipping disabled node 1
>      Using node hash shift of 24
>      Bootmem setup node 0 0000000000000000-000000013fffffff
>      No mptable found.
>      On node 0 totalpages: 1310719
>        DMA zone: 4096 pages, LIFO batch:1
>        Normal zone: 1306623 pages, LIFO batch:16
>        HighMem zone: 0 pages, LIFO batch:1
>
> So actually it looks like the kernel well notices that only one processor
> has access to the memory here.
>

Intriguing. If it works with NUMA disabled, it would strongly indicate a bug 
in the NUMA kernel code.

Definately worth a try as soon as you can afford to take the machine down for 
a few minutes.

Andrew
