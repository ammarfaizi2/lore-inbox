Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbULZDgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbULZDgl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 22:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbULZDgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 22:36:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:18345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261608AbULZDgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 22:36:40 -0500
Date: Sat, 25 Dec 2004 19:36:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: Ho ho ho - Linux v2.6.10
In-Reply-To: <41CE282C.3010606@tmr.com>
Message-ID: <Pine.LNX.4.58.0412251934090.2353@ppc970.osdl.org>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
 <41CE282C.3010606@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Dec 2004, Bill Davidsen wrote:
> 
> Alas, It sort-of boots but is terminally slow. I see the log with 
> endless repetitions of "irq 18 nobody cared" and some trace, then 
> "disabling irq 18." Unfortunately it lies, after about 20MB of this I 
> decided it had no real intention of disabling irq 18 and tried to stop 
> it. After ten minutes I had to pull the plug and it's still cleaning 
> filesystems.

Can you send a (normal) dmesg output for this machine, and describe what 
is normally on irq18?

It _sounds_ like it's a confusion between level and edge, with the usual 
suspects. Does it go away if you disable acpi?

		Linus
