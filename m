Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270876AbUJVJFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270876AbUJVJFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270885AbUJVJFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:05:54 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:18890 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S270876AbUJVJAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:00:04 -0400
Date: Fri, 22 Oct 2004 10:59:45 +0200 (CEST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-2go.math.uni-giessen.de
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <200409241315.42740.andrew@walrond.org>
Message-Id: <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241041.08975.andrew@walrond.org>
 <Pine.LNX.4.58.0409242126450.16306@fb07-calculator.math.uni-giessen.de>
 <200409241315.42740.andrew@walrond.org>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Andrew Walrond (AW) wrote:

AW> On Friday 24 Sep 2004 12:42, you wrote:
AW> >
AW> > NUMA was enabled all the time (at least most of the time). I don't know if
AW> > I ever ran it without NUMA. I'll certainly try that.
AW> >
AW> > Unfortunately, I won't be able to do any reboots during the next one or
AW> > two weeks since the machine has gone into stable operation tonight. (with
AW> > some loss of memory for now)
AW> >
AW> > if it is of some interest, that's what dmesg tells about NUMA:
AW> >
AW> >      BIOS-provided physical RAM map:
AW> >       BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
AW> >       BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
AW> >       BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
AW> >       BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
AW> >       BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
AW> >       BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
AW> >       BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
AW> >       BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
AW> >      Scanning NUMA topology in Northbridge 24
AW> >      Number of nodes 2 (10010)
AW> >      Node 0 MemBase 0000000000000000 Limit 000000013fffffff
AW> >      Skipping disabled node 1
AW> >      Using node hash shift of 24
AW> >      Bootmem setup node 0 0000000000000000-000000013fffffff
AW> >      No mptable found.
AW> >      On node 0 totalpages: 1310719
AW> >        DMA zone: 4096 pages, LIFO batch:1
AW> >        Normal zone: 1306623 pages, LIFO batch:16
AW> >        HighMem zone: 0 pages, LIFO batch:1
AW> >
AW> > So actually it looks like the kernel well notices that only one processor
AW> > has access to the memory here.
AW> >
AW> 
AW> Intriguing. If it works with NUMA disabled, it would strongly indicate a bug 
AW> in the NUMA kernel code.

Now I have some good news (that is, I hope that this is good news)

If I disable NUMA in 2.6.8.1, it works stable!

The same with 2.6.9, which is out for a few days: if NUMA is disabled,
everything's find, if NUMA is enabled, the kernel crashes (as described in
previous mails)

What is this NUMA by the way? Is it OK to live without? 

If you need some additional output, let me know. I can't promise to be
fast, though (as I said, this machine is in production use now)


Thanks for all help,

        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
