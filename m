Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUENHmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUENHmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 03:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbUENHmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 03:42:55 -0400
Received: from zork.zork.net ([64.81.246.102]:26761 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265119AbUENHmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 03:42:53 -0400
To: Andi Kleen <ak@suse.de>
Cc: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
References: <20040513032736.40651f8e.akpm@osdl.org>
	<6usme4v66s.fsf@zork.zork.net> <20040513135308.GA2622@redhat.com>
	<20040513155841.6022e7b0.ak@suse.de> <6ulljwtoge.fsf@zork.zork.net>
	<20040513174110.5b397d84.ak@suse.de>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, davej@redhat.com,  akpm@osdl.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 14 May 2004 08:42:47 +0100
In-Reply-To: <20040513174110.5b397d84.ak@suse.de> (Andi Kleen's message of
 "Thu, 13 May 2004 17:41:10 +0200")
Message-ID: <6u8yfvsbd4.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Sean, can you double check that when you compile the AGP driver as module
> that the 7124 PCI ID appears in modinfo intel-agp ? 
> And does the module also refuse to load ? 

I rebuilt with agpgart, intel-agp and i810 as modules, modprobed them,
and it works.

  Linux agpgart interface v0.100 (c) Dave Jones
  agpgart: Detected an Intel i810 E Chipset.
  agpgart: Maximum main memory to use for agp memory: 320M
  agpgart: detected 4MB dedicated video ram.
  agpgart: AGP aperture is 64M @ 0xf8000000
  [drm] Initialized i810 1.4.0 20030605 on minor 0: Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller]

Very odd.

Here is the modinfo output for intel-agp.

  author:         Dave Jones <davej@codemonkey.org.uk>
  license:        GPL and additional rights
  vermagic:       2.6.6-mm2 preempt PENTIUMIII REGPARM 4KSTACKS gcc-3.4
  depends:        agpgart
  alias:          pci:v00008086d*sv*sd*bc06sc00i00*

