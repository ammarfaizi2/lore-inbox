Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265732AbUFSNtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUFSNtw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUFSNtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:49:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:58759 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265732AbUFSNtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:49:40 -0400
Date: Sat, 19 Jun 2004 15:49:34 +0200 (MEST)
Message-Id: <200406191349.i5JDnY5n029533@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, util@deuroconsult.ro
Subject: Re: Another mtrr - BIOS-e820 mismatch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 10:51:12 +0300 (EEST), Catalin BOIE wrote:
>Yesterday I read about a mtrr - BIOS-e820 mismatch.
>So I check on a server and I think I find a mismatch:
>2048MB - 1 = 7FFFFFFF, but at 0x7ff80000 there is 512 uncacheable memory.
>Am I right?
>
>Thanks!
>
>It's a Intel MB, with 2 Pentium 4, with HT, 2GB RAM.
>(Sorry I could not get more info.)
>
>reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
>reg01: base=0x7ff80000 (2047MB), size= 512KB: uncachable, count=1
>
>BIOS-provided physical RAM map:
>BIOS-e820: 0000000000000000 - 000000000009b400 (usable)
>BIOS-e820: 000000000009b400 - 00000000000a0000 (reserved)
>BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
>BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
>BIOS-e820: 000000007ff70000 - 000000007ff7b000 (ACPI data)
>BIOS-e820: 000000007ff7b000 - 000000007ff80000 (ACPI NVS)
>BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
>BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
>BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)

Not a problem. All "usable" memory is cacheable, which
is what matters for performance. You did lose some RAM
in the e820 map, but that's a relatively minor issue.
