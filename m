Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUFRHvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUFRHvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 03:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUFRHvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 03:51:15 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:27525 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S265037AbUFRHvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 03:51:13 -0400
Date: Fri, 18 Jun 2004 10:51:12 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: Another mtrr - BIOS-e820 mismatch
Message-ID: <Pine.LNX.4.60.0406181046540.977@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Yesterday I read about a mtrr - BIOS-e820 mismatch.
So I check on a server and I think I find a mismatch:
2048MB - 1 = 7FFFFFFF, but at 0x7ff80000 there is 512 uncacheable memory.
Am I right?

Thanks!

It's a Intel MB, with 2 Pentium 4, with HT, 2GB RAM.
(Sorry I could not get more info.)

reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x7ff80000 (2047MB), size= 512KB: uncachable, count=1

BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009b400 (usable)
BIOS-e820: 000000000009b400 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
BIOS-e820: 000000007ff70000 - 000000007ff7b000 (ACPI data)
BIOS-e820: 000000007ff7b000 - 000000007ff80000 (ACPI NVS)
BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/

