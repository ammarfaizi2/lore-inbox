Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUBPXSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUBPXSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:18:16 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:36787 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S266006AbUBPXNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:13:46 -0500
Message-ID: <40314E8B.5060101@oracle.com>
Date: Tue, 17 Feb 2004 00:13:15 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3: radeon blanks screen
References: <402F83D4.3080605@oracle.com> <1076883902.6959.100.camel@gaston>	 <40314311.20708@oracle.com> <1076970420.1053.68.camel@gaston>
In-Reply-To: <1076970420.1053.68.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>OK, here's the debug output part. I'm also attaching gzipped dmesg
>>  in case you need more context.
>>
>>ACPI: AC Adapter [AC] (on-line)
>>ACPI: Battery Slot [BAT0] (battery present)
>>ACPI: Battery Slot [BAT1] (battery absent)
>>ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
>>ACPI: Thermal Zone [THM] (62 C)
>>hStart = 1040, hEnd = 1176, hTotal = 1344
>>vStart = 770, vEnd = 776, vTotal = 806
>>h_total_disp = 0x7f00a7    hsync_strt_wid = 0x11040a
>>v_total_disp = 0x2ff0325           vsync_strt_wid = 0x60301
>>pixclock = 15384
>>freq = 6500
>>lvds_gen_cntl: 080dffa1
>>Console: switching to colour frame buffer device 128x48
>>pty: 256 Unix98 ptys configured
> 
> 
> Make sure you try with Linus latest bk snapshot as some fixes went
> in (along with more debug output) yesterday

2.6.3-rc3-bk1 Works For Me (TM).

I can Alt-Fn through consoles, start X, Ctrl-Alt-Fn again to
  a console, back into X. So far, full success :) good work !

Note that there doesn't appear to be any debug difference at
  all compared to the non-bk -rc3:

[asuardi@incident tmp]$ diff dmesg-263rc3*debug
1c1
< Linux version 2.6.3-rc3-bk1 (asuardi@incident) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Mon Feb 16 23:49:23 CET 2004
---
 > Linux version 2.6.3-rc3-radeondbg (asuardi@incident) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #4 Mon Feb 16 23:10:29 CET 2004
24c24
< Detected 1794.769 MHz processor.
---
 > Detected 1794.807 MHz processor.
27c27
< Memory: 1033216k/1048456k available (2497k kernel code, 14332k reserved, 983k data, 144k init, 130952k highmem)
---
 > Memory: 1033224k/1048456k available (2497k kernel code, 14324k reserved, 980k data, 144k init, 130952k highmem)
54c54
< ACPI Namespace successfully loaded at root c04af21c
---
 > ACPI Namespace successfully loaded at root c04ad21c
181c181
< intel8x0_measure_ac97_clock: measured 49424 usecs
---
 > intel8x0_measure_ac97_clock: measured 49423 usecs



Thanks again ! Ciao,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

