Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbTANVHv>; Tue, 14 Jan 2003 16:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbTANVHv>; Tue, 14 Jan 2003 16:07:51 -0500
Received: from smtp.efrei.fr ([194.2.204.37]:19984 "EHLO smtp.efrei.fr")
	by vger.kernel.org with ESMTP id <S265262AbTANVHu>;
	Tue, 14 Jan 2003 16:07:50 -0500
Date: Tue, 14 Jan 2003 22:16:42 +0100
From: Guillaume Allard <allard@efrei.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 - 2.4.20 : Boot parameter MEM= doesn't work anymore
Message-ID: <20030114211642.GA20452@efrei.fr>
References: <20030114133944.GB8978@efrei.fr> <20030114143854.GA4289@altium.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114143854.GA4289@altium.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 03:38:54PM +0100, Dick Streefland wrote:
> For some reason, the interpretation of the mem= kernel parameter was
> changed. I ran into this myself. The value is now used to limit the
> memory size, not overrule it. There is a different syntax for adding
> memory. One of my computers has 128 Mb, of which only 64 Mb are
> detected. I had to add the "mem=63m@65m" kernel parameter, resulting in:
> 
> [...]
> 
> Unfortunately, this is not documented. Look at arch/i386/kernel/setup.c
> for details.
> 
Thank you for your answer Dick. I tried to add the "mem=47m@17m" kernel
parameter (only 16M are found so 48 need to be forced) even if the
reason why wee need to start from "the next meg" and to add only X-1M is
not realy clear for me. Now it actualy force 64MB so it's ok.
Thank you again.

------ kern.log
 klogd 1.4.1#10, log source = /proc/kmsg started.
 Inspecting /boot/System.map-2.4.20
 Loaded 17390 symbols from /boot/System.map-2.4.20.
 Symbols match kernel version 2.4.20.
 Loaded 23 symbols from 4 modules.
 Linux version 2.4.20 (root@orion) (gcc version 2.95.4 20011002 (Debian
 prerelease)) #1 Tue Jan 14 19:21:24 CET 2003
 BIOS-provided physical RAM map:
  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
 64MB LOWMEM available.
 On node 0 totalpages: 16384
 zone(0): 4096 pages.
 zone(1): 12288 pages.
 zone(2): 0 pages.
 Kernel command line: auto BOOT_IMAGE=Linux ro root=802 mem=47m@17m
------

-- 
     Guillaume Allard
     EFREI - promo 2002
     allard@efrei.fr
