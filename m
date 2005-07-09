Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbVGIIAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbVGIIAz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 04:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbVGIIAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 04:00:55 -0400
Received: from smtpauth03.mail.atl.earthlink.net ([209.86.89.63]:57757 "EHLO
	smtpauth03.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S263164AbVGIIAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 04:00:53 -0400
From: Sheo Shanker Prasad <ssp@creativeresearch.org>
Organization: Creative Research Enterprises
To: linux-kernel@vger.kernel.org
Subject: /proc/mtrr & BIOS-provided RAM map
Date: Sat, 9 Jul 2005 01:00:54 -0700
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507090100.54319.ssp@creativeresearch.org>
X-ELNK-Trace: c9e54813b5d7ed8a1e28108c03118538416dc04816f3191cb436338f62802c0a55181b3b5cad5b12fbd99404859df331350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.4.45.120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a horrible problem of wild and random variation in execution time 
of of a benchmark test program from one fresh reboot to another fresh reboot 
(and also from one try to another in any one reboot).

At the advice of a few colleagues at linux-kernel@vger.kernel.org and at 
use-amd64@suse.com (who very kindly spared their valuable time to give me 
some advice), I tried booting with mem=4000M, mem= 3264, mem=3000M and 
mem=2000M (i.e, a value that is less than the actual RAM (4096M PC3200 in 4 
dimms with 2 dimms on each CPU that is an Opteron 250 at 2.4 GHz) that are 
under the control of SuSE 9.3 operating system.

None of the setting has helped. I continue to get the same wild and random 
variation in the execution of the test program under identical conditions 
(test program is the only program running, no Internet etc.).

Also, no matter what is set for xxxx in mem=xxxxM ,  the contents of 
the /proc/mtrr & and the BIOS provide RAM map remain exactly the same 
(although the dmesg shows the amount of memory change with the value of xxxx 
in mem=xxxxM).

Is this normal? Does this show any BIOS problem? What these are telling me.

I will greatly appreciate any advice that any one may have for me on the above 
questions. The following are the contents of /proc/mtrr and the BIOS provided 
RAM map.

(1) content of /proc/mtrr :

reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 128MB: write-back, count=1
reg03: base=0xc8000000 (3200MB), size=  64MB: write-back, count=1
reg04: base=0xd0000000 (3328MB), size= 256MB: write-combining, count=2

(2) BIOS provided RAM map:

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cbff0000 (usable)
 BIOS-e820: 00000000cbff0000 - 00000000cbfff000 (ACPI data)
 BIOS-e820: 00000000cbfff000 - 00000000cc000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)

Thanks for your help.
-- 
Best regards.

Sheo
(Sheo S. Prasad)
Creative Research Enterprises
6354 Camino del Lago
Pleasanton, CA 94566, USA
Voice Phone: (+1) 925 426-9341
Fax   Phone: (+1) 925 426-9417
e-mail: ssp@CreativeResearch.org

